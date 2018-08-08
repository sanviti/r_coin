<?php
/**
 * 矿机票管理
 */
namespace DataAdmin\Controller;
use Think\Controller;
Use Think\Cache\Driver\Redis;
use Common\Lib\RestSms;
use Common\Lib\Constants;

class MinerTicketController extends BaseController{
	/**
     * 内部报单
     */
	public function reportOrder(){
		$username = I('username', '', 'trim');
        $stype = I('stype', '', 'intval');
        if($username){
            if($stype){
                $condi['username'] = array('like', '%'.$username.'%');
            }else{
                $condi['username'] = $username;
            }
            $params['username']   = $username;
        }        

        $phone = I('phone');
        if($phone){
            $params['phone'] = $phone;
            $condi['phone'] = $phone;
        }

        $page = IS_POST ? 1 : I('get.p');
        $model = D('members');
        $count = $model -> getCount($condi);
        $p = getpage($count, C('PAGE_SIZE'), $params);
        $show = $p -> newshow($params);
        $list = $model -> getList($condi, $page, '');
		// dump($list);
		// exit;
        $this -> assign('page', $show);

        $this -> assign('list', $list);
        $this -> display();
	}
	/**
     * 转赠矿机票
     */
	public function giveTicket(){
		$id = I('id');
		$model = D('members');
		$detail = $model->where(array('id'=>$id))->find();
		$id = I('id/d', '', 'intval');
        if(!$id) $this->error('请选择要转赠矿机票的用户');
		
		$this -> assign('detail', $detail);
        $this->display();
	}
	/**
     * save矿机票
     */
	public function saveMills(){
		if($err = admin_require_check('id,giveNum,extends')) $this->error($err);
		$memberModel  = D("Api/Members");
		$logModel = M('userScoreLog');
		
		$uid    = trim(I('post.id')); 
		$mills_num = trim(I('post.giveNum')); 
		$extends = trim(I('post.extends'));  
		
		$memberModel->startTrans();
		//加矿机票 mills
		$member = $memberModel->lock(true)->field('id,mills,mills_lock,ore,token,sign,score,score_lock,power')->where(array("id"=>$uid))->find();
		$result = $memberModel->millsChange($member, $mills_num, $act = 'inc');
		if($result == false){
			$err = '签名失败';
		}else{
			$err = '';
		}
		//用户日志 加矿机票 转赠矿机票
		$newMills = new_bcadd($member['mills'], $mills_num);
		$log = array('uid' => $member['id'], 'changeform' => 'in', 'subtype' => 11, 'num' => $mills_num, 'ctime' => NOW_TIME, 'balance' => $newMills, 'extends' => $extends,'money_type'=>2);

		$result = $result && $logModel->add($log);
		if($err == '' && $result == false){
			$err = '插入日志失败';
		}
		
		if($result){
			$memberModel->commit();
			$this -> success('转赠成功');
		}else{
			$memberModel->rollback();
			$this -> error('转赠失败' .'[' . $err . ']');
		}
	}
	
	
	/**
     * 奖励发放
     */
	public function giveAward(){
		$username = I('username', '', 'trim');
        $stype = I('stype', '', 'intval');
        if($username){
            if($stype){
                $condi['username'] = array('like', '%'.$username.'%');
            }else{
                $condi['username'] = $username;
            }
            $params['username']   = $username;
        }        

        $phone = I('phone');
        if($phone){
            $params['phone'] = $phone;
            $condi['phone'] = $phone;
        }

        $page = IS_POST ? 1 : I('get.p');
        $model = D('members');
        $count = $model -> getCount($condi);
        $p = getpage($count, C('PAGE_SIZE'), $params);
        $show = $p -> newshow($params);
        $list = $model -> getList($condi, $page, '');
		// dump($list);
		// exit;
        $this -> assign('page', $show);
        $this -> assign('list', $list);
        $this -> display();
	}
	/**
     * 发放奖励矿机票
     */
	public function sendTicket(){
		$id = I('id');
		$model = D('members');
		$detail = $model->where(array('id'=>$id))->find();
		$id = I('id/d', '', 'intval');
        if(!$id) $this->error('请选择要发送奖励的用户');
		
		$this -> assign('detail', $detail);
        $this->display();
	}
	
	/**
     * SAVE奖励的矿机票
     */
	public function saveAward(){
		if($err = admin_require_check('id,award,inviteAward,extends')) $this->error($err);
		$memberModel  = D("Api/Members");
		$logModel = M('userScoreLog');
		
		$uid    = trim(I('post.id')); 
		$mills_num = trim(I('post.award')) + trim(I('post.inviteAward')); 
		$extends = trim(I('post.extends'));  
		
		$memberModel->startTrans();
		//加矿机票 mills
		$member = $memberModel->lock(true)->field('id,mills,mills_lock,ore,token,sign,score,score_lock,power')->where(array("id"=>$uid))->find();
		$result = $memberModel->millsChange($member, $mills_num, $act = 'inc');
		if($result == false){
			$err = '签名失败';
		}else{
			$err = '';
		}
		//用户日志 加矿机票 转赠矿机票
		$newMills = new_bcadd($member['mills'], $mills_num);
		$log = array('uid' => $member['id'], 'changeform' => 'in', 'subtype' => 11, 'num' => $mills_num, 'ctime' => NOW_TIME, 'balance' => $newMills, 'extends' => $extends,'money_type'=>2);

		$result = $result && $logModel->add($log);
		if($err == '' && $result == false){
			$err = '插入日志失败';
		}
		
		if($result){
			$memberModel->commit();
			$this -> success('奖励成功');
		}else{
			$memberModel->rollback();
			$this -> error('奖励失败' .'[' . $err . ']');
		}
	}
	
	/**
     * 报单列表
     */
	public function orderList(){
		
		$rname = I('username', '', 'trim');
        $phone = I('phone');
		$memberModel = D('members');
		$logModel = M('userScoreLog');
		
        if($rname){
            $params['username']   = $rname;
			$list = $memberModel->where(array('username'=>$rname))->select();
			$uids = '';
            foreach($list as $item){
                $uids .= $uids == '' ? $item['id'] : ',' . $item['id'];
            }
			
			$condi['l.uid'] = array('in', $uids);
        }        

        if($phone){
            $params['phone'] = $phone;
			$list = $memberModel->where(array('phone'=>$phone))->select();
			
			
			$uids = '';
            foreach($list as $item){
                $uids .= $uids == '' ? $item['id'] : ',' . $item['id'];
            }
			
			$condi['l.uid'] = array('in', $uids);
        }
		
		
		$condi['subtype'] = 11;

        $page = IS_POST ? 1 : I('get.p');
        
		
        $count = $logModel -> where($cond)->count();
        $p = getpage($count, C('PAGE_SIZE'), $condi);
        $show = $p -> newshow($params);
        $list = $this -> getList($condi, $page, '');
        // dump($list);
        // exit;
        $this -> assign('page', $show);

        $this -> assign('list', $list);
        $this -> display();
	}
	
	private function getCount($condi = array()){
        $map = array('userid'=>array('exp','IS NOT NULL'));
        $condi = array_merge($map, (array) $condi);
        return $this->where()->count();
    }
	
		/**
     * 用户列表
	 * @param $where 搜索条件
	 * @param $page  当前页
     */
	public function getList($where, $page = 1){
        $map = array('l.uid'=>array('exp','IS NOT NULL'));
        $where = array_merge($map, (array)$where);
		$logModel = M('userScoreLog');
		$model = M('members');
		
		$list = $logModel->alias('l')->field('l.*,m.username ,m.phone,m.ore ,m.mills , m.score, m.score_lock')
					-> join('data_members as m on l.uid = m.id','LEFT')
					-> where($where)
					-> page($page)
					-> order('l.id desc')
					-> limit(C('PAGE_SIZE'))
					-> select();
		return $list;
	}
	
	/**
     * 矿机票释放
	 * @param $where 搜索条件
	 * @param $page  当前页
     */
	 public function setFreeMills(){
		 
	 }
	
} 