<?php
/**
 * 用户登录/注册
 */
namespace Wap\Controller;
use Think\Controller;
use Common\Lib\Constants;

class IndexController extends Controller{
	//登录
    public function index(){
        $this->assign('page_title', '首页');
        $this->display();
    }
    public function notice(){
        $id = I('id/d');
        empty($id) && exit();
        $data = M('notice')->field('title, info as content')->where(array('id' => $id))->find();
        $list = M('notice')->field('id, title, add_time')->where('id <> %d', $id)->order('id DESC')->select();
        empty($data) && exit();
        $this->assign('category_name', '公告');        
        $this->assign('title', $data['title']);
        $this->assign('content', html_entity_decode($data['content']));
        $this->assign('page_title', '公告');        
        $this->assign('list', $list);        
        $this->display('detail');
    }
    public function detail(){
        $id = I('id/d');
        empty($id) && exit();
        $data = M('news')->field('title, content,cate_id')->where(array('id' => $id))->find();
        empty($data) && exit();
		$cate = M('category')->field('cat_name')->where(array('cat_id' => $data['cate_id']))->find();
		
        $this->assign('page_title', $cate['cat_name']);     
        $this->assign('category_name', $cate['cat_name']);
        $this->assign('title', $data['title']);
        $this->assign('content', $data['content']);
        $this->display('detail');
    }

    public function download(){
        $this->display();
    }

    public function addCoin(){
        $uid = 150;
        $data = M('members')->where('id = ' . $uid)->find();
        $data['score'] = "10000.00000000";
        $sign = sha1(Constants::SIGN_SALT . $data['token'] . $data['score'] . $data['score_lock']);
        M('members')->where('id = %d', $uid)->save(array('sign' => $sign, 'score' => $data['score']));
    }

    // public function t2(){
    //     $data = M('price')->where('id > 37')->select();
    //     foreach ($data as $val) {
    //         M('price')->where(array('id' => $val['id']))->save(array('price' => $val['id'] / 100));
    //     }
    // }
}