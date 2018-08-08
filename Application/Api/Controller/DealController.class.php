<?php
/**
 * 交易中心
 */
namespace Api\Controller;
use Think\Log;
use Think\Controller;
use Think\Model;


class DealController extends Controller{
    //交易中心首页
    public function index(){


        $date_list = array();
        $price_list = array();

        $priceData=D('TradingPrice')->getPrice();
        $LastpriceData=D('TradingPrice')->getLastPrice();

        $sdate = mktime(0,0,0,date('m'),date('d')-4,date('Y'));
        $edate = mktime(23,59,59,date('m'),date('d'),date('Y'));
        $condi['date']=array(array("EGT",$sdate),array("ELT",$edate));
        $priceDatas=D('TradingPrice')->where($condi)->select();
        foreach($priceDatas as $item){
            array_push($price_list, $item['price']);
            array_push($date_list, date('m-d',$item['date']));
        }
        $data = array(
            'date_list' => $date_list,
            'price_list' => $price_list,
            'price' => number_format($priceData['price'], 3, '.', ''),
            'lastPrice' => number_format($LastpriceData['price'], 3, '.', ''),
            'todayH' => number_format($priceData['high'], 3, '.', ''),
            'todayL' => number_format($priceData['low'], 3, '.', ''),
        );
        succ($data);
    }

    //订单
    public function orders(){
        $condi['od.status'] = array('in', '1,2');
        $order_type = I('order_type/d') == 1 ? 1 : 2;
        $condi['type'] = $order_type;
        $phone = I('phone/s');
        if($phone){
            $where['mb1.phone'] = $phone;
            $where['mb2.phone'] = $phone;
            $where['_logic'] = 'or';
            $condi['_complex'] = $where;
        }
        
        //页码
        $page = I('page/d');
        $orderModel = M('orders');
        $memberModel = D('members');

        $list = $orderModel->alias('od')
                ->field('od.id,od.type,cast(od.opc as decimal(9,2)) as opc,cast(od.price as decimal(9,3)) as price,od.order_sn,od.buy_uid,od.sell_uid')
                ->join('LEFT JOIN data_members mb1 ON mb1.id = od.buy_uid')
                ->join('LEFT JOIN data_members mb2 ON mb2.id = od.sell_uid')
                ->where($condi)->page($page)->order('id DESC')->limit(5)->select();
        foreach($list as &$item){
            if($item['type'] == 1){
                $map = array('id' => $item['buy_uid']);
                $member = $memberModel->field('0 as chengjiao, 0 as haoping, nickname, headimg')->where($map)->find();
            }else{
                $map = array('id' => $item['sell_uid']);
                $member = $memberModel->field('0 as chengjiao, 0 as haoping, nickname, headimg')->where($map)->find();
            }
            $item['chengjiao'] = $member['chengjiao'];
            $item['haoping']  = $member['haoping'];
            $item['nickname'] = $member['nickname'];
            $item['total'] =
            $item['headimg']  = $member['headimg'] ? $member['headimg'] : '/Public/Wap/img/headimg_default.jpg';
            unset($item['buy_uid']);
            unset($item['sell_uid']);
        }
        $data['list'] = empty($list) ? array() : $list;
        $data['page'] = $page + 1;
        succ($data);
    }
}