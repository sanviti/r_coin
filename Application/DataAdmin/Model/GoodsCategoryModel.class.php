<?php
namespace DataAdmin\Model;
use Think\Model;
header('content-type:text/html;charset=utf-8');
class GoodsCategoryModel extends Model {
    protected $tableName = 'category';
    protected $tablePrefix = 'data_';

    public function catInfo(){
        $data=$this->select();
        $data=$this->tree($data);
        return $data;
    }

    public $arr=array();
    public  function  tree($data,$pid=0,$level=1){
        foreach($data as $v){
            if($pid==$v['parent_id']){
                $v['level']=$level;
                $this->arr[]=$v;
                $this->tree($data,$v['cat_id'],$level+1);
            }
        }
        return $this->arr;
    }
}