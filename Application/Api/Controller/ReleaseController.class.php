<?php
/**
 * 计划任务释放矿机票
 */
namespace Api\Controller;
use Think\Controller;
use Think\Model;
use Common\Lib\Constants;

class ReleaseController extends Controller{
    /**
     * 每日释放矿机票  1%
     * 每日23:00点计划任务，2分钟一次，每次1000  运行10分钟
     * @return [type] [description]
     */

    public  function release(){
        //任务锁
        if(TradLockCheck('RELEASE_NAME')){
            echo '释放中..';
            exit;
        }


        //创建任务锁
        //TradLock('RELEASE_NAME', 'add', Constants::REDIS_PLANLOCK_TIME);
        $date = mktime(0,0,0,date('m'),date('d'),date('Y'));
        $membersModel=D('Members');
		
        $wallets = $membersModel->alias('m')->field('m.id ,m.mills,m.mills_lock,r.lock_total,r.mills_lock')
			->join('LEFT JOIN __RELEASE__ AS r ON r.member_id = m.id')
            ->where('r.mills_lock>0 AND  r.last_rel_date < '.$date)
            ->limit(0,1000)
            ->select();
        if($wallets){
            $this->p('start');
            foreach($wallets as $wallet){
                $this->cal_release($wallet);
            }
            $this->p('end');
        }else{
            echo 'completed';
        }
//        清除任务锁
        TradLock('RELEASE_NAME', 'del');
    }

    public  function  cal_release($data){
        $membersModel=D('Members');
		$logModel = M('userScoreLog');
        $meb = $membersModel->where(array('id'=>$data['id']))->find();
        if(empty($meb)){
            $this->p('用户未找到');
            return false;
        }else{
            $membersModel->where(array('id'=>$data['id']))->save(array('last_rel_date'=>time()));
            $radio=0.0001;
			//总量
            $total=$data['lock_total'];
            $relNum=round($total*$radio,2);
            if($relNum<0.01){
                return false;
            }
            if($relNum>$data['mills_lock']){
                $relNum=$data['mills_lock'];
            }
            if($data['mills_lock']-$relNum<0){
                return false;
            }
			
            M()->startTrans();
            $result=true;
			//减矿机票 mills
			$member = $membersModel->lock(true)->field('id,mills,ore,token,sign,score,score_lock,power')->where(array("id"=>$data['id']))->find();
			$result = $result && $membersModel->millsChange($member, $mills_num, $act = 'out');
			if($result == false){
				$err = '签名失败';
			}else{
				$err = '';
			}
			//用户日志 
			$newMills = new_bcadd($member['mills'], $mills_num);
			$log = array('uid' => $data['id'], 'changeform' => 'in', 'subtype' => 10, 'num' => $mills_num, 'ctime' => NOW_TIME, 'balance' => $newMills, 'extends' => time(),'money_type'=>2);

			$result = $result && $logModel->add($log);
			if($err == '' && $result == false){
				$err = '插入日志失败';
			}
			
            $result=$result && $walletModel->millsLockChange($data['id'],$relNum,'out');
            if($result){
                M()->commit();
                $date = mktime(0,0,0,date('m'),date('d'),date('Y'));
                $isHave=M('chain_total')->where(array('ctime'=>$date))->find();
                if($isHave){
                    M('chain_total')->where(array('ctime'=>$date))->setInc('total',$relNum);
                }else{
                    $chainData=array(
                        'ctime'=>$date,
                        'etime'=>$date,
                        'total'=>$relNum,
                        'status'=>1
                    );
                    M('chain_total')->add($chainData);
                }
            }else{
                M()->rollback();
            }
        }


    }


//    public function

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