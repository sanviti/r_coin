<?php
/**
 * 商城
 */
namespace Wap\Controller;
use Think\Controller;

class ShopController extends Controller{
	//首页
    public function index(){
        $this->assign('page_title', '商城首页');
        $this->display();
        
    }

    
}