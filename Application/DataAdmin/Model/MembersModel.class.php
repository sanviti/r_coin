<?php
/**
 * 后台用户
 * 2017-11-28 
 * lxy
 */
namespace DataAdmin\Model;
use Think\Model;
use Common\Lib\Constants;

class MembersModel extends Model {
	protected $tableName = 'members';
	/**
     * 查找正常用户
	 * @param $where 搜索条件
     */
    public function normalMember($condi, $fields = '*'){
    	$condi['is_lock'] = 0;
    	$condi['isfreeze'] = 0;
		$res = $this->field($fields)->where($condi)->find();
		return $res;
	}

	

    public function getCount($condi = array()){
        $map = array('userid'=>array('exp','IS NOT NULL'));
        $condi = array_merge($map, (array) $condi);
        return $this->where($condi)->count();
    }

	/**
     * 用户列表
	 * @param $where 搜索条件
	 * @param $page  当前页
     */
	public function getList($where, $page = 1){
        $map = array('userid'=>array('exp','IS NOT NULL'));
        $where = array_merge($map, (array)$where);
		$list = $this->field('id,userid,nickname as rname,phone,auth_c1,auth_c2,reg_time,login_time,is_lock,is_freeze,headimg,login_ip,score_lock,power,team_power,team_people_num,ore,score,mills,mills_lock,score_lock')
					-> where($where)
					-> page($page)
					-> order('id desc')
					-> limit(C('PAGE_SIZE'))
					-> select();
		return $list;
	}

	public function getMember($id,$field = 'id,token,balance,balance_tx,score1,score2,score3'){
		return $this->where(array('id' => $id))->find();
	}

     /**
     * 签名
     * @return [type] [description]
     */
    public function _sign($data){
        return sha1(Constants::SIGN_SALT . $data['token'] . $data['score'] . $data['score_lock']);
    }

    /**
     * 验证签名
     * @param  [type] $uid [description]
     * @return [type]      [description]
     */
    public function _verify_sign($data){
        // dump($data);
        $sign = sha1(Constants::SIGN_SALT . $data['token'] . $data['score'] . $data['score_lock']);
        // dump($sign);
        
        return $sign == $data['sign'] ? true : false;
    }

    #以下操作需要验证签名
    /**
     * 冻结opc
     */
    public function score2lock($member, $num){
        if(!$this->_verify_sign($member)) return false;        
        $upd['score_lock'] = new_bcadd($member['score_lock'], $num);
        $upd['score'] = new_bcsub($member['score'], $num);
        $upd['token'] = $member['token'];
        $upd['sign'] = $this->_sign($upd);
        unset($upd['token']);
        return $this->where(array('id' => $member['id']))->save($upd);
    }

    /**
     * 减少冻结opc
     */
    public function score_lock_dec($member, $num){
        if(!$this->_verify_sign($member)) return false;  
        $upd['score_lock'] = new_bcsub($member['score_lock'], $num);
        $upd['score'] = $member['score'];
        $upd['token'] = $member['token'];
        $upd['sign'] = $this->_sign($upd);
        unset($upd['token']);
        return $this->where(array('id' => $member['id']))->save($upd);
    }

    /**
     * 增加opc
     */
    public function score_inc($member, $num){
        if(!$this->_verify_sign($member)) return false;     
        $upd['score'] = new_bcadd($member['score'], $num);
        $upd['score_lock'] = $member['score_lock'];
        $upd['token'] = $member['token'];
        $upd['sign'] = $this->_sign($upd);        
        unset($upd['token']);
        $result =  $this->where(array('id' => $member['id']))->save($upd);
        return $result;
    }

    /**
     * 减少opc
     */
    public function score_dec($member, $num){
        if(!$this->_verify_sign($member)) return false;     
        $upd['score'] = new_bcsub($member['score'], $num);
        $upd['score_lock'] = $member['score_lock'];
        $upd['token'] = $member['token'];
        $upd['sign'] = $this->_sign($upd);        
        unset($upd['token']);
        return $this->where(array('id' => $member['id']))->save($upd);
    }

    /**
     * 解冻opc
     */
    public function lock2score($member, $num){
        if(!$this->_verify_sign($member)) return false;
        $upd['score'] = new_bcadd($member['score'], $num);
        $upd['score_lock'] = new_bcsub($member['score_lock'], $num);
        $upd['token'] = $member['token'];
        $upd['sign'] = $this->_sign($upd);
        unset($upd['token']);
        return $this->where(array('id' => $member['id']))->save($upd);
    }
}