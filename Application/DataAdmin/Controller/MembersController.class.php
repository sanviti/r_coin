<?php
/**
 * 用户管理
 * 2017-11-28
 * lxy
 */
namespace DataAdmin\Controller;
use Think\Controller;
Use Think\Cache\Driver\Redis;
use Common\Lib\RestSms;
use Common\Lib\Constants;

class MembersController extends BaseController{

    /**
     * 用户列表首页
     * @return [type] [description]
     */
    public function members(){

        $rname = I('rname', '', 'trim');
        $stype = I('stype', '', 'intval');
        if($rname){
            if($stype){
                $condi['nickname'] = array('like', '%'.$rname.'%');

            }else{
                $condi['nickname'] = $rname;
            }
            $params['nickname']   = $rname;
        }

        $phone = I('phone');
        if($phone){
            $params['phone'] = $phone;
            $condi['phone'] = $phone;
        }

        $uid = I('uid');
        if($uid){
            $params['userid'] = $uid;
            $condi['userid'] = $uid;
        }

        $is_lock = I('is_lock');
        if($is_lock !== ''){
            $params['is_lock'] = $is_lock;
            $condi['is_lock'] = $is_lock;
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
     * 用户信息
     * @return [type] [description]
     */
    public function profiles(){
        $id = I('id/d');
        $model = D('members');
        $auths = D('auths');
        $mill = D(get_mill_table($id));
        //验证卡片
        $member = $model->getMember($id, '*');
        if(!$member) $this->error('用户不存在');
        //c1
        if($member['auth_c1']){
            $c1 = $auths->where(array('uid' => $member['id'], 'type' => 1, 'status' => 1))->find();
            $this->assign('c1', $c1);
        }
        //c2
        if($member['auth_c2']){
            $c2 = $auths->where(array('uid' => $member['id'], 'type' => 2, 'status' => 1))->find();
            $this->assign('c2', $c2);
        }
        //矿机
        $mill_list = $mill->field('type, count(id) as num')->where(array('uid' => $member['id'], 'status' => 1))->group('type')->select();
        $this->assign('mill', $mill_list);
        $this->assign('member', $member);
        $this->display();
    }

    /**
     * 账户锁定
     */
    public function lock(){
        if(IS_AJAX){
            if($err = admin_require_check('id')) $this->error($err);
            $id = I('id/d');
            $condi = array('id' => $id);
            $model = D('members');
            $member = $model->field('is_lock')->where($condi)->find();
            if($member['is_lock'] == 1){
                $res = $model->where($condi)->save(array('is_lock' => 0));
            }else{
                $res = $model->where($condi)->save(array('is_lock' => 1));
            }

            if($res){
                $this->success('操作成功');
            }else{
                $this->error('操作失败');
            }
        }
    }


    /**
     * 修改备注
     * @return [type] [description]
     */
    public function editmemo(){
        $id = I('id/d');
        $memo = I('memo/s', '', 'trim');
        $model = D('members');
        //验证卡片
        $member = $model->getMember($id);
        if(!$member) $this->error('用户不存在');

        $condi = array('id' => $id);
        $result = $model->where($condi)->save(array('memo' => $memo));
        if($result){
            $this->_write_log($id);
            $this->success('操作成功');
        }else{
            $this->error('操作失败');
        }
    }

    /**
     * C2认证列表
     * @return [type] [description]
     */
    public function auths(){
        $rname = I('rname', '', 'trim');
        $stype = I('stype', '', 'intval');
        if($rname){
            if($stype){
                $condi['a.rname'] = array('like', '%'.$rname.'%');

            }else{
                $condi['a.rname'] = $rname;
            }
            $params['rname']   = $rname;
        }

        $idcard = I('idcard');
        if($idcard){
            $params['idcard'] = $idcard;
            $condi['a.idcard'] = $idcard;
        }

        $status = I('status');
        if($status !== ''){
            $params['status'] = $status;
            $condi['a.status'] = $status;
        }

        $condi['type'] = 2;
        $page = IS_POST ? 1 : I('get.p');
        $pagesize = 50;

        $model = M('auths');
        $count = $model->alias('a')->where($condi)->count();
        $pageObj = getpage($count, $pagesize, $params);
        $show = $pageObj -> newshow($params);

        $list = $model->alias('a')->field('a.*, adm.username')
            ->join('LEFT JOIN data_admin adm ON adm.id = a.admin')
            -> where($condi) -> page($page) -> limit($pagesize)->select();
        // dump($list);
        // exit;
        $this -> assign('page', $show);

        $this -> assign('list', $list);
        $this -> display();
    }

    /**
     * C2认证处理
     */
    public function auth_confirm(){
        if(IS_AJAX){
            if($err = admin_require_check('ids,action')) $this->error($err);
            $ids = I('ids/s');
            $ids = array_filter(explode(',', $ids));
            $action = I('action/s');

            $authsModel = M('auths');
            $memberModel = D('members');
            $messageModel = M('message');
            $logModel = M('userScoreLog');

            $list = $authsModel->where(array('id' => array('in', $ids), 'status' => 0))->select();
            $uids = '';
            foreach($list as $item){
                $uids .= $uids == '' ? $item['uid'] : ',' . $item['uid'];
            }

            //开始事物
            $authsModel -> startTrans();
            $result = true;
            if($action == 'pass'){
                //更改审核状态
                $authUpd = array('status' => 1,'admin' => $this->adminid(), 'ptime' => NOW_TIME);
                $result = $result && $authsModel->where(array('id' => array('in', $ids)))->save($authUpd);

                //更改用户状态
                $memberUpd = array('auth_c2' => 1);
                $result = $result && $memberModel->where(array('id' => array('in', $uids)))->save($memberUpd);

                //添加消息
                $messages = array();
                foreach($list as $item){
                    $temp = array(
                        'title' => '认证通过',
                        'describe' => '您的账号提交的C2认证资料，已经通过系统审核!',
                        'type' => '1',
                        'ctime' => NOW_TIME,
                        'uid' => $item['uid'],
                    );
                    array_push($messages, $temp);
                }
                $result = $result && $messageModel->addAll($messages);
                //推荐奖励 0.5RC
                // foreach($list as $item2){
                //     $leadid = $memberModel->where(array('id' => $item2['uid']))->getField('leadid');
                //     if($leadid > 0){
                //         $leader = $memberModel->lock(true)->where(array('id' => $leadid))->find();
                //         if($leader){
                //             //推荐加币
                //             $givenum = 0.5;
                //             $result = $result && $memberModel->score_inc($leader, $givenum);
                //             $newBalan1 = new_bcadd($leader['score'], $givenum);

                //             //推荐日志
                //             $log = array('uid' => $leadid, 'changeform' => 'in', 'subtype' => 8, 'num' => $givenum, 'ctime' => NOW_TIME, 'balance' => $newBalan1, 'extends' => $item2['uid']);
                //             $result = $result && $logModel->add($log);
                //         }
                //     }
                // }


            }else{
                //更改审核状态
                $remark = I("remark");
                $authUpd = array('status' => -1,'admin' => $this->adminid(), 'ptime' => NOW_TIME,"remark" => $remark);
                $result = $result && $authsModel->where(array('id' => array('in', $ids)))->save($authUpd);
                //添加消息
                $messages = array();
                foreach($list as $item){
                    $temp = array(
                        'title' => '认证失败',
                        'describe' => '您的账号提交的C2认证资料，未通过系统审核，请重新提交资料!',
                        'type' => '1',
                        'ctime' => NOW_TIME,
                        'uid' => $item['uid'],
                    );
                    array_push($messages, $temp);
                }
                $result = $result && $messageModel->addAll($messages);
            }

            if($result){
                $authsModel->commit();
                $this->success('操作成功');
            }else{
                $authsModel->rollback();
                $this->error('操作失败');
            }

        }
    }

    /**
     * C1认证列表
     * @return [type] [description]
     */
    public function auths_c1(){
        $rname = I('rname', '', 'trim');
        $stype = I('stype', '', 'intval');
        if($rname){
            if($stype){
                $condi['a.rname'] = array('like', '%'.$rname.'%');

            }else{
                $condi['a.rname'] = $rname;
            }
            $params['rname']   = $rname;
        }

        $idcard = I('idcard');
        if($idcard){
            $params['idcard'] = $idcard;
            $condi['a.idcard'] = $idcard;
        }

        $status = I('status');
        if($status !== ''){
            $params['status'] = $status;
            $condi['a.status'] = $status;
        }

        $condi['type'] = 1;
        $page = IS_POST ? 1 : I('get.p');
        $pagesize = 50;

        $model = M('auths');
        $count = $model->alias('a')->where($condi)->count();
        $pageObj = getpage($count, $pagesize, $params);
        $show = $pageObj -> newshow($params);

        $list = $model->alias('a')->field('a.*, adm.username')
            ->join('LEFT JOIN data_admin adm ON adm.id = a.admin')
            -> where($condi) -> page($page) -> limit($pagesize)->select();
        $this -> assign('page', $show);

        $this -> assign('list', $list);
        $this -> display();
    }

    /**
     * C1认证处理
     */
    public function auth_confirm_c1(){
        set_time_limit(0);
        if(IS_AJAX){
            if($err = admin_require_check('ids,action')) $this->error($err);
            $ids = I('ids/s');
            $ids = array_filter(explode(',', $ids));
            $action = I('action/s');

            $authsModel = M('auths');
            $memberModel = D('Api/Members');
            $messageModel = M('message');

            $list = $authsModel->where(array('id' => array('in', $ids), 'status' => 0))->select();
            $uids = '';
            foreach($list as $item){
                $uids .= $uids == '' ? $item['uid'] : ',' . $item['uid'];
            }

            //开始事物
            $authsModel -> startTrans();
            $result = true;
            if($action == 'pass'){
                //更改审核状态
                $authUpd = array('status' => 1,'admin' => $this->adminid(), 'ptime' => NOW_TIME);
                $result = $result && $authsModel->where(array('id' => array('in', $ids)))->save($authUpd);
                //更改用户状态
                $memberUpd = array('auth_c1' => 1);
                $result = $result && $memberModel->where(array('id' => array('in', $uids)))->save($memberUpd);

                $messages = array();
                foreach($list as $item){
                    $millModel = M(get_mill_table($item['uid']));
                    //是否有注册赠送的矿机
                    $map = array('get_way' => 'reg', 'uid' => $item['uid']);
                    $count = $millModel->where($map)->count('id');

                    if($count < 1){
                        $member = $memberModel->lock(true)->where(array('id' => $item['uid']))->find();
                        //赠送矿机
                        $mill = array(
                            'uid' => $item['uid'],
                            'type' => '1',
                            'last_time' => NOW_TIME,
                            'create_time' => NOW_TIME,
                            'status' => 1,
                            'mill_value' => mill_max_output(1),
                            'mill_sn' => gen_mill_sn($item['uid'], 1),
                            'get_way' => 'reg'
                        );
                        $result = $millModel->add($mill);
                        //团队算力
                        $power = mill_power(1);
                        $result = $result && $memberModel->upd_team_power($member['path'], $power, 'inc');
                        //个人算力
                        $result = $result && $memberModel->upd_power($item['uid'], $power, 'inc');

                        $temp = array(
                            'title' => '认证通过',
                            'describe' => '您的账号提交的C1认证资料，已经通过系统审核!',
                            'type' => '1',
                            'ctime' => NOW_TIME,
                            'uid' => $item['uid'],
                        );
                        array_push($messages, $temp);
                        $temp2 = array(
                            'title' => '光电机组开通成功',
                            'describe' => '恭喜您获得一台'.mill_name(1).'!，来自系统赠送',
                            'type' => '1',
                            'ctime' => NOW_TIME,
                            'uid' => $item['uid'],
                        );
                        array_push($messages, $temp2);
                    }else{
                        continue;
                    }

                }
                $result = $result && $messageModel->addAll($messages);
            }else{
                //更改审核状态
                $authUpd = array('status' => -1,'admin' => $this->adminid(), 'ptime' => NOW_TIME);
                $result = $result && $authsModel->where(array('id' => array('in', $ids)))->save($authUpd);
                //添加消息
                $messages = array();
                foreach($list as $item){
                    $temp = array(
                        'title' => '认证失败',
                        'describe' => '您的账号提交的C1认证资料，未通过系统审核，请重新提交资料!',
                        'type' => '1',
                        'ctime' => NOW_TIME,
                        'uid' => $item['uid'],
                    );
                    array_push($messages, $temp);
                }
                $result = $result && $messageModel->addAll($messages);
            }

            if($result){
                $authsModel->commit();
                $this->success('操作成功');
            }else{
                $authsModel->rollback();
                $this->error('操作失败');
            }

        }
    }

    //修改认证状态
    public function auths_modify(){
        if($err = admin_require_check('type,id')) $this->error($err);
        $type   = I('type');
        $id     = I('id');
        $status = intval(I('status'));

        if($type == 2){
            $data['auth_c2'] = $status;
        }else{
            $data['auth_c1'] = $status;
        }
        // dump($data);
        $result = M('members')->where(array('id' => $id))->save($data);
        // echo M()->getlastsql();
        if($result){
            $this->success('操作成功');
        }else{
            $this->error('操作失败');
        }
    }
} 