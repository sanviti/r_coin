<?php
/**
 * 手机端用户模型
 */
namespace Api\Model;
use Think\Model;
use Common\Lib\Constants;
class MembersModel extends Model{
    protected $tableName = 'members';
    public function register($data){

        //生成新的密码和salt
        list($pwd, $salt) = md5password($data['pwd']);
        $data['pwd'] = $pwd;
        $data['salt'] = $salt;

        //交易密码
        list($pay_pwd, $pay_salt) = md5password($data['pay_pwd']);
        $data['pay_pwd'] = $pay_pwd;
        $data['pay_salt'] = $pay_salt;

        //推荐关系
        $where[' recom_lid_token | recom_rid_token ']=$data['lid'];

        $lead=$this->field(' recom_lid_token , recom_rid_token , id  ')->where($where)->find();


        if($lead['recom_lid_token'] || $lead['recom_rid_token'] ){

            if($lead['recom_lid_token']==$data['lid']){

                $pid=$this->_findPid($lead['id']);
            }else{

                $pid=$this->_findPid($lead['id'],'rid');
            }
        }else{
            err('未找到推荐人');
        }


        $data['leadid']  = $lead['id'];
        $data['reg_time'] = NOW_TIME;
        $data['exp_mills'] = 100;
        $this->startTrans();
        $result = $userid = $this->add($data);

        //插入节点表
        if($pid){
            if( $pid['node'] == 'lid' ){
                $result = $result && M('members_region')->where(array('uid' => $pid['uid']))->save(array('lid'=>$userid));
                $regionData=array(
                    'uid'=>$userid,
                    'pid'=>$pid['uid']
                );
                $result = $result && M('members_region')->add($regionData);
            }elseif( $pid['node'] == 'rid'){
                $result = $result && M('members_region')->where(array('uid' => $pid['uid']))->save(array('rid'=>$userid));
                $regionData=array(
                    'uid'=>$userid,
                    'pid'=>$pid['uid']
                );
                $result = $result && M('members_region')->add($regionData);
            }

        }else{
            M()->rollback();
            return false;
        }


        //更新推荐人直推人数

        if(!empty($data['leadid'])){
            $result = $result && $this->where(array('id' => $data['leadid']))->setInc('children_num', 1);
        }

        $path= $this->field('path')->where(array('id' => $pid['uid']))->find();
        $path = empty($path) ? '' : $path['path'];
        $upd['path'] = trim($path . ',' . $userid , ',');
        //增加团队人数
        $result = $result && $this->upd_team_people_num($upd['path'], 1, 'inc');


        $upd['userid'] = 'U'.sprintf('%06d',$userid);
        $upd['token']  = $this->_create_token();
        $upd['recom_lid_token']  = $this->_create_recom_lib_token();
        $upd['recom_rid_token']  = $this->_create_recom_rib_token();

        //创建sign
        $defInfo= array(
            'mills'=>'0.00000000',
            'mills_lock'=>'0.00000000',
            'org'=>'0.00000000',
            'score'=>'0.00000000',
            'score_lock'=>'0.00000000', 
            'token'=>$upd['token']
            );
        $sign = $this->_sign($defInfo);
        $upd['sign'] = $sign;
        $result = $result && $this->where(array('id' => $userid))->save($upd);



        //添加会员副表
        $members_dep = array(
            'uid' => $userid
        );

        $result = $result &&  M('members_dep')->add($members_dep);
        if($result){
            $this->commit();
            return true;
        }else{
            $this->rollback();
            return false;
        }
    }

    /**
     * 递归查找推荐人最低用户
     * @param  [type]     [description]
     */
    private  function  _findPid($uid,$node='lid'){

        $membersRe=M('members_region')->where(array('uid'=>$uid))->field('lid')->find();

        if($membersRe['lid']){

            $membersRe=M('members_region')->where(array('uid'=>$uid))->field($node)->find();
            if($membersRe[$node]){

                $uid=$this->_findPid($membersRe[$node]);

                return $uid;

            }else{

                return array('uid'=>$uid,'node'=>$node);

            }
        }else{

            return  array('uid'=>$uid,'node'=>'lid');
        }

    }




    /**
     * 登录
     * @param  [type] $phone    [description]
     * @param  [type] $password [description]
     * @return [type]           [description]
     */
    public function checklogin($username, $password){
        $code = 0;
        $condi['username'] = $username;
        $field = "id, pwd, is_lock, salt, pay_pwd, token";
        $member = $this->field($field)->where($condi)->find();
        $result = array();
        //用户名不存在
        if($member == NULL){
            $code = -1;
        }
        //密码错误
        elseif(md5password($password,$member['salt']) != $member['pwd']){
            $code = -2;
        }
        //账号锁定
        elseif($member['is_lock'] != 0){
            $code = -3;
        }
        //登录成功
        if($code == 0){
            $this->where($condi)->save(array('login_time' => NOW_TIME, 'login_ip' => ClientIp()));
            $result['profile'] = array('token' => $member['token'], 'id' => $member['id']);
        }
        $result['code'] = $code;
        return $result;
    }

    /**
     * 推荐奖励
     * @return [type] [description]
     */
    public function recReward($member, $givenum){
        $logModel = D("MembersLog");
        $path = explode(',', $member['path']);
        $path = array_reverse($path);
        $result = true;
        for($i = 1; $i <= 1; $i++){
            if($path[$i]){
                $rate = get_reward_rate($i);
                $num  = new_bcmul($givenum, $rate);
                $leader = $this->lock(true)->where(array('id' => $path[$i]))->find();
                if($leader){
                    //推荐人算力 小于 被推荐人 推荐奖 50%
                    if($leader['power'] < $member['power']){
                        $num = new_bcmul($num, 0.5);
                    }
                    $newBalan = new_bcadd($leader['score'], $num);
                    $result = $result && $this->score_inc($leader, $num);
                    $log = array('uid' => $leader['id'], 'changeform' => 'in', 'subtype' => 5, 'num' => $num, 'ctime' => NOW_TIME, 'balance' => $newBalan, 'extends' => $member['id']);
                    $result = $result && $logModel->add($log);
                }
            }else{
                break;
            }
        }
        return $result;
    }

    /**
     * 检查支付密码
     * @param  [type] $uid    [description]
     * @param  [type] $paypwd [description]
     * @return [type]         [description]
     */
    public function checkpaypwd($uid, $paypwd){
        $member = $this->field('pay_pwd,pay_salt')->where(array('id' => $uid))->find();
        if(md5password($paypwd,$member['pay_salt']) != $member['pay_pwd']){
            return false;
        }else{
            return true;
        }
    }

    /**
     * 创建token
     * @return [type] [description]
     */
    private function _create_token(){
        $status = 0;
        while($status == 0){
            $token = $this->_str_rand();
            $count = $this->where(array('token' => $token))->count();
            if($count == 0){
                $status = 1;
            }
        }
        return $token;
    }

    /*
     * 生成随机字符串
     * @param int $length 生成随机字符串的长度
     * @param string $char 组成随机字符串的字符串
     * @return string $string 生成的随机字符串
     */
    private function _str_rand($length = 32, $char = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ') {
        if(!is_int($length) || $length < 0) {
            return false;
        }
        $string = '';
        for($i = $length; $i > 0; $i--) {
            $string .= $char[mt_rand(0, strlen($char) - 1)];
        }
        return '0x'. substr(sha1($string), 0, 40);
    }

    /**
     * 创建推荐token
     * @return [type] [description]
     */
    private function _create_recom_lib_token(){
        $status = 0;
        while($status == 0){
            $token = $this->_recom_rand();
            $count = $this->where(array('recom_lid_token' => $token))->count();
            if($count == 0){
                $status = 1;
            }
        }
        return $token;
    }

    /**
     * 创建推荐token
     * @return [type] [description]
     */
    private function _create_recom_rib_token(){
        $status = 0;
        while($status == 0){
            $token = $this->_recom_rand();
            $count = $this->where(array('recom_rid_token' => $token))->count();
            if($count == 0){
                $status = 1;
            }
        }
        return $token;
    }
    /*
     * 生成随机推荐码
     * @param int $length 生成随机字符串的长度
     * @param string $char 组成随机字符串的字符串
     * @return string $string 生成的随机字符串
     */
    private function _recom_rand($length = 8, $char = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') {
        if(!is_int($length) || $length < 0) {
            return false;
        }
        $string = '';
        for($i = $length; $i > 0; $i--) {
            $string .= $char[mt_rand(0, strlen($char) - 1)];
        }
        return  $string;
    }

    /**
     * 账户注册检测
     * @param  string  $phone 手机号
     * @return boolean        [description]
     */
    public function is_reg($phone){
        $condi = array('phone' => $phone);
        $count = $this->where($condi)->count();
        return $count>=10 ? true : false;
    }
    public function is_reg_findname($phone){
        $condi = array('phone' => $phone);
        $count = $this->where($condi)->count();
        return $count ? true : false;
    }

    /**
     * 用户信息 id
     * @param  [type] $id [description]
     * @param  string $field [description]
     * @return [type]        [description]
     */
    public function profiles($id, $field = 'mills,mills_lock,ore,score,score_lock,token,id,userid,is_lock'){
        return $this->field($field)->where(array('id' => $id))->find();
    }
    

    /**
     * 更新用户等级
     * @param  [type] $uid   [description]
     * @param  [type] $level [description]
     * @return [type]        [description]
     */
    public function memberLevel($uid, $level){
         return $this->where(array('id' => $uid))->save(array('vip_level'=>$level));
    }

    /**
     * 查找正常用户
     * @param $where 搜索条件
     */
    public function normalMember($uid, $fields = '*'){
        $condi['id'] = $uid;
        $condi['is_lock'] = 0;
        $condi['isfreeze'] = 0;
        $res = $this->field($fields)->where($condi)->find();
        return $res;
    }

    /**
     * 修改用户数据 token
     * @param  [type] $token [description]
     * @param  [type] $data  [description]
     * @return [type]        [description]
     */
    public function modify($uid, $data){
        $condi = array('id' => $uid);
        return $this->where($condi)->save($data);
    }

    /**
     * [member_dep 获取会员副表信息]
     * @param  integer $uid    会员ID
     * @param  string  $fields 读取字段
     * @return array           会员副表信息
     */
    public function member_dep($uid, $fields = '*'){
        $map = array('uid' => $uid);
        $member_depInfo = M('members_dep')->where($map)->find();
        return $member_depInfo;
    }

    /**
     * [modify_memberdep 修改会员副表]
     * @param  integer $uid  会员ID
     * @param  array   $data [description]
     * @return [type]        [description]
     */
    public function modify_memberdep($uid, $data = array()){
        $condi = array('uid' => $uid);
        return M('members_dep')->where($condi)->save($data);
    }

    /**
     * 签名
     * @return [type] [description]
     */
    public function _sign($data){
        return sha1(Constants::SIGN_SALT . $data['token'] .  $data['mills'].  $data['mills_lock'].$data['ore'].$data['score'] . $data['score_lock']);
    }

    /**
     * 验证签名
     * @param  [type] $uid [description]
     * @return [type]      [description]
     */
    public function _verify_sign($data){
        // dump($data);
        $sign = sha1(Constants::SIGN_SALT .$data['token'] . $data['mills'].  $data['mills_lock'] . $data['ore'] . $data['score'] . $data['score_lock']);
        // dump($sign);
        
        return $sign == $data['sign'] ? true : false;
    }

    /**
     * 更新团队算力
     * @return [type] [description]
     */
    public function upd_team_power($path, $num, $act = 'inc'){
        if($path){
            $this->lock(true)->where(array('id' => array('in', $path)))->select();
            if($act == 'inc'){
                $result = $this->where(array('id' => array('in', $path)))->setInc('team_power', $num);               
            }else{
                $result = $this->where(array('id' => array('in', $path)))->setDec('team_power', $num);    
            }
            // echo $this->getlastsql();
            return $result;
        }else{
            return true;
        }
    }
    /**
     * 更新个人算力
     * @return [type] [description]
     */
    public function upd_power($id, $num, $act = 'inc'){
        $this->lock(true)->where(array('id' => $id))->select();
        if($act == 'inc'){
            $result = $this->where(array('id' => $id))->setInc('power', $num);               
        }else{
            $result = $this->where(array('id' => $id))->setDec('power', $num);    
        }
        return $result;
    }

    /**
     * 更新团队人数
     * @param  [type] $path [description]
     * @param  [type] $num  [description]
     * @param  string $act  [description]
     * @return [type]       [description]
     */
    public function upd_team_people_num($path, $num, $act = 'inc'){
        if($path){
            $this->lock(true)->where(array('id' => array('in', $path)))->select();
            if($act == 'inc'){
                $this->where(array('id' => array('in', $path)))->setInc('team_people_num', $num);               
            }else{
                $this->where(array('id' => array('in', $path)))->setDec('team_people_num', $num);    
            }
        }
        return true;
    }

    #以下操作需要验证签名
    /**
     * 修改矿机票mills
     */
    public function millsChange($member, $num, $act = 'inc'){
        if(!$this->_verify_sign($member)) return false;
        if($act == "inc"){
            $member['mills'] = new_bcadd($member['mills'], $num);
        }else{
            $member['mills'] = new_bcsub($member['mills'], $num);
        }
        $upd['sign'] = $this->_sign($member);
        $upd['mills']=$member['mills'];
        return $this->where(array('id' => $member['id']))->save($upd);
    }

    /**
     * 修改矿石ore
     */
    public function oreChange($member, $num, $act = 'inc'){
        if(!$this->_verify_sign($member)) return false;
        if($act == "inc"){
            $member['ore'] = new_bcadd($member['ore'], $num);
        }else{
            $member['ore'] = new_bcsub($member['ore'], $num);
        }
        $upd['sign'] = $this->_sign($member);
        $upd['ore']=$member['ore'];
        return $this->where(array('id' => $member['id']))->save($upd);
    }

    /**
     * 增加RC
     */
    public function score_inc($member, $num){
        if(!$this->_verify_sign($member)) return false;
        $member['score'] = new_bcadd($member['score'], $num);
        $upd['sign'] = $this->_sign($member);
        $upd['score'] =$member['score'];
        $result =  $this->where(array('id' => $member['id']))->save($upd);
        return $result;
    }

    /**
     * 减少RC
     */
    public function score_dec($member, $num){
        if(!$this->_verify_sign($member)) return false;
        $member['score'] = new_bcsub($member['score'], $num);
        $upd['sign'] = $this->_sign($member);
        $upd['score'] =$member['score'];
        return $this->where(array('id' => $member['id']))->save($upd);
    }

    /**
     * 减少冻结RC
     */
    public function scoreLock_dec($member, $num){
        if(!$this->_verify_sign($member)) return false;
        $member['score_lock'] = new_bcsub($member['score_lock'], $num);
        $upd['sign'] = $this->_sign($member);
        $upd['score_lock'] =$member['score_lock'];
        return $this->where(array('id' => $member['id']))->save($upd);
    }

    /**
     * 交易RC修改
     */
    public function scoreChange($member, $num ,$act = 'inc'){
        if(!$this->_verify_sign($member)) return false;
        if($act=='inc'){

            $member['score']       = new_bcadd($member['score'], $num);

            $member['score_lock'] = new_bcsub($member['score_lock'], $num);

        }else{
            $member['score']       = new_bcsub($member['score'], $num);

            $member['score_lock'] = new_bcadd ($member['score_lock'], $num);
        }
        $upd['sign']        = $this->_sign($member);
        $upd['score']       =  $member['score'] ;
        $upd['score_lock'] =  $member['score_lock'] ;
        return $this->where(array('id' => $member['id']))->save($upd);
    }
	
	/**
     * 根据手机号查用户信息 
     * @param  [type] $phone [description]
     * @param  string $field [description]
     * @return [type]        [description]
     */
    public function profilesByPhone($phone, $field = 'username'){
        return $this->field($field)->where(array('phone' => $phone))->select();
    }
	
    /**
     * 修改冻结的矿机票数量 mills_lock
     * @param  [type] $num [description]
     * @return [type]      [description]
     */
    public function millsLockChange($member, $num, $act = 'inc'){
        if(!$this->_verify_sign($member)) return false;
        if($act == "inc"){
            $member['mills_lock'] = new_bcadd($member['mills_lock'], $num);
        }else{
            $member['mills_lock'] = new_bcsub($member['mills_lock'], $num);
        }
        $upd['sign'] = $this->_sign($member);
        $upd['mills_lock']=$member['mills_lock'];
        return $this->where(array('id' => $member['id']))->save($upd);
    }
}