<?php
/**
 * 个人中心控制器
 * 217-11-26
 * lxy
 */
namespace Api\Controller;
Use Think\Controller;
Use Think\Model;
Use Think\Log;
Use Api\Common\MsgSendUtil;
use Common\Lib\Constants;

class MembersController extends BaseController{

    /*
     * 账户管理 (个人中心首页数据)
     * 
     * */
    public  function  account(){
        $member  = D("Members");
        $acctInfo=$member->profiles($this->uid,'userid,username,nickname,headimg,member_tag,phone');
        $acctInfo['headimg'] = file_exists(substr($acctInfo['headimg'], 1)) ? $acctInfo['headimg'] : '/Public/Wap/img/headimg_default.jpg';
        succ($acctInfo);
    }
    /*
     * 我的资产
     *
     * */
    public  function  myAssets(){
        $member  = D("Members");
        $acctInfo=$member->profiles($this->uid,'nickname,headimg,mills,mills_lock,ore,score,score_lock,reg_time');
        $acctInfo['today'] = date("Y年m月d日", time());
        //矿机数量
        $acctInfo['millNum'] = $this->millNum();
        $acctInfo['reg_time'] = $this->count_days(strtotime(date("Y-m-d")),strtotime(date("Y-m-d", $acctInfo['reg_time'])));
        $acctInfo['headimg'] = file_exists(substr($acctInfo['headimg'], 1)) ? $acctInfo['headimg'] : '/Public/Wap/img/headimg_default.jpg';
        succ($acctInfo);
    }
    private  function count_days($a,$b){
        $a_dt=getdate($a);
        $b_dt=getdate($b);
        $a_new=mktime(12,0,0,$a_dt['mon'],$a_dt['mday'],$a_dt['year']);
        $b_new=mktime(12,0,0,$b_dt['mon'],$b_dt['mday'],$b_dt['year']);
        return round(abs($a_new-$b_new)/86400);
    }
    //矿机数量
    public function millNum(){
        //状态
        $condi['uid'] = $this->uid;
        $millModel = M(get_mill_table($this->uid));
        //已过期
        $condi['status']  = 0;
        $data['millStop'] = $millModel->where($condi)->count();
        //运行中
        $condi['status']  = 1;
        $data['millRuning'] = $millModel->where($condi)->count();
        $num = $data['millStop'] + $data['millRuning'];
        return $num;
    }

    /**
     * [memberInfo 个人信息]
     * @return JSON
     */
    public function memberInfo(){
        $member  = D("Members");
        $acctInfo=$member->profiles($this->uid,'username,phone,mills,mills_lock,ore,score,score_lock,nickname');
        $member_dep = $member->member_dep($this->uid, 'bank_name,card_number,card_name,alipay_account,weixin_account');
        $member_dep['card_number'] = !empty($member_dep['card_number']) ? $this->_handlCard($member_dep['card_number']) : '';
        $member_dep = $member_dep ? $member_dep : array('alipay_account' => '未添加', 'weixin_account' => '未添加');
        $member_dep['alipay_account'] = empty($member_dep['alipay_account']) ? '未添加' : $member_dep['alipay_account'];
        $member_dep['weixin_account'] = empty($member_dep['weixin_account']) ? '未添加' : $member_dep['weixin_account'];
        $member_dep['card_name'] = empty($member_dep['card_name']) ? '' : $member_dep['card_name'];
        $acctInfo = array_merge($acctInfo, $member_dep);
        succ($acctInfo);
    }
    public function query_auth(){
        require_check_post("type/d");
        $type = (int)I('post.type');
        $map_c1 = array(
            'uid' => $this->uid,
            'type' => $type,
            'status' => array('IN', '0,1')
        );
        $mod_auths = M('auths');
        $auth_info = $mod_auths->where($map_c1)->find();
        if ($auth_info) {
            succ($auth_info);
        }
        err();
    }
    /**
     * [editInfo 修改个人信息]
	 * param nickname
	 * param sex
	 * param headimg
     * @return JSON
     */
    public function editInfo(){
        $info_data = array();
        if (isset($_POST['nickname'])) {
            require_check_post("nickname/s");
            $info_data['nickname'] =addslashes(I('nickname/s'));
        }
        if (isset($_POST['sex'])) {
            $info_data['sex'] =addslashes(I('sex/s'));
        }
        if (isset($_POST['member_tag'])) {
            $info_data['member_tag'] =addslashes(I('member_tag/s'));
        }
        if (isset($_POST['photo'])) {
            $info_data['headimg'] =addslashes(I('photo/s'));
        }
        $memberModel = D('members');
        $result = $memberModel->modify($this->uid, $info_data);
        succ('修改成功！');
    }
    /**
     * [editMemberDep 修改会员副表信息]
     * @return JSON
     */
    public function editMemberDep(){
        $info_data = array();
        if (isset($_POST['alipay_account'])) {
            require_check_post("alipay_account/s");
            $info_data['alipay_account'] =addslashes(I('alipay_account/s'));
        }
        if (isset($_POST['weixin_account'])) {
            require_check_post("weixin_account/s");
            $info_data['weixin_account'] =addslashes(I('weixin_account/s'));
        }
		if (isset($_POST['other_payment'])) {
            require_check_post("other_payment/s");
            $info_data['other_payment'] =addslashes(I('other_payment/s'));
        }
		
        $memberModel = D('members');
        $result = $memberModel->modify_memberdep($this->uid, $info_data);
        succ('修改成功！');
    }
    /**
     * [laborUnion 我的团队]
     * @return JSON
     */
    public function laborUnion(){
        $memberRegion  = D("members_region");
        $data['apower']=(float)number_format($memberRegion->areaA($this->uid),2,'.','')  ;
        $data['bpower']=(float)number_format($memberRegion->areaB($this->uid),2,'.','')  ;
       $data['apeople']=(int)$memberRegion->areaAnum($this->uid);
       $data['bpeople']=(int)$memberRegion->areaBnum($this->uid);
        succ($data);
    }
    /**
     * [myDirect 我的推荐]
     * @return JSON
     */
    public function myDirect(){
        $map = array(
            'uid' => $this->uid
        );
        $membersRegion=D('members_region');
        $regionInfo=$membersRegion->where($map)->field('lid,rid')->find();
       $lid=$regionInfo['lid'];
       $rid=$regionInfo['rid'];
        $page = (int)I('post.page', 1);
        $perpage = 15;
        $mod_member = M('members');
       if($lid && $rid){
            $where="(path like '%".$lid."%' or path like '%".$rid."%')";
        }elseif($rid){
            $where="(path like '%".$rid."%')";
        }elseif($lid){
            $where="(path like '%".$lid."%')";
        }else{
           err();
       }
        //时间范围
        $end_time = time();
        $end = I('end/s');
        if($end){
            $end_time = strtotime($end) + 3600 * 24;
        }

        $begin = I('begin/s');
        if($begin){
            $begin = strtotime($begin);
            $where.=" and reg_time>=".$begin ." and   reg_time<".$end_time;
        }else{
            $where.=" and   reg_time<".$end_time;
        }
        $phone=I('phone');
        if(I('phone')){
            $where.=" and   phone=".$phone;
        }

        $member_list = $mod_member
        ->field('id,reg_time,nickname,username,cast(team_power as decimal(10,2)) as team_power,path')
        ->where($where)
        ->order('id DESC')
        ->limit(($page - 1) * $perpage, $perpage)
        ->select();

        if (!$member_list) {
            err();
        }else{
            foreach($member_list as &$vo){
				$vo['reg_time'] = date("Y/m/d",$vo['reg_time'])."</br>".date("h:i:s",$vo['reg_time']);
                $path=explode(",",$vo['path']);
                if(in_array($lid,$path)){
                    $vo['area']='A';
                }else{
                    $vo['area']='B';
                }

            }
        }
        $page++;
        $result = array(
            'page' => $page,
            'member_list' => $member_list
        );
        succ($result);
    }
    /**
     * 分享二维码
     * @return [type] [description]
     */
    public function share(){

        $memberModel = D('members');
        $member = $memberModel->profiles($this->uid, 'recom_lid_token,recom_rid_token');
        $area=I('area');

        switch($area){
            case 'A':
            $recom=$member['recom_lid_token'];
            break;
            case 'B':
            $recom=$member['recom_rid_token'];
            break;
            default:
            $recom=$member['recom_lid_token'];
        }
        if($member){
            $member_dep = $memberModel->member_dep($this->uid,'qrcode_lid_rec,qrcode_rid_rec');

            $shareUrl = Constants::BASE_URL . '/Wap/Login/register/lid/' .$recom . '.html';
            //生成二维码

            if($area=='A'){
                if($member_dep['qrcode_lid_rec'] == '' || !is_file('.' . $member_dep['qrcode_lid_rec'])){
                    $fileName=md5(rand(0,9999).microtime().$this->uid);
                    $qr = $this->create_qrcode($fileName, $shareUrl);
                    $memberModel->modify_memberdep($this->uid, array('qrcode_lid_rec' => $qr));
                }else{
                    $qr = $member_dep['qrcode_lid_rec'];
                }
            }else{
                if($member_dep['qrcode_rid_rec'] == '' || !is_file('.' . $member_dep['qrcode_rid_rec'])){
                    $fileName=md5(rand(0,9999).microtime().$this->uid);
                    $qr = $this->create_qrcode($fileName, $shareUrl);
                    $memberModel->modify_memberdep($this->uid, array('qrcode_rid_rec' => $qr));
                }else{
                    $qr = $member_dep['qrcode_rid_rec'];
                }
            }



            $data = array(
                'url' => $shareUrl,
                'shareid' => $recom,
                'qrcode' => $qr,
            );
            succ($data);
        }
    }

    /**
     * 生成推荐二位码
     * @param $id
     * @return string
     */
    private function create_qrcode($userid, $val){
        $filename = $userid.'.png';
        $path = './Uploads/qrcode/'.date('Y-m-d').'/';
        if(!is_dir($path)){
            mkdir($path);
        }
        import('Vendor.phpqrcode.phpqrcode','','.php');
        $errorCorrectionLevel = 'L';//容错级别
        $matrixPointSize = 6;//生成图片大小
        \QRcode::png($val, $path.$filename, $errorCorrectionLevel, $matrixPointSize,1,0);
        return ltrim($path.$filename,'.');
    }
    /**
     * [auth_c1 C1认证]
     * @return JSON
     */
    public function auth_c1(){
        $map_c1 = array(
            'uid' => $this->uid,
            'type' => 1,
            'status' => array('IN', '0,1')
        );
        $mod_auths = M('auths');
        $mod_auths->startTrans();
        $auth_info = $mod_auths->lock(true)->where($map_c1)->find();
        if ($auth_info) {
            if ($auth_info['status'] == 0) {
                $mod_auths->rollback();
                err('C1认证审核中，请勿重复提交！');
            }
            if ($auth_info['status'] == 1) {
                $mod_auths->rollback();
                err('C1已认证成功，请勿重复提交！');
            }
        }
        require_check_post("rname/s,idcard/s");
        $rname   = addslashes(I('rname/s'));
        $idcard = addslashes(I('idcard/s'));
        if (!validation_filter_id_card($idcard)) {
            $mod_auths->rollback();
            err('身份证号码不正确！');
        }
        $map_check = array(
            'type' => 1,
            'idcard' => $idcard,
            'status' => array('IN', '0,1')
        );
        $auth_info = $mod_auths->where($map_check)->find();
        if ($auth_info) {
            $mod_auths->rollback();
            err('身份证号码已提交过认证');
        }
        $auth_data = array(
            'uid' => $this->uid,
            'idcard' => $idcard,
            'rname' => $rname,
            'type' => 1,
            'status' => 0,
            'ctime' => time()
        );
        if ($mod_auths->add($auth_data)) {
            $mod_auths->commit();
            succ('提交成功，请等待审核！');
        } else {
            $mod_auths->rollback();
            err('网络繁忙，请稍后再试！');
        }
    }
     /**
     * [auth_c2 C2认证]
     * @return JSON
     */
    public function auth_c2(){
        $member  = D("Members");
        $member_dep = $member->member_dep($this->uid, 'bank_name,card_number,card_name,alipay_account,weixin_account');
        
        /* if (empty($member_dep['bank_name']) || empty($member_dep['card_number']) || empty($member_dep['card_name']) || empty($member_dep['alipay_account']) || empty($member_dep['weixin_account'])) {
            err('请先完善：银行卡、微信和支付宝');
        } */
        $map_c1 = array(
            'uid' => $this->uid,
            'type' => 2,
            'status' => array('IN', '0,1')
        );
        $mod_auths = M('auths');
        $mod_auths->startTrans();
        $auth_info = $mod_auths->lock(true)->where($map_c1)->find();
        if ($auth_info) {
            if ($auth_info['status'] == 0) {
                $mod_auths->rollback();
                err('C2认证审核中，请勿重复提交！');
            }
            if ($auth_info['status'] == 1) {
                $mod_auths->rollback();
                err('C2已认证成功，请勿重复提交！');
            }
        }
        require_check_post("rname/s,idcard/s");
        $rname   = addslashes(I('rname/s'));
        $idcard = addslashes(I('idcard/s'));
        $photo = addslashes(I('photo/s'));
        if (!validation_filter_id_card($idcard)) {
            $mod_auths->rollback();
            err('身份证号码不正确！');
        }
        if (empty($photo)) {
            
            err('请上传手持身份证照片！');
        }
        $map_check = array(
            'type' => 2,
            'idcard' => $idcard,
            'status' => array('IN', '0,1')
        );
        $auth_info = $mod_auths->where($map_check)->find();
        if ($auth_info) {
            $mod_auths->rollback();
            err('身份证号码已提交过认证');
        }
        $auth_data = array(
            'uid' => $this->uid,
            'idcard' => $idcard,
            'rname' => $rname,
            'photo' => $photo,
            'type' => 2,
            'status' => 0,
            'ctime' => time()
        );
        if ($mod_auths->add($auth_data)) {
            $mod_auths->commit();
            succ('提交成功，请等待审核！');
        } else {
            $mod_auths->rollback();
            err('网络繁忙，请稍后再试！');
        }
    }

    /**
     * 修改登录密码
     * @param  str $opwd 旧密码
     * @param  str $npwd 新密码
     */
    public function editpwd(){
        require_check_post("opwd/s,npwd/s,npwd2/s");
        $opwd   = addslashes(I('opwd/s'));
        $npwd = addslashes(I('npwd/s'));
        $npwd2 = addslashes(I('npwd2/s'));
        if ($npwd != $npwd2) {
            err('新密码与确认密码不一致');
        }
        $memberModel = D('members');
        $user = $memberModel -> normalMember($this->uid, 'salt, pwd');
        if(md5password($opwd,$user['salt']) != $user['pwd']){
            err('原密码错误');
        }
        list($pwd,$salt) = md5password($npwd);
        $data = array('pwd' => $pwd, 'salt' => $salt);
        if($memberModel->modify($this->uid, $data)){
            succ("操作成功");
        }else{
            err("操作失败");
        }
    }
    /**
     * 修改登录密码
     * @param  str $opwd 旧密码
     * @param  str $npwd 新密码
     */
    public function edipaytpwd(){
        require_check_post("opwd/s,npwd/s,npwd2/s");
        $opwd   = addslashes(I('opwd/s'));
        $npwd = addslashes(I('npwd/s'));
        $npwd2 = addslashes(I('npwd2/s'));
        if ($npwd != $npwd2) {
            err('新密码与确认密码不一致');
        }
        $memberModel = D('members');
        $user = $memberModel -> normalMember($this->uid, 'pay_salt, pay_pwd');
        if(md5password($opwd,$user['pay_salt']) != $user['pay_pwd']){
            err('原密码错误');
        }
        list($pay_pwd,$pay_salt) = md5password($npwd);
        $data = array('pay_pwd' => $pay_pwd, 'pay_salt' => $pay_salt);
        if($memberModel->modify($this->uid, $data)){
            succ("操作成功");
        }else{
            err("操作失败");
        }
    }
    public function resetpayPwd(){
        require_check_post("smscode/s,npwd/s,npwd2/s");
        $smscode   = addslashes(I('smscode/s'));
        $npwd = addslashes(I('npwd/s'));
        $npwd2 = addslashes(I('npwd2/s'));
        if ($npwd != $npwd2) {
            err('新密码与确认密码不一致');
        }
        $memberModel = D('members');
        $user = $memberModel -> normalMember($this->uid, 'phone');
        //验证码检测
        $codeModel = D('Validcode');
        if($codeModel -> expires($user['phone'],$smscode,Constants::SMS_RESETPAYPWD_CODE)){
            err('短信验证码错误或已失效');
        }
        list($pay_pwd,$pay_salt) = md5password($npwd);
        $data = array('pay_pwd' => $pay_pwd, 'pay_salt' => $pay_salt);
        if($memberModel->modify($this->uid, $data)){
            succ("操作成功");
        }else{
            err("操作失败");
        }
    }

    /**
     * 添加银行卡
     * @param str $truename   姓名
     * @param str $bankname   银行名称
     * @param str $card       卡号
     */
    public function BankCard(){
        require_check_post("card_name/s,bank_name/s,card_number/s");
        $dep_data = array(
            'bank_name' => addslashes(I('bank_name/s')),
            'card_name' => addslashes(I('card_name/s')),
            'card_number' => addslashes(I('card_number/s'))
        );
        $memberModel = D('members');
        $member_depInfo = $memberModel->member_dep($this->uid);
        if ($memberModel->modify_memberdep($this->uid, $dep_data)) {
            succ("操作成功");
        } else {
            err("操作失败");
        }
    }
    
    /**
     * 给银行卡号加*
     * @param  [type] $card [description]
     * @return [type]       [description]
     */
    private function _handlCard($card){
        $newcard = substr($card,-4);
        $newcard = "**** **** **** ".$newcard;
        return $newcard;
    }


    /**
     * 会员头像
     * @Author 刘晓雨    2016-03-30
     * @param  int $userid    用户ID
     * @param  file $headimg  头像文件['jpg', 'gif', 'png', 'jpeg']
     */
    public function headimg(){
        if(IS_POST){
            // log::write("请求方式".$_SERVER['REQUEST_METHOD'],Log::DEBUG);
            // log::write("headimg:开始","WARW");
            // log::write(var_export($_FILES,true),"WARW");
            // log::write("headimg结束","WARW");
            if(!empty($_FILES['headimg'])){
                $filename = 'headimg'.strval($this->uid). '-' . NOW_TIME . create_code();
                $rootpath = './Uploads/headimg/';
                $saveExt = "jpg";
                $thumbname = $filename."-thumb";
                $upload = new \Think\Upload();
                $upload->maxSize   =     3145728 ;
                $upload->exts      =     array('jpg', 'gif', 'png', 'jpeg');
                $upload->saveExt   =     $saveExt;
                //$upload->autoSub   =     false;
                $upload->saveName  =     $filename;
                $upload->replace   =     true;
                $upload->rootPath  =     $rootpath;
                $info   =   $upload->uploadOne($_FILES['headimg']);
                if($info){
                    $img = $upload->rootPath.$info['savepath'].$info['savename'];
                }else{
                    err($upload->getError());
                }
                // dump($img);
                $thumb = $rootpath.date('Y-m-d').'/'.$thumbname.'.'.$saveExt;
                $image = new \Think\Image();
                $image->open($img)->thumb(160,160,1)->save($thumb);
                $userModel = D("Members");
                $res = $userModel->modify($this->uid, array("headimg"=>ltrim($thumb,".")));
                // log::write(ltrim($thumb,"."),"WARW");
                succ("上传成功",$this->output(array('headimg' => ltrim($thumb,"."))));
            }else{
                err("请上传文件");
            }
        }
    }




    /**
     * [getProblem 客服中心问题反馈]
     * @return JSON
     */
    public function getproblem(){
        require_check_post("content/s");
        $content = addslashes(I('content/s'));
        $problem_type = addslashes(I('problem_type/s'));
        if (empty($problem_type)) {
            err('请填写问题类型！');
        }
        if (empty($content)) {
            err('请填写问题描述！');
        }
        $problem_data = array(
            'uid' => $this->uid,
            'problem_type' => $problem_type,
            'content' => $content,
            'add_time' => time()
        );
        $problem_data['screen_img'] = '';
        if (M('feedback')->add($problem_data)) {
            succ('问题已提交，工作人员会尽快处理！');
        }
        err('网络繁忙，请稍后再试！');
    }


}

