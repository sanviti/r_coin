<?php
/**
 * 钱包
 */
namespace Api\Controller;
use Think\Log;
use Think\Controller;
use Think\Model;
use Common\Lib\Constants;

class WalletController extends BaseController{
   
    //钱包首页
    public function index(){
        $member = D('members')->profiles($this->uid,'token,cast(score as decimal(10,2)) as score,cast(score_lock as decimal(10,2)) as score_lock');
        $data['opc'] = $member['score'];
        $data['opcl'] = $member['score_lock'];
        $data['opc_total'] = $member['score'] + $member['score_lock'];
        $data['address'] = $member['token'];
        
        $max_price = $this->_todayPrice();
        
        //计算USD
        $data['usd'] = $data['opc_total'] * $max_price;
        $data['cny'] = $data['usd'] * 6.5;
        succ($data);
    }

    //账单
    public function bill(){
        //显示类型
        $stype = I('stype/s') == 'out' ? 'out' : 'in';
        $condi['changeform'] = $stype;
        $condi['money_type'] = I('money_type/s');;
        $condi['uid']  = $this->uid;
        //时间范围
        $end_time = time();
        $end = I('end/s');
        if($end){
            $end_time = strtotime($end) + 3600 * 24;
        }
        $condi['ctime'] = array('lt', $end_time);
        $begin = I('begin/s');
        if($begin){
            $begin = strtotime($begin);
            $condi['ctime'] =  array(array('egt', $begin), array('ELT', $end_time));
        }
        //页码
        $page = I('page/d');
        //1买入 2卖出 3矿机产出 4小区分红 5 推荐奖励 7购买矿机 8 矿石兑换富链 9 富链兑换矿机票 10 转赠矿机票 11 奖励矿机票
        $list = M('userScoreLog')
                ->field('cast(num as decimal(10,4)) as num,FROM_UNIXTIME(ctime, "%Y/%m/%d %T") AS ctime, 
                    case subtype 
                    when 1 then "买入"
                    when 2 then "卖出"
                    when 3 then "矿机产出"
                    when 4 then "小区分红"
                    when 5 then "推荐奖励"
                    when 7 then "购买矿机"
                    when 8 then "矿石兑换富链"
                    when 9 then "富链兑换矿机票"
                    when 10 then "转赠矿机票"
                    when 11 then "奖励矿机票"
                    else "其他" end AS subtype')
                ->where($condi)->page($page)->order('ctime DESC')->limit(20)->select();
        // echo M()->getlastsql();
        if (!$list) {
            err();
        }
        $page++;
        $data['list'] = $list;
        $data['page'] = $page;
        succ($data);
    }

}