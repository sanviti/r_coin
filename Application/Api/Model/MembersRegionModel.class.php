<?php
/**
 * 手机端用户注册分布模型
 */
namespace Api\Model;
use Think\Model;
use Common\Lib\Constants;
class MembersRegionModel extends Model{
    protected $tableName = 'members_region';


    //左区算例总额
    public  function  areaA($uid){

        $lid=$this->where(array('uid'=>$uid))->field('lid')->find();
        $result= M('members')->where(array('id'=>$lid['lid']))->field('team_power')->find();
        return $result['team_power'];

    }

    //右区算例总额
    public  function  areaB($uid){
        $lid=$this->where(array('uid'=>$uid))->field('rid')->find();
        $result= M('members')->where(array('id'=>$lid['rid']))->field('team_power')->find();
        return $result['team_power'];
    }


    //左区人数总和
    public  function  areaAnum($uid){

        $lid=$this->where(array('uid'=>$uid))->field('lid')->find();
        $result= M('members')->where(array('id'=>$lid['lid']))->field('team_people_num')->find();
        return $result['team_people_num'];
    }



    //右区算例总额
    public  function  areaBnum($uid){
        $lid=$this->where(array('uid'=>$uid))->field('rid')->find();
        $result= M('members')->where(array('id'=>$lid['rid']))->field('team_people_num')->find();
        return $result['team_people_num'];
    }



}