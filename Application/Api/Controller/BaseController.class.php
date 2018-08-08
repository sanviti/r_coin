<?php
/**
 * @Author: lxy
 * @Date:   2017-11-28
 */
namespace Api\Controller;
Use Think\Controller;
Use Think\Model;
Use Think\Log;
Use Common\Lib\Safety;
use Common\Lib\Constants;

class BaseController extends Controller{
    protected $userToken;//用户token
    protected $authToken;//登录Token
    protected $uid;
    public function _initialize(){
        $authToken = I('post.authtoken'); //登录Token
//        $res = $this->_checkAuthToken($authToken);
//        // authtoken失效
//        if(!$res){
//            err(Constants::ERRCODE_AUTHTOKEN_VOID);
//        }
        $this->uid=108;
        $profiles = D('Members')->profiles($this->uid);
        //用户不存在
        if(!$profiles){
            err(Constants::ERRCODE_MEMBER_VOID);
        }

        //用户锁定
        if($profiles['is_lock'] !== '0'){
            err(Constants::ERRCODE_MEMBER_LOCK);
        }
        //未通过C1认证
        if (!$profiles['auth_c1']) {
            # code...
        }
    }

    /**
     * 验证authToken有效性
     * @param  [type] $authtoken [description]
     * @return [type]            [description]
     */
    private function _checkAuthToken($key){
        $res = false;
        $redis = ConnRedis();
        $uid = $redis->get($key);
        if($uid){
            //增加session 时间
            $redis->set($key, $uid, Constants::AUTH_TOKEN_TIME);
            $this->uid = $uid;
            $res = true;
        }
        return $res;
    }

    //今日价格
    protected function _todayPrice(){
        $start = mktime(0,0,0, 5, 5, 2018);
        $today = time();
        $currID = floor(($today-$start)/3600/24) + 1;
        $row = M('price')->where(array('id' => $currID))->find();
        $row = $row == null ? array('price' => 0.00) : $row;
        return $row['price'];
    }


    public function redisAllkeys(){
        $redis = ConnRedis();
        $keys = $redis->keys('*');
        foreach($keys as $key){
            $val = $redis->get($key);
            echo $key .':'. $val .'<br/>';
        }

    }

}