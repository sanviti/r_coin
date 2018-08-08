<?php
/**
 * 申请提现
 * 2018-03-16 
 * lxy
 */
namespace DataAdmin\Model;
use Think\Model;
class ApplycashModel extends Model {
	protected $tableName = 'applycash';

    /**
     * 获取总条数
     * @param  array  $condi [description]
     */
    public function getCount($condi = []){
        return $this->alias('a')->field('a.*, m.userid')
                    ->join('LEFT JOIN data_members m ON m.id = a.uid')
                    ->join('LEFT JOIN data_admin adm ON adm.id = a.admin')
                    ->where($condi)
                    ->count();
    }

	/**
     * 用户列表
	 * @param $where 搜索条件
	 * @param $page  当前页
     */
	public function getList($where, $page = 1, $limit = 0){
		$this->alias('a')
            ->field('a.*, m.userid, adm.username as admin, m.rname as mrname, m.phone')
            ->join('LEFT JOIN data_members m ON m.id = a.uid')
            ->join('LEFT JOIN data_admin adm ON adm.id = a.admin')
			-> where($where)
            -> order('a.id desc')
            -> page($page);
        if($limit > 0){
            $this-> limit($limit);
        }

		$list = $this -> select();
		return $list;
	}

}