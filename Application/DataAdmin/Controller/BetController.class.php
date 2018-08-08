<?php
/**
 * 世界杯竞猜活动
 */
namespace DataAdmin\Controller;
use Think\Controller;
class BetController extends BaseController {
    public function betList(){
        $page = IS_POST ? 1 : I('get.p'); //提交搜索的时候重置page参数
        $model = M('world_cup_bet');
        $count = $model-> count();
        $params['p']=I('get.p');
        $p = getpage($count, C('PAGE_SIZE'), $params);
        $show = $p -> show();
        $list = $model
        -> alias('world_cup_bet')
        ->  page($page)
        ->  order('id desc') -> limit(C('PAGE_SIZE')) -> select();
        $this -> assign('page', $show);
        $this -> assign('list', $list);
        $this -> display();
    }

    public function betAdd(){
        if(IS_AJAX){
            if($err = admin_require_check('title')) $this->error($err);
            $data['title']      = trim(I('post.title', '', 'htmlspecialchars,trim'));    
            $count = M('world_cup_bet')->where('title = "%s"', $data['$title'])->count();
            if($count) $this->error('已存在');   
            $data['left_team']    = trim(I('post.left_team')); 
            $data['left_team_pic'] = trim(I('post.left_team_pic')); 
            $data['right_team'] = trim(I('post.right_team'));           
            $data['right_team_pic'] = trim(I('post.right_team_pic'));           
            $data['total_bet']     = trim(I('post.total_bet'));           
            $data['vs_score']     = trim(I('post.vs_score'));              
            $data['sort']     = trim(I('post.sort'));              
            $data['win_team']     = trim(I('post.win_team'));            
            if(strtotime(trim(I('post.bet_start_time')))!=0)            
            $data['bet_start_time']= strtotime(trim(I('post.bet_start_time')));
		
			if(strtotime(trim(I('post.bet_end_time')))!=0)    
            $data['bet_end_time']= strtotime(trim(I('post.bet_end_time')));
		
			if(strtotime(trim(I('post.race_start_time')))!=0)    
            $data['race_start_time']= strtotime(trim(I('post.race_start_time')));
		
			if(strtotime(trim(I('post.race_end_time')))!=0)    
            $data['race_end_time']= strtotime(trim(I('post.race_end_time')));
            if(M('world_cup_bet')->add($data)){
                $this->success('保存成功');
            }else{
                $this->error('保存失败');
            }
        }
        $this->display();
    }

    public function betEdit(){
        $id = I('id/d', '', 'intval');
        if(!$id) $this->error('请选择要的修');

        $detail = M('world_cup_bet')->where('id = %d', $id)->find();
        if(!$detail) $this->error('轮播图不存在');

        if(IS_AJAX){
            if($err = admin_require_check('title')) $this->error($err);
            $data['title']      = trim(I('post.title', '', 'htmlspecialchars,trim'));    
            $count = M('world_cup_bet')->where('title = "%s"', $data['$title'])->count();
            if($count) $this->error('已存在');   
            $data['left_team']    = trim(I('post.left_team')); 
            $data['left_team_pic'] = trim(I('post.left_team_pic')); 
            $data['right_team'] = trim(I('post.right_team'));           
            $data['right_team_pic'] = trim(I('post.right_team_pic'));           
            $data['total_bet']     = trim(I('post.total_bet'));           
            $data['vs_score']     = trim(I('post.vs_score')); 
			$data['sort']     = trim(I('post.sort')); 			
            $data['win_team']     = trim(I('post.win_team'));  
			if(strtotime(trim(I('post.bet_start_time')))!=0)            
            $data['bet_start_time']= strtotime(trim(I('post.bet_start_time')));
		
			if(strtotime(trim(I('post.bet_end_time')))!=0)    
            $data['bet_end_time']= strtotime(trim(I('post.bet_end_time')));
		
			if(strtotime(trim(I('post.race_start_time')))!=0)    
            $data['race_start_time']= strtotime(trim(I('post.race_start_time')));
		
			if(strtotime(trim(I('post.race_end_time')))!=0)    
            $data['race_end_time']= strtotime(trim(I('post.race_end_time')));
            if(M('world_cup_bet')->where('id = %d', $id)->save($data)){
                $this->success('保存成功');
            }else{
                $this->error('保存失败');
            }
        }
		//更新奖池
		$prize = M('world_cup_log')->field('sum(bet_cost) as total_prize')->where(array('bet_race_id' => $id))->select();
		//奖池
		$total['total_bet'] = $prize[0]['total_prize'];
		//M('world_cup_bet')->where(array('id' => $id))->save($total);
		
        $this->assign('detail', $detail);
        $this->display('betAdd');
    }

    public function betDel(){
        $model = D('banner');
        $id = I('get.id/d');
        if(empty($id))exit;
        $result = $model -> where('id = %d', $id) -> delete();
        if ($result) {
            $this->success('删除成功');
        } else {
            $this->error('删除失败');
        }
    }

    //批量删除
    public function BatchDelBanner() {
        $model = D('banner');
        $ids = array_unique(array_filter(I('ids')));
        $result = $model -> where(array('id' => array('in',$ids))) -> delete();
        if ($result) {
            $this -> success('删除成功');
        } else {
            $this -> error('删除失败');
        }
    }
	//投注列表
	public function betOpen(){
		$page = IS_POST ? 1 : I('get.p'); 
        $model = M('world_cup_log');
        $count = $model-> count();
        $params['p']=I('get.p');
        $p = getpage($count, C('PAGE_SIZE'), $params);
        $show = $p -> show();
        $list = $model
        -> alias('world_cup_log')
        -> field('members.userid,members.nickname,members.phone,world_cup_log.bet_time,world_cup_log.bet_cost,world_cup_log.bet_status,world_cup_log.id,world_cup_log.bet_team,world_cup_log.bet_race_id,world_cup_log.prize_num')
		-> join('data_members as members ON world_cup_log.member_id = members.id','LEFT')
        ->  page($page)
        ->  order('world_cup_log.bet_time desc') -> limit(C('PAGE_SIZE')) -> select();
        $this -> assign('page', $show);
        $this -> assign('list', $list);
        $this -> display();
	}
	
	//开奖
	public function openPrize(){
		$model = M('world_cup_log');
		$id = I('id');
		$detail = M('world_cup_log')->where(array('id' => $id))->find();
		
		$members = M('members')->where(array('id' => $detail['member_id']))->find();
		
		if(IS_AJAX){
			//改变状态
			$log['bet_status']= I('bet_status');
			$res = M('world_cup_log')->where(array('id' => $id))->save($log);
			$status = M('world_cup_log')->where(array('id' => $id))->find();
			
			if($status['bet_status'] == 1 && $status['is_prize'] == 0){//赢了才加奖励
				$data['score']     = trim(I('post.bet_prize')) + $members['score'];
				
				$memberModel  = D("Members");
				$member = $memberModel->lock(true)->where(array('id' => $detail['member_id']))->find();
				$res = $memberModel -> score_inc($member, trim(I('post.bet_prize')));
				//添加竞猜奖励日志
				$new_member = $memberModel->where(array('id' => $detail['member_id']))->find();
				$logModel = M('user_score_log');
				//subtype 参与竞猜
				$userlog = array('uid' => $detail['member_id'], 'changeform' => 'in', 'subtype' => 11, 'num' => trim(I('post.bet_prize')), 'ctime' => NOW_TIME, 'balance' => $new_member['score'], 'extends' => "");
				$result = $logModel->add($userlog);
				
				if($res){
					//M('members')->where('id = %d', $detail['member_id'])->save($data)
					//改为已奖励状态
					$prize_status['is_prize']= 1;
					$prize_status['prize_num']= trim(I('post.bet_prize'));
					M('world_cup_log')->where(array('id' => $id))->save($prize_status);
					$this->success('保存成功');
				}else{
					$this->error('保存失败');
				}
			}else{
				$this->error('赢了才能加奖励或已经奖励过了');
			}
            
        }
		//计算奖励数额
		$prize = M('world_cup_log')->field('sum(bet_cost) as total_prize')->where(array('bet_race_id' => $detail['bet_race_id']))->select();
		//奖池
		$total = $prize[0]['total_prize'];
		//投中了总投注
		//赢的队
		$win_team = M('world_cup_bet')->where(array('id' => $detail['bet_race_id']))->find();
		$winteam = 3;//平
		if($win_team['win_team'] == 1){//左边队赢
			$winteam = $win_team['left_team'];
		}
		if($win_team['win_team'] == 2){//右边队赢
			$winteam = $win_team['right_team'];
		}
		//总共投对的数量
		$condi['_string'] = "bet_race_id='".$detail['bet_race_id']."' and bet_team like '%".$winteam."%'";
		$right_bet = M('world_cup_log')->field('sum(bet_cost) as total_prize')->where($condi)->select();
		
		//应该奖励数额 (投注的数量 / 总共投对的数量) * $total
		$win_prize = round((($detail['bet_cost'] / $right_bet[0]['total_prize']) * $total),2);
		
        $this->assign('total', $total."&nbsp;&nbsp;&nbsp;赢队：".$winteam."&nbsp;&nbsp;&nbsp;总共投对的数量".$right_bet[0]['total_prize']."&nbsp;&nbsp;&nbsp;");//总奖池
        $this->assign('prize', $win_prize);//赢得的奖励
		
        $this->assign('detail', $detail);
        $this->display('openPrize');
	}
	
	//按比赛场次开奖分奖励
	public function openWorldCupPrize(){
		
		$logModel = M('world_cup_log');
		$betModel = M('world_cup_bet');
		$memberModel  = D("Members");
		$scoreLogModel = M('user_score_log');

		$raceid = I('id');
		
		$race_info = $betModel->where(array("id"=>$raceid))->find();
		
		if($race_info['win_team'] == 3){
			$this->error('平局，不开奖');
		}
		
		if($race_info['win_team'] !=1 && $race_info['win_team'] != 2){
			$this->error('未出结果，不能开奖');
		}
		
		/* if($race_info['win_team'] != 0){
			$this->error('不能重复开奖');
		} */
		
		if($race_info['is_open'] == 1){
			$this->error('不能重复开奖');
		}
		
		$winteam=3; //平
		if($race_info['win_team'] == 1){//左边队赢
			$winteam = $race_info['left_team'];
		}
		if($race_info['win_team'] == 2){//右边队赢
			$winteam = $race_info['right_team'];
		} 
		
		//总共投对的数量
		$condi['_string'] = "bet_race_id='".$raceid."' and bet_team like '%".$winteam."%'";
		
		$right_prize = $logModel->field('sum(bet_cost) as total_prize')->where($condi)->select();
		
		//总共投注量、总奖池
		$total_prize = M('world_cup_log')->field('sum(bet_cost) as prize')->where(array('bet_race_id' => $raceid))->select();
		//赢者每个币应该分的奖励 = 总奖池 / 总共投对的数量
		$per_prize = round(($total_prize[0]['prize'] / $right_prize[0]['total_prize']),2);
		M()->startTrans();
		//给投对的人分配奖励
		$win_bet_list = $logModel->where($condi)->select();
		for($i=0;$i<count($win_bet_list);$i++){
			if($win_bet_list[$i]['is_prize'] == 0  && $win_bet_list[$i]['prize_num'] == 0 ){
				$member = $memberModel->lock(true)->where(array('id' => $win_bet_list[$i]['member_id']))->find();
				//奖励金额
				$prize_num = $per_prize * $win_bet_list[$i]['bet_cost'];
				//给账户提交奖励
				$res = $memberModel -> score_inc($member, $prize_num);
				
				//添加竞猜奖励用户日志 subtype 11 参与竞猜
				$new_member = $memberModel->where(array('id' => $win_bet_list[$i]['member_id']))->find();
				$newBalance=bcadd($new_member['score'],$new_member['score_lock'],8);
				$userlog = array('uid' => $win_bet_list[$i]['member_id'], 'changeform' => 'in', 'subtype' => 11, 'num' => $prize_num, 'ctime' => NOW_TIME, 'balance' => $newBalance, 'extends' => "");
				$result = $scoreLogModel->add($userlog);
				
				//修改投注记录为已奖励状态
				$prize_status['bet_status']= 1;
				$prize_status['is_prize']= 1;
				$prize_status['prize_num']= $prize_num;
				$logModel->where(array('id' => $win_bet_list[$i]['id']))->save($prize_status);
			}
		}
		//修改状态为已开奖
		$open_status['is_open']= 1;
		$betModel->where(array('id' => $raceid))->save($open_status);
		//修改没投中的状态为输了
		if(intval($raceid)>0){
			$lose_status['bet_status']= 0;
			$logModel->where(array('bet_race_id' => $raceid,'bet_status' => '2'))->save($lose_status);
		}
		
		M()->commit();
		$this->success('开奖成功');

	}
}