<?php
/**
 * 矿机票/矿机
 */
namespace Wap\Controller;
use Think\Controller;

class MinerController extends Controller{
	//矿机票首页
    public function index(){
        $this->assign('page_title', '矿机票');
        $this->display();
    }
    //转赠矿机票
    public function sendMills(){
    	$this->assign('page_title', '转赠矿机票');
        $this->display();
    }
	 //矿机票详情
    public function minerBill(){
    	$this->assign('page_title', '矿机票详情');
        $this->display();
    }
    //矿石详情
    public function oreBill(){
        $this->assign('page_title', '矿石详情');
        $this->display();
    }
    //富链详情
    public function rcBill(){
        $this->assign('page_title', '富链详情');
        $this->display();
    }
}