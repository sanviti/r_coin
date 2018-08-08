<?php
/**
 * 订单管理
 */
namespace DataAdmin\Controller;
use Think\Controller;
Use Think\Cache\Driver\Redis;

class OrderController extends BaseController {

    public function index(){
        $status  = I('status');
        $order_sn = I('order_sn');
        $userid = I('userid');
        $rname   = I('rname');
        $page = I('get.p');

        $parm = "";
        if($status!=""){
            $where['od.status'] = $status;
            $parm['status'] = $status;
        }
        if($order_sn!=""){
            $where['od.order_sn'] = $order_sn;
            $parm['order_sn'] = $order_sn;
        }
        if (empty($page))
            $page = 1;
        $count = M('shop_order')->alias("od")->where($where)->count();
        $p = getpage($count, C("PAGE_SIZE"),$parm);
        $show = $p->newshow();

        $data = M('shop_order')->alias("od")
            ->field("
    od.order_id,od.order_sn,od.buyer_id,od.order_amount,od.pay_message,od.add_time,od.status,g.goods_name,g.goods_image,extm.consignee,extm.mobile
                ")
            ->join("LEFT JOIN __SHOP_GOODS__ g ON g.order_id = od.order_id")
            ->join('__SHOP_EXTM__ extm ON extm.order_id = od.order_id')
            ->page(I('get.p'))
            ->where($where)
            ->order("add_time DESC")
            ->limit(C('PAGE_SIZE'))
            ->select();

        foreach ($data as $k => $v){
            $data[$k]['status'] = $this->status($v['status']);
        }


        $this->assign('page', $show);
        $this->assign('data',$data);
        $this->display();
    }

    //返回状态值
    private function status($data){

        if ($data == 0){
            $status = '待付款';
        }elseif ($data == 1){
            $status = '待发货';
        }elseif ($data == 2){
            $status = '已发货';
        }elseif ($data == 4){
            $status = '已完成';
        }elseif ($data == 3){
            $status = '待评价';
        }elseif ($data == -1){
            $status = '已取消';
        }elseif ($data == -2){
            $status = '交易关闭';
        }elseif ($data == -3){
            $status = '已删除';
        }elseif ($data == -10){
            $status = '退款中';
        }elseif ($data == -11){
            $status = '退款失败';
        }elseif ($data == -12){
            $status = '退款成功';
        }elseif ($data == -20){
            $status = '退货退款中';
        }elseif ($data == -21){
            $status = '退货退款失败';
        }elseif ($data == -22){
            $status = '退货退款成功';
        }

        return $status;
    }

    //详情
    public function orderprocess(){
        $order_id = I('order_id');

        $where['od.order_id'] = $order_id;
        $order = M('shop_order')->alias("od")
            ->field("
    od.order_id,od.exp_no, od.exp_company, od.ship_time, od.order_sn,od.buyer_id,od.order_amount,od.goods_amount,od.pay_message,od.add_time,od.status,extm.consignee,extm.mobile,extm.region_name,extm.address,extm.shipping_fee
                ")
            ->join('__SHOP_EXTM__ extm ON extm.order_id = od.order_id')
            ->where($where)
            ->find();
        $goods_list = M('shop_goods')->where('order_id = ' . $order_id)->select();
        $company = M('express_company')->select();
        $this->assign('order',$order);
        $this->assign('goods_list',$goods_list);
        $this->assign('company',$company);
        $this->display("process");
    }

    //取消
    public function cancel(){
        $order_id = I('order_id');
        if (!$order_id){
            err('请选择要取消的订单');
        }
        $order = M('shop_order')->where(array('order_id' => $order_id,'status' => 0))->find();
        if (!$order){
            err('该订单不能取消');
        }
        $data['status'] = -1;
        $save = M('shop_order')->where(array('order_id' => $order_id))->save($data);
        if ($save){
            succ('取消成功');
        }
    }

    //确认发货
    public function orderStatus(){
        $order_id = I('orderid');
        $status = I('status');
        $express_no = I('express_no');
        $exp_company = I('company');
        $data['status'] = 2;
        $data['exp_company'] = $exp_company;
        $data['exp_no'] = $express_no;
        $data['ship_time'] = NOW_TIME;
        $save = M('shop_order')->where(array('order_id' => $order_id, 'status' => 1))->save($data);
        if ($save){
            succ('操作成功');
        }else{
            err('操作失败');
        }
    }



}