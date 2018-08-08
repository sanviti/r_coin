<?php
/**
 * 我的钱包
 */
namespace Wap\Controller;
use Think\Controller;

class WalletController extends Controller{

    //我的矿机
    public function millList(){
    	$this->assign('page_title', '我的机组');
        $this->display();
    }
}