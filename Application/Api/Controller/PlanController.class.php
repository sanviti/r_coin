<?php
/**
 * 计划任务
 * 2017-12-15
 * lxy
 */
namespace Api\Controller;
use Think\Log;
use Think\Controller;
use Think\Model;
use Common\Lib\Constants;

class PlanController extends Controller{





    /**
     * 小区分红奖励   每天24点  每分钟1次 每次500人
     * @return [type] [description]
     */
    public function awardOre(){
        set_time_limit(0);
        $plan_name = Constants::PLAN_AWARD_POWER;
        $transNum  = 500;
        //检查锁
        if(checkLock($plan_name)){
            $this->p('runing');
            exit;
        }
        //加锁
        setLock($plan_name, 'add');
        #################开始################

            $memberModel = D('members');
            $membeRegionrModel = D('membersRegion');
            $logModel = M('userScoreLog');
            $todayBegin = mktime(0,0,0,date('m'),date('d'),date('Y'));
            $map = "last_cal_time < {$todayBegin} AND power >= 0.01";
            $lists = $memberModel->field('id')->lock(true)->where($map)->order('id')->limit($transNum)->select();
            if($lists){
                foreach($lists as $item){
                    //更新最后分红时间
                 $memberModel->where(array('id'=>$item['id']))->save(array('last_cal_time' => NOW_TIME));


                    $memberModel->startTrans();
                    $result = true;
                    $map2 = 'id = ' . $item['id'];
                    $member = $memberModel->lock(true)->field('id,mills,ore,token,sign,score,score_lock,power')->where($map2)->find();

                    $ratio=awardOreRatio($member['power']);
                    $A=$membeRegionrModel->areaA($item['id']);
                    $B=$membeRegionrModel->areaB($item['id']);
                    $minPower=$A['team_power']<$B['team_power']?$A['team_power']:$B['team_power'];
                    $givenum=new_bcmul($minPower, $ratio);
                    if($givenum>0){
                        //用户加币
                        $result = $result && $memberModel->oreChange($member, $givenum,'inc');
                        if($result == false){
                            $err = '签名失败';
                        }else{
                            $err = '';
                        }

                        $newOre = new_bcadd($member['ore'], $givenum);
                        //用户日志
                        $log = array('uid' => $member['id'], 'changeform' => 'in', 'subtype' => 4, 'num' => $givenum, 'ctime' => NOW_TIME, 'balance' => $newOre, 'extends' => $todayBegin,'money_type'=>1);

                        $result = $result && $logModel->add($log);
                        if($err == '' && $result == false){
                            $err = '插入日志失败';
                        }
                        if($result){
                            $memberModel->commit();
                            $this->p('分红奖励成功:' . $member['id']);
                        }else{
                            $memberModel->rollback();
                            $this->p('分红奖励失败' . $member['id'] . '[' . $err . ']');
                        }
                    }else{
                        $memberModel->rollback();
                        $this->p('分红奖励失败' . $member['id'] . '[奖励金额为空]');
                    }
                }

            }else{
                $this->p('分红奖励失败:用户为空');
            }



        #################结束################

        //解锁
        setLock($plan_name, 'del');
    }


    /**
     * 自动标记已过期矿机 每5分钟一次 每次500台
     */
    public function closeMill(){
        set_time_limit(0);
        $plan_name = Constants::PLAN_CLOSE_MILL;
        $transNum  = 500;

        //检查锁
        if(checkLock($plan_name)){
            die('runing');
        }

        //加锁
        setLock($plan_name, 'add', 300);

        $tableid = getLastTableID();
        //超出重置最后表ID
        if(empty($tableid) || $tableid > 9){
            $tableid = 0;
            setLastTableID($tableid);
        }

        //表名称
        $table_name = 'mills_0'. $tableid;
        $millModel = M($table_name);
        $memberModel = D('members');
        $this->p($table_name);
        //矿机列表
        $time = NOW_TIME - 1440 * 60 * 60;
        $map = array('create_time' => array('lt', $time), 'status' => 1);
        $list = $millModel->field('id,uid,type,mill_sn')->where($map)->select();

        //处理
        if($list){
            $this->p('处理' . $table_name . '数据，数据条数:'. count($list));
            foreach($list as $item){
                $millModel -> startTrans();
                //标记矿机过期
                $result = $millModel -> where(array('id' => $item['id']))->save(array('status' => 0));

                $decNum = mill_power($item['type']);
                //重算团队算力
                $member = $memberModel->field('path')->where(array('id' => $item['uid']))->find();
                $result = $result && $memberModel->upd_team_power($member['path'], $decNum, 'dec');
                //重算个人算力
                $result = $result && $memberModel->upd_power($item['uid'], $decNum, 'dec');
                if($result){
                    $millModel->commit();
                    $this->p('close-success:'. $item['mill_sn']);
                }else{
                    $millModel->rollback();
                    $this->p('close-fail:'. $item['mill_sn']);
                }
            }
        }else{
            $this->p($table_name . '没有数据');
        }

        //表ID递增
        if(count($list) < $transNum){
            setLastTableID($tableid + 1);
        }

        //解锁
        setLock($plan_name, 'del');

    }

    /**
     * 自动关闭 30天未登录的账号  余额\矿机 归主账号 每天一次
     */
    public function clearMember(){
        $time = mktime(0, 0, 0, date('m'), date('d') - 30, date('Y'));
        $map = array('login_time' => array('lt', $time));
        $result = M('members')->where($map)->save(array('is_lock' => 1));
        if($result){
            echo 'clearAuth:Success';
        }else{
            echo 'clearAuth:Fail';
        }
    }

    /**
     * 清空一天前认证失败的资料 每天一次 6:00
     * @return [type] [description]
     */
    public function clearAuth(){
        $time = mktime(0, 0, 0, date('m'), date('d'), date('Y'));
        $map = array('status' => '-1', 'ctime' => array('lt', $time));
        $result = M('auths')->where($map)->delete();
        if($result){
            echo 'clearAuth:Success';
        }else{
            echo 'clearAuth:Fail';
        }
    }




    /**
     * [clearOrders 撤销超过24小时 每小时1次]
     * @return [type] [description]
     */
    public function clearOrders(){
        set_time_limit(0);
        $plan_name = Constants::PLAN_ORDERS;
        //检查锁
        if(checkLock($plan_name)){
            die('runing');
        }
        $time = 3600;
        //加锁
        setLock($plan_name, 'add', $time);
        $mod_order = M('orders');
        //查询条件为：类型为挂单，且状态为匹配中超过24小时的交易
        $map_order = array(
            'type' => 2,
            'status' => 2,
            'create_time' => array('LT', time() - 3600 * 24)
        );
        $mod_order->startTrans();
        $order_list = $mod_order->lock(true)->where($map_order)->select();
        if (!$order_list) {
            $mod_order->rollback();
            setLock($plan_name, 'del', $time);
            die();
        }
        $memberModel = D('members');
        foreach ($order_list as $order) {
            //手续费
            $fee = new_bcmul($order['opc'], Constants::DEAL_FEE);
            $lockNum = new_bcadd($order['opc'], $fee);
            $memberModel->startTrans();
            $member = $memberModel->lock(true)->where(array('id' => $order['sell_uid']))->find();
            $result = $memberModel->scoreChange($member, $lockNum);
            $mod_order->where('id = ' . $order['id'])->save(array('cancel_time' => NOW_TIME,'status' => -3));
            $memberModel->commit();
        }
        $mod_order->commit();
        setLock($plan_name, 'del', $time);
    }




    private function p($str){
        if($str == 'start'){
            echo '###################################### START #######################################<br/>';
        }elseif($str == 'end'){
            echo '###################################### END #######################################<br/>';
        }else{
            echo $str."<br/>";
        }
    }



}