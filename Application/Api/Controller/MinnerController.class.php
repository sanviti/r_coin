<?php
/**
 * 兑换中心
 */
namespace Api\Controller;
use Think\Log;
use Think\Controller;
use Think\Model;
use Common\Lib\Constants;

class MinnerController extends BaseController{
	/**
     * 可兑换富链
     * @return [type] [description]
     */
	public function maxRc(){
		$member  = D("Members");
		//富链当前价格
		$tradingPriceModel  = D("TradingPrice");
		$nowPrice = $tradingPriceModel->getPrice();
		$memberInfo = $member->profiles($this->uid,'mills,ore,score');
		$maxRc['ore'] = $memberInfo['ore']/ $nowPrice['price'];
		succ($maxRc);
	}
	/**
     * 矿石兑换富链 富链 = 矿石除以当前价格
     * @return [type] [description]
     */
	public function oreToScore(){
		require_check_post("rc_num/s,pay_pwd/s");
        $rc_num = addslashes(I('rc_num/s'));//兑换富链个数
        $pay_pwd = addslashes(I('pay_pwd/s'));

		$memberModel  = D("Members");
		$logModel = M('userScoreLog');
		//富链当前价格
		$tradingPriceModel  = D("TradingPrice");
		$nowPrice = $tradingPriceModel->getPrice();

		$todayBegin = mktime(0,0,0,date('m'),date('d'),date('Y'));
		
		$memberInfo = $memberModel->profiles($this->uid,'mills,ore,score,pay_salt, pay_pwd');

		if(intval($memberInfo['ore']) < 100 ){
			err('至少拥有100个矿石才可兑换');
		}
		if(intval($rc_num) > ($memberInfo['ore']/$nowPrice['price'])){
			err( '矿石不足');
		}
		if(md5password($pay_pwd,$memberInfo['pay_salt']) != $memberInfo['pay_pwd']){
            err('支付密码错误');
        }

		//花费矿石
		$cost_ore = $rc_num *$nowPrice['price'];

		$memberModel->startTrans();
		//减矿石 ore
		$member = $memberModel->lock(true)->field('id,mills,mills_lock,ore,token,sign,score,score_lock,power')->where(array("id"=>$this->uid))->find();
		$member2 = $memberModel->lock(true)->field('id,mills,mills_lock,ore,token,sign,score,score_lock,power')->where(array("id"=>$this->uid))->find();

		$result =  $memberModel->oreChange($member, $cost_ore,'dec');
		if($result == false){
			$err = '签名失败';
		}else{
			$err = '';
		}

		$newOre = new_bcsub($member['ore'], $cost_ore);
		//用户日志 减矿石 矿石兑换富链
		$log = array('uid' => $member['id'], 'changeform' => 'out', 'subtype' => 8, 'num' => $rc_num, 'ctime' => NOW_TIME, 'balance' => $newOre, 'extends' => $todayBegin,'money_type'=>1);

		$result = $result && $logModel->add($log);
		if($err == '' && $result == false){
			$err = '插入日志失败';
		}
		
		//加富链 score
		$member = $memberModel->lock(true)->field('id,mills,mills_lock,ore,token,sign,score,score_lock,power')->where(array("id"=>$this->uid))->find();

		$result = $result && $memberModel->score_inc($member, $rc_num);
		if($result == false){
			$err = '签名失败';
		}else{
			$err = '';
		}
		//用户日志 加富链 矿石兑换富链
		$newScore = new_bcadd($member['score'], $rc_num);
		$log = array('uid' => $member['id'], 'changeform' => 'in', 'subtype' => 3, 'num' => $rc_num, 'ctime' => NOW_TIME, 'balance' => $newScore, 'extends' => $todayBegin,'money_type'=>3);

		$result = $result && $logModel->add($log);
		if($err == '' && $result == false){
			$err = '插入日志失败';
		}

		if($result){
			$memberModel->commit();
			succ('兑换成功');
		}else{
			$memberModel->rollback();
			err('兑换失败' .'[' . $err . ']');
		}
	}
	
	/**
     * 可兑换矿机票
     * @return [type] [description]
     */
	public function maxMills(){
		$member  = D("Members");
		$tradingPriceModel  = D("TradingPrice");
		$nowPrice = $tradingPriceModel->getPrice();
		$memberInfo = $member->profiles($this->uid,'mills,ore,score');
		$maxMills['score'] = $memberInfo['score'] * $nowPrice['price'];
		succ($maxMills);
	}
	/**
     * 富链兑换矿机票
     * @return [type] [description]
     */
	public function scoreToMills(){
		require_check_post("mills_num/s,pay_pwd2/s");
        $mills_num = addslashes(I('mills_num/s'));
        $pay_pwd = addslashes(I('pay_pwd2/s'));

		$memberModel  = D("Members");
		$logModel = M('userScoreLog');
		$todayBegin = mktime(0,0,0,date('m'),date('d'),date('Y'));

		$memberInfo = $memberModel->profiles($this->uid,'mills,ore,score,pay_salt, pay_pwd');
		if(intval($mills_num) > $memberInfo['score']){
			err('富链不足');
		}
		if(md5password($pay_pwd,$memberInfo['pay_salt']) != $memberInfo['pay_pwd']){
            err('支付密码错误');
        }
		
		$memberModel->startTrans();
		//减富链 score
		$member = $memberModel->lock(true)->field('id,mills,mills_lock,ore,token,sign,score,score_lock,power')->where(array("id"=>$this->uid))->find();
		$result =  $memberModel->score_dec($member, $mills_num);
		if($result == false){
			$err = '签名失败';
		}else{
			$err = '';
		}

		$newScore = new_bcsub($member['score'], $mills_num);
		//用户日志 减富链 富链兑换矿机票
		$log = array('uid' => $member['id'], 'changeform' => 'out', 'subtype' => 9, 'num' => $mills_num, 'ctime' => NOW_TIME, 'balance' => $newScore, 'extends' => $todayBegin,'money_type'=>3);

		$result = $result && $logModel->add($log);
		if($err == '' && $result == false){
			$err = '插入日志失败';
		}
		
		//加矿机票 mills
		$member = $memberModel->lock(true)->field('id,mills,mills_lock,ore,token,sign,score,score_lock,power')->where(array("id"=>$this->uid))->find();
		$result =  $memberModel->millsChange($member, $mills_num, $act = 'inc');
		if($result == false){
			$err = '签名失败';
		}else{
			$err = '';
		}
		//用户日志 加矿机票 富链兑换矿机票
		$newMills = new_bcadd($member['mills'], $mills_num);
		$log = array('uid' => $member['id'], 'changeform' => 'in', 'subtype' => 9, 'num' => $mills_num, 'ctime' => NOW_TIME, 'balance' => $newMills, 'extends' => $todayBegin,'money_type'=>2);

		$result = $result && $logModel->add($log);
		if($err == '' && $result == false){
			$err = '插入日志失败';
		}
		
		if($result){
			$memberModel->commit();
			succ('兑换成功');
		}else{
			$memberModel->rollback();
			err('兑换失败' .'[' . $err . ']');
		}
	}
	
	/**
     * 矿机票转赠
     * @return [type] [description]
     */
	public function sendMills(){
		require_check_post("moblie/s,send_num/s,pay_pwd/s,username/s");
        $phone = addslashes(I('moblie/s'));
        $send_num = addslashes(I('send_num/s/s'));
        $pay_pwd = addslashes(I('pay_pwd/s'));
        $username = addslashes(I('username/s'));

		$memberModel  = D("Members");
		$logModel = M('userScoreLog');
		$todayBegin = mktime(0,0,0,date('m'),date('d'),date('Y'));
        
		//矿机票转赠 mills From
		$millsFromInfo = $memberModel->profiles($this->uid,'mills,ore,score,pay_salt, pay_pwd');
		if(intval($send_num)<$millsFromInfo['mills']){
			$err = '矿机票不足';
		}
//		if(md5password($pay_pwd,$memberInfo['pay_salt']) != $memberInfo['pay_pwd']){
//            err('支付密码错误');
//        }

		$memberModel->startTrans();
		//矿机票转赠 减 From 的 mills
		$memberFrom = $memberModel->lock(true)->field('id,mills,mills_lock,ore,token,sign,score,score_lock,power')->where(array("id"=>$this->uid))->find();
		//矿机票转赠 加 To 的 mills
		$memberTo = $memberModel->lock(true)->field('id,mills,mills_lock,ore,token,sign,score,score_lock,power')->where(array("phone"=>$phone,"username"=>$username))->find();
		if(!$memberTo){
			err('用户不存在');
		}
		$result =  $memberModel->millsChange($memberFrom, $send_num, $act = 'dec');
		if($result == false){
			$err = '签名失败';
		}else{
			$err = '';
		}
		//用户日志 减矿机票 转赠矿机票
		$newMills = new_bcsub($memberFrom['mills'], $send_num);
		$log = array('uid' => $memberFrom['id'], 'changeform' => 'out', 'subtype' => 10, 'num' => $send_num, 'ctime' => NOW_TIME, 'balance' => $newMills, 'extends' => $memberTo['id'],'money_type'=>2);

		$result = $result && $logModel->add($log);
		if($err == '' && $result == false){
			$err = '插入日志失败';
		}

		//矿机票转赠 加 To 的 mills
		$result =  $memberModel->millsChange($memberTo, $send_num, $act = 'inc');
		if($result == false){
			$err = '签名失败';
		}else{
			$err = '';
		}
		//用户日志 加矿机票 转赠矿机票
		$newMills = new_bcadd($memberTo['mills'], $send_num);
		$log = array('uid' => $memberTo['id'], 'changeform' => 'in', 'subtype' => 10, 'num' => $send_num, 'ctime' => NOW_TIME, 'balance' => $newMills, 'extends' => $memberFrom['id'],'money_type'=>2);

		$result = $result && $logModel->add($log);
		if($err == '' && $result == false){
			$err = '插入日志失败';
		}
		
		if($result){
			$memberModel->commit();
			succ('转赠成功');
		}else{
			$memberModel->rollback();
			err('转赠失败' .'[' . $err . ']');
		}
		
	}
   
	/**
     * 矿机票转赠明细
     * @return [type] [description]
     */
	 public function millsSendList(){
		$memberModel  = D("Members");
		$logModel = M('userScoreLog');
		 $page = (int)I('post.page');
		
		//转入记录
		$inRecord = $logModel->alias("l")->field('l.uid,l.num,l.extends,l.ctime')->where(array('l.uid' => $this->uid,'l.subtype'=>10,'changeform'=>'out'))->page($page)->limit(10)->select();

		for($i=0;$i<count($inRecord);$i++){
			$user = $memberModel ->field('username')->where(array('id'=>$inRecord[$i]['uid']))->find();
			$inRecord[$i]['username'] = $user['username'];
			$inRecord[$i]['ctime'] = date("Y-m-d h:i:s",$inRecord[$i]['ctime']);;
		}
		//转出记录
		$outRecord = $logModel->alias("l")->field('l.uid,l.num,l.extends,l.ctime')->where(array('l.uid' => $this->uid,'l.subtype'=>10,'changeform'=>'in'))->page($page)->limit(10)->select();
		for($i=0;$i<count($outRecord);$i++){
			$user = $memberModel ->field('username')->where(array('id'=>$outRecord[$i]['extends']))->find();
			$outRecord[$i]['username'] = $user['username'];
			$outRecord[$i]['ctime'] = date("Y-m-d h:i:s",$outRecord[$i]['ctime']);;
		}

		//冻结
		$user = $memberModel->profiles($this->uid,'mills,ore,score,mills_lock');
		$frezz = $user['mills_lock'];
		//内部奖励
		$awards  = $logModel->field('sum(num) as award')->where(array('uid' => $this->uid,'subtype'=>11))->select();

		$data = array(
			'page' =>  $page,
            'award' => $awards[0]['award'],//内部奖励
            'frezz' => $frezz,//冻结
            'inRecord' => $inRecord,//转入记录
            'outRecord' => $outRecord,//转出记录
        );
        succ($data);

	 }
	private function p($str){
		if($str == 'start'){
			echo '###################################### START #######################################<br/>';
		}elseif($str == 'end'){
			echo '###################################### END #######################################<br/>';
		}else{
			echo $str."<br/>";
		}
	}
}