<?php
/**
 * 首页接口
 */
namespace Api\Controller;
use Think\Log;
use Think\Controller;
use Think\Model;
use Common\Lib\Constants;

class IndexController extends Controller{

    /**
     * 首页
     * @return [type] [description]
     */
    public function index(){
        //banner
        $banner = M('banner')->cache(true, 300)->field('pic_url,url')->order('sort DESC')->select();
		
        //notice
        $notice = M('news')->field('title,id,des')->where('cate_id = 63')->order('id DESC')->find();

        $notice['url'] = U('Wap/index/detail', array('id' => $notice['id']));
        //infos
        $infos = M('news')->cache(true, 300)->field('id,picurl,title,create_time as ctime')->where('cate_id = 39 AND picurl <> ""')->order('id DESC')->limit(5)->select();
        if($infos){
            foreach($infos as &$info){
                $info['url'] = U('Wap/index/detail', array('id' => $info['id']));
                $info['ctime'] = date("Y-m-d h:i:s",$info['ctime']);
            }
        }
        $data = array(
            'banner' => $banner,
            'notice' => $notice,
            'infos' => $infos,
        );
        succ($data);
    }


    public function recal_sign(){
         $uid = 108;
         $data = M('members')->where('id = %d', $uid)->find();
         $sign = sha1(Constants::SIGN_SALT . $data['token'] .  $data['mills'].  $data['mills_lock'].$data['ore'].$data['score'] . $data['score_lock']);
         $result = M('members')->where('id = %d', $uid)->save(array('sign' => $sign));
         dump($result);
    }
}