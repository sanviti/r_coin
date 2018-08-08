<?php
/**
 * 用户登录/注册
 */
namespace Wap\Controller;
use Think\Controller;

class MembersController extends Controller{
	//会员中心首页
    public function index(){
        $this->assign('page_title', '会员中心');
        $this->display();
    }
    
    //我的订单
    public function myOrder(){
        $this->assign('page_title', '我的订单');
        $this->display();
    }
    //个人信息
    public function memberInfo(){
    	$this->assign('page_title', '个人信息');
        $this->display();
    }
    //其他支付方式
    public function other_payment(){
    	$this->assign('page_title', '其他支付方式');
        $this->display();
    }
	//兑换中心
    public function exchange_center(){
    	$this->assign('page_title', '兑换中心');
        $this->display();
    }
    //C1认证
    public function auth_c1(){
    	$this->assign('page_title', 'C1认证');
        $this->display();
    }
     //C2认证
    public function auth_c2(){
    	$this->assign('page_title', 'C2认证');
        $this->display();
    }
    //个人资料
    public function my_info(){
        $this->assign('page_title', '个人资料');
        $this->display();
    }
    //银行卡
    public function BankCard(){
    	$this->assign('page_title', '银行卡');
        $this->display();
    }
    //排行榜
    public function MyAssets(){
    	$this->assign('page_title', '我的资产');
        $this->display();
    }
    //新手入门
    public function newGuide(){

        $data = M('news')->field('title,id,des,cate_id,content')->where('cate_id = 62')->order('id DESC')->find();
        $cate = M('category')->field('cat_name')->where(array('cat_id' => $data['cate_id']))->find();

        $this->assign('page_title', $cate['cat_name']);
        $this->assign('category_name', $cate['cat_name']);
        $this->assign('title', $data['title']);
        $this->assign('content', $data['content']);
    	$this->assign('page_title', '新手入门');
        $this->display();
    }
    //找回用户名 第一步
    public function findName_one(){
    	$this->assign('page_title', '找回用户名');
        $this->display();
    }
    //找回用户名 第二步
    public function findName_two(){
        $members = D("Api/Members");
        $list = $members -> profilesByPhone(I('phone_num'), $field = 'username,id');
        $this->assign('list', $list);
    	$this->assign('page_title', '找回用户名');
        $this->display();
    }
    //客服中心
    public function support(){
    	$this->assign('page_title', '客服中心');
        $this->display();
    }
    //系统设置
    public function system(){
    	$this->assign('page_title', '系统设置');
        $this->display();
    }

    //修改密码
    public function changePwd(){
    	$this->assign('page_title', '修改密码');
        $this->display();
    }
    //修改交易密码
    public function changePayPwd(){
    	$this->assign('page_title', '交易密码');
        $this->display();
    }
    //重置交易密码
    public function resetPayPwd(){
        $this->assign('page_title', '交易密码');
        $this->display();
    }

    //团队/推广
    public function laborUnion(){
        $this->assign('page_title', '团队推广');
        $this->display();
    }


    public  function  Unionrecruit(){
        $area=I('area');
        $this->assign('page_title', '推广');
        $this->assign('area', $area);
        $this->display();
    }

    //新手入门
    public function aboutUs(){

        $data = M('news')->field('title,id,des,cate_id,content')->where('cate_id = 50')->order('id DESC')->find();
        $cate = M('category')->field('cat_name')->where(array('cat_id' => $data['cate_id']))->find();

        $this->assign('page_title', $cate['cat_name']);
        $this->assign('category_name', $cate['cat_name']);
        $this->assign('title', $data['title']);
        $this->assign('content', $data['content']);
        $this->assign('page_title', '新手入门');
        $this->display();
    }
}