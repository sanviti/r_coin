<?php
/**
 * 用户登录/注册
 */
namespace Api\Controller;
use Think\Log;
use Think\Controller;
use Think\Model;
use Common\Lib\Constants;

class LoginController extends Controller{

    public function login(){
        require_check_post("username/s,password/s,validcode/s");
        $username   = addslashes(I('username/s'));
        $password = addslashes(I('password/s'));
        $validcode = addslashes(I('validcode/s'));
        if(!valid_check($validcode)){
            err('图形验证码错误或已失效,请刷新重试');
        }
        $member = D("Members");
        $result = $member->checklogin($username,$password);
        if($result['code'] == 0){ //登录成功
            $authtoken = $this->_auth_token($result['profile']['token'], $result['profile']['id']);
            succ("登陆成功",array('authtoken' => $authtoken));
        }else{ //登录失败
            if($result['code'] == -1){
                err("用户名不存在");
            }elseif($result['code'] == -2){
                err("密码错误");
            }elseif($result['code'] == -3){
                err("账号被禁用");
            }
        }
    }

    /**
     * 退出登录
     * @return [type] [description]
     */
    public function  loginout(){
        extract(require_check_post("authtoken/s"));
        $redis = ConnRedis();
        $redis -> del($authtoken);
        succ('退出成功');
    }

    /**
     * 创建redis session
     * @return [type] [description]
     */
    private function _auth_token($userToken, $uid){
        $redis = ConnRedis();
        //添加新token
        $key = sha1(time() . $userToken . Constants::PUB_SALT);
        $val = $uid;
        $redis -> set($key, $val, Constants::AUTH_TOKEN_TIME);
        return $key;
    }

    /**
     * 用户注册
     * @param  string $mobile   手机号
     * @param  string $password md5密码
     * @param  int    $lid      推荐人
     * @param  string $truename 真实姓名
     * @param  string $province    省
     * @param  string $city        市
     * @param  string $area        区
     * @param  string $smscode  手机验证码
     * @return [type]           [description]
     */
    public function reg(){
        require_check_post("nickname/s,username/s,mobile/s,smscode/s,password/s,password2/s,pay_password/s,pay_password2/s,lid/s");
        $model = D('Members');
        $phone = I('post.mobile/s');
        $nickname = addslashes(I('post.nickname/s'));
        //手机号
        if($model->is_reg($phone)){
            err("手机号注册已达到上限");
        }

        $username = addslashes(I('post.username/s'));
        if(!preg_match('/^[a-zA-Z0-9_-]{4,16}$/', $username)){
            err('请输入有效用户名');
        }
        $checkUserName=M('members')->where(array('username'=>$username))->field('id')->find();
        if($checkUserName){
            err('用户名已存在');
        }


        $smscode = I('smscode/s');
        //短信验证码
        $codeModel = D('Validcode');
        if($codeModel -> expires($phone,$smscode,Constants::SMS_REGISTER_CODE)){
            err('短信验证码错误或已失效');
        }

        $password = I('post.password/s');
        $password2 = I('post.password2/s');
        if($password!=$password2)
            err('登录密码确认错误');

        $pay_password = I('post.pay_password/s');
        $pay_password2 = I('post.pay_password2/s');
        if($pay_password!=$pay_password2)
            err('登录密码确认错误');
        $lid =  addslashes(I('post.lid/s'));


        $data = array(
            'phone' => $phone,
            'pwd' => $password,
            'pay_pwd' => $pay_password,
            'lid' => $lid,
            'nickname' => $nickname,
            'username'=>$username
        );

        if($model->register($data)){
            succ('注册成功');
        }else{
            err('注册失败，稍后重试');
        }
    }

        /**
     * 找回密码
     * @return [type] [description]
     */
    public function findPwd(){
        require_check_post("mobile,password,password2,vcode,username");
        $mobile = I('mobile/s');
        $password = I('password/s');
        $password2 = I('password2/s');
		$username = I('post.username/s');
        $vcode = I('vcode/s');
        $model  = D("Members");
        if($password2 != $password){
            err('两次密码不一致');
        }
        //用户名检测
        if(!$model->is_reg($mobile)){
            err("用户不存在");
        }

        //验证码检测
        $codeModel = D('Validcode');
        if($codeModel -> expires($mobile,$vcode,Constants::SMS_FINDPWD_CODE)){
            err('短信验证码错误或已失效');
        }

        //重置密码
        list($pwd, $salt) = md5password($password);
        $data['pwd'] = $pwd;
        $data['salt'] = $salt;
        $result = $model->where(array('phone' => $mobile,'username' => $username))->save($data);
        if($result){
            succ('重置密码成功');
        }else{
            err('操作失败');
        }
    }
	 /**
     * 找回用户名
     * @return [type] [description]
     */
	 public function findName(){
		require_check_post("mobile,vcode");
        $mobile = I('mobile/s');
        $vcode = I('vcode/s');
		$model  = D("Members");
		
		//用户手机号检测
		if(!$model->is_reg_findname($mobile)){
            err("用户不存在");
        }
        //验证码检测
       $codeModel = D('Validcode');
       if($codeModel -> expires($mobile,$vcode,Constants::SMS_REGISTER_CODE)){
           err('短信验证码错误或已失效');
       }
		succ('找到的用户如下');
	 }
}