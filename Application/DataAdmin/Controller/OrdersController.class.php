<?php
/**
 * 订单管理
 */
namespace DataAdmin\Controller;
use Think\Controller;
Use Think\Cache\Driver\Redis;
use Common\Lib\RestSms;
use Common\Lib\Constants;
class OrdersController extends BaseController{

    //首页
    public function index(){

        $order_sn = I('order_sn');
        if($order_sn){
            $params['order_sn'] = $order_sn;
            $condi['ord.order_sn'] = $order_sn;
        }

        $status = I('status');
        if($status !== ''){
            $params['status'] = $status;
            $condi['ord.status'] = $status;
        }

        $pecnum = I('pecnum');
        if($pecnum !== ''){
            $params['pecnum'] = $pecnum;
            $condi['ord.opc'] = $pecnum;
        }

        $type = I('type');
        if($type !== ''){
            $params['type'] = $type;
            $condi['ord.type'] = $type;
        }

        $uid = I('uid');
        if($uid !== ''){
            $params['uid'] = $uid;
            $condi['ord.buy_uid|ord.sell_uid'] = intval(str_ireplace('U', '', $uid));
        }

        $phone = I('phone');
        if($phone !== ''){
            $params['phone'] = $phone;
            $condi['mb1.phone|mb2.phone'] = $phone;
        }

        $page = IS_POST ? 1 : I('get.p');
        $model = D('Orders');
        $count = $model->alias('ord')
        ->join('LEFT JOIN __MEMBERS__ AS mb1 ON mb1.id = ord.buy_uid')
        ->join('LEFT JOIN __MEMBERS__ AS mb2 ON mb2.id = ord.sell_uid')
        -> where($condi) -> count();

        $p = getpage($count, C('PAGE_SIZE'), $params);
        $show = $p -> newshow($params);
        $list = $model->alias('ord')
        ->field('ord.*, mb1.nickname as buy_name, mb2.nickname as sell_name')
        ->join('LEFT JOIN __MEMBERS__ AS mb1 ON mb1.id = ord.buy_uid')
        ->join('LEFT JOIN __MEMBERS__ AS mb2 ON mb2.id = ord.sell_uid')
        -> where($condi) -> page($page) -> limit(C('PAGE_SIZE')) -> order('id DESC') -> select();
       
        $this -> assign('page', $show);
        $this -> assign('list', $list);
        $this -> display();
    }
    
    //订单详情
    public function detail(){
        $id = I('id/d');
        empty($id) && exit;
        $order = M('orders')->where(array('id' => $id))->find();
        empty($order) && exit;
        $buy_user = M('members')->field('userid,nickname,phone')->where(array('id' => $order['buy_uid']))->find();
        $sell_user = M('members')->field('userid,nickname,phone')->where(array('id' => $order['sell_uid']))->find();

        $this->assign('buy_user', $buy_user);
        $this->assign('sell_user', $sell_user);
        $this->assign('order', $order);
        $this->display();
    }
    //撤销订单
    public function undoOrder(){
        $order_id = I('order_id');
        if (!$order_id){
            err('请选择要取消的订单');
        }
        $map_order = array(
            'id' => $order_id,
            'status' => array('IN', '1,2,3,4')
        );
        $mod_order = M('orders');
        $mod_order->startTrans();
        $order = $mod_order->lock(true)->where($map_order)->find();
        if (!$order){
            $mod_order->rollback();
            err('该订单不能撤销');
        }
        $data = array(
            'cancel_time' => NOW_TIME,
            'status' => 102
        );
        //撤销卖出，返还用户RC
        
        //撤销买入，交易状态为匹配成功的返还用户RC
        if ($order['type'] == 2 || ($order['type'] == 1 && $order['status'] == 3)) {
            $memberModel = D('members');
            //手续费
            $fee = new_bcmul($order['opc'], Constants::DEAL_FEE);
            $lockNum = new_bcadd($order['opc'], $fee);
            $memberModel->startTrans();
            $member = $memberModel->lock(true)->where(array('id' => $order['sell_uid']))->find();
            $result = $memberModel->lock2score($member, $lockNum);
            $memberModel->commit();
        }
        
        $result = $mod_order->where($map_order)->save($data);
        $mod_order->commit();
        if ($result){
            $logs = array(
                'logtype' => 2, 'subtype' => 'undo_orders', 'adminname' => $this->_admin['user'],
                'ip' => get_clientIP(), 'ctime' => NOW_TIME,  'memo' => '撤销订单：订单ID[' . $order['id'] . ']', 'adminid' => $this->_admin['id']
            );
            D('ActionLog')->add($logs);
            succ('撤销成功');
        }
        err('操作失败！');
    }


    public function confirmOrder(){
        $order_id = I('order_id');
        if (!$order_id){
            err('请选择要成交的订单');
        }
        $orderModel = M('orders');
        $orderModel->startTrans();
        $map = array('id' => $order_id, 'status' => 4);
        $order = $orderModel->lock(true)->where($map)->find();
        if($order){
            $memberModel = D('Api/members');
            $sell_mem = $memberModel->where(array('id' => $order['sell_uid']))->find();
            $buy_mem  = $memberModel->where(array('id' => $order['buy_uid']))->find();

            if($sell_mem && $buy_mem){
                $upd = array('confirm_time' => NOW_TIME, 'status' => 101);
                $result = $orderModel->where($map)->save($upd);

                //扣币
                $fee = new_bcmul($order['opc'], Constants::DEAL_FEE);
                $decnum = new_bcadd($order['opc'], $fee);
                $result = $result && $memberModel->score_lock_dec($sell_mem, $decnum);


                //加币
                $incnum = $order['opc'];
                $result = $result && $memberModel->score_inc($buy_mem, $incnum);


                if($result){
                    $orderModel->commit();
                    $logs = array(
                        'logtype' => 2, 'subtype' => 'confirm_orders', 'adminname' => $this->_admin['user'],
                        'ip' => get_clientIP(), 'ctime' => NOW_TIME,  'memo' => '强制成交订单：订单ID[' . $order['id'] . ']', 'adminid' => $this->_admin['id']
                    );
                    D('ActionLog')->add($logs);
                    succ('操作成功');
                }else{
                    $orderModel->rollback();
                    err('操作失败');
                }
            }else{
                $orderModel->rollback();
                err('用户不存在');
            }
        }else{
            $orderModel->rollback();
            err('订单不存在');
        }
    }
    //订单申诉
    public function appeal(){

    }
    //申诉详情
    public function appealDet(){

    }
}