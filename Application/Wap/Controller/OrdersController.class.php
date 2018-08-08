<?php
/**
 * 我的钱包
 */
namespace Wap\Controller;
use Think\Controller;

class OrdersController extends Controller{


    //委托订单
    public function myOrder(){
        $this->assign('page_title', '订单中心');
        $this->display();
    }


    //买入订单详情
    public function buy_order(){
    	$this->assign('page_title', '交易订单');
    	$this->assign('id', I('get.id', '', 'intval'));
        $this->display();
    }


    //卖出订单详情
    public function sell_order(){
        $this->assign('page_title', '交易订单');
        $this->assign('id', I('get.id', '', 'intval'));
        $this->display();
    }

    //上传凭证
    public function certificate(){
    	$this->assign('page_title', '上传凭证');
    	$this->assign('id', I('get.id', '', 'intval'));
        $this->display();
    }


    //我的矿机
    public function millList(){
    	$this->assign('page_title', '我的机组');
        $this->display();
    }
    public function millView(){
        $mill_sn = I('get.mill_sn');
        $this->assign('mill_sn', $mill_sn);
        $this->assign('page_title', '我的机组');
        $this->display();
    }

}