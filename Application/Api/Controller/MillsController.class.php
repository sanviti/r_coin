<?php
/**
 * 矿机
 */
namespace Api\Controller;
use Think\Log;
use Think\Controller;
use Think\Model;
use Common\Lib\Constants;

class MillsController extends BaseController{
    //矿机列表
    public function millList(){
        //状态
        $stype = I('stype/s') == 'stop' ? 'stop' : 'runing';
        if($stype == 'runing'){
            $condi['status']  = 1;
        }else{
            $condi['status']  = 0;
        }
        $condi['uid'] = $this->uid;
        //矿机类型
        $subtype = I('subtype/d');
        if($subtype){
            $condi['type'] = $subtype;
        }
        //时间范围
        $end_time = time();
        $end = I('end/s');
        if($end){
            $end_time = strtotime($end) + 3600 * 24;
        }
        $condi['create_time'] = array('ELT', $end_time);
        $begin = I('begin/s');
        if($begin){
            $begin = strtotime($begin);
            $condi['create_time'] =  array(array('egt', $begin), array('ELT', $end_time));
        }
        //页码
        $page = I('page/d');
        $millModel = M(get_mill_table($this->uid));
        $list = $millModel
                ->field('mill_sn,create_time,status,type,mill_value,last_time')
                ->where($condi)->page($page)->limit(20)->select();
        foreach($list as &$mill){
            $stop_time = $mill['create_time'] + 60*60*1440;
            $mill['stop_time'] = $stop_time;
            $mill['output'] = new_bcsub(mill_max_output($mill['type']), $mill['mill_value']);
            $mill['mill_power']=mill_power($mill['type']);
            $mill['wait_out'] = mill_get_wait($mill);
            $mill['type_name']   = mill_name($mill['type']);
            $mill['status'] = mill_status($mill['status']);
            $mill['stop_time'] = date('Y-m-d H:i:s', $stop_time);
            $mill['create_time'] = date('Y-m-d H:i:s', $mill['create_time']);
            $mill['onehour']= mill_hour_output($mill['type']);
            unset($mill['last_time']);
            unset($mill['mill_value']);
        }
        $data['page'] = $page+1;
        $data['list'] = empty($list) ? array() : $list;

        succ($data);
    }
  //矿机数量
    public function millNum(){
        //状态
        $condi['uid'] = $this->uid;
        $millModel = M(get_mill_table($this->uid));
        //已过期
        $condi['status']  = 0;
        $data['millStop'] = $millModel->where($condi)->count();
        //运行中
        $condi['status']  = 1;
        $data['millRuning'] = $millModel->where($condi)->count();
        succ($data);
    }
    //购买矿机
    public function millGen(){
        require_check("mtype,paypwd");
        $mtype  = I('mtype');
        $price  = mill_price($mtype);
        $paypwd = input_str(I('paypwd'));

        if($price == '')
            err('商品不存在');

        $memberModel = D('members');
        if(!$memberModel->checkpaypwd($this->uid, $paypwd))
            err('交易密码错误');

        $logModel = M('userScoreLog');
        $millModel = M(get_mill_table($this->uid));
        $memberModel->startTrans();
        $member = $memberModel->lock(true)->where(array('id' => $this->uid))->find();
        if($mtype==1){

            if($member && $member['exp_mills'] >= $price){
                //创建矿机
                $mill_sn = gen_mill_sn($this->uid, $mtype);
                $data = array(
                    'uid' => $this->uid,
                    'type' => $mtype,
                    'last_time'   => NOW_TIME,
                    'create_time' => NOW_TIME,
                    'status' => 1,
                    'mill_value' => mill_max_output($mtype),
                    'mill_sn' => $mill_sn,
                    'get_way' => 'buy',
                );
                $result = $millModel->add($data);

                //用户扣币
                $result = $result && $memberModel->where(array('id'=>$this->uid))->setDec('exp_mills',$price);
                $newBalan1 = new_bcsub($member['exp_mills'], $price);

                //账户日志
                $log = array('uid' => $this->uid, 'changeform' => 'out', 'subtype' => 7, 'num' => $price, 'ctime' => NOW_TIME, 'balance' => $newBalan1, 'extends' => $mill_sn,'money_type'=>4);
                $result = $result && $logModel->add($log);

                //团队算力
                $power = mill_power($mtype);
                $result = $result && $memberModel->upd_team_power($member['path'], $power, 'inc');
                //个人算力
                $result = $result && $memberModel->upd_power($this->uid, $power, 'inc');

                if($result){
                    $memberModel->commit();
                    succ('开通成功');
                }else{
                    $memberModel->rollback();
                    err('开通失败');
                }
            }else{
                $memberModel->rollback();
                err('体验矿机票数量不足');
            }


        }else{
            if($member && $member['mills'] >= $price){
                //创建矿机
                $mill_sn = gen_mill_sn($this->uid, $mtype);
                $data = array(
                    'uid' => $this->uid,
                    'type' => $mtype,
                    'last_time'   => NOW_TIME,
                    'create_time' => NOW_TIME,
                    'status' => 1,
                    'mill_value' => mill_max_output($mtype),
                    'mill_sn' => $mill_sn,
                    'get_way' => 'buy',
                );
                $result = $millModel->add($data);

                //用户扣币
                $result = $result && $memberModel->millsChange($member, $price);
                $newBalan1 = new_bcsub($member['mills'], $price);

                //账户日志
                $log = array('uid' => $this->uid, 'changeform' => 'out', 'subtype' => 7, 'num' => $price, 'ctime' => NOW_TIME, 'balance' => $newBalan1, 'extends' => $mill_sn,'money_type'=>2);
                $result = $result && $logModel->add($log);

                //团队算力
                $power = mill_power($mtype);
                $result = $result && $memberModel->upd_team_power($member['path'], $power, 'inc');
                //个人算力
                $result = $result && $memberModel->upd_power($this->uid, $power, 'inc');

                if($result){
                    $memberModel->commit();
                    succ('开通成功');
                }else{
                    $memberModel->rollback();
                    err('开通失败');
                }
            }else{
                $memberModel->rollback();
                err('矿机票数量不足');
            }
        }

    }




    //矿机收币
    public function getCoin(){
        require_check("millsn");
        $millsn = input_str(I('millsn'));
        $millModel = M(get_mill_table($this->uid));
        $memberModel = D('members');
        $logModel = M('userScoreLog');

        $millModel->startTrans();
        $mill = $millModel->lock(true)->where(array('mill_sn' => $millsn, 'uid' => $this->uid))->find();
        //验证
        if($mill && $mill['mill_value'] > 0){
            $member = $memberModel->lock(true)->where(array('id' => $this->uid))->find();
            if($member){
                $givenum = mill_get_wait($mill);
                if($givenum > 0){
                     //用户加币
                    $result = $memberModel->oreChange($member, $givenum);
                    $newBalan1 = new_bcadd($member['ore'], $givenum);
                    
                    //用户日志
                    $log = array('uid' => $this->uid, 'changeform' => 'in', 'subtype' => 3, 'num' => $givenum, 'ctime' => NOW_TIME, 'balance' => $newBalan1, 'extends' => $millsn,'money_type'=>1);
                    $result = $result && $logModel->add($log);

                    //矿机更新
                    $upd['mill_value'] = new_bcsub($mill['mill_value'], $givenum);
                    $upd['last_time']  = NOW_TIME;
                    $result = $result && $millModel->where(array('mill_sn' => $millsn, 'uid' => $this->uid))->save($upd);

                    //发放推荐奖
//                    $result = $result && $memberModel->recReward($member, $givenum);

                    if($result){
                        $memberModel->commit();
                        succ('结算成功');
                    }else{
                        $memberModel->rollback();
                        err('结算失败');
                    }  
                }else{
                    $millModel->rollback();
                    err('还没有挖到新的矿石,请稍后重试');
                }
               
            }else{
                $millModel->rollback();
                err('结算失败[用户不存在]');
            }
        }else{
            $millModel->rollback();
            err('结算失败[矿机不存在]');
        }           
    }

    
}