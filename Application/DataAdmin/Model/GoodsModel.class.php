<?php
namespace DataAdmin\Model;
use Think\Model;
class GoodsModel extends Model {
	/**
     * 得到商品的总数
	 * @param $where 搜索条件
     */
    public function getGoodsCount($where){
		$count = M('data_goods',NULL)->alias('g')
					->where($where)->count();
		return $count;
	}
	/**
     * 得到商品的列表
	 * @param $where 搜索条件
	 * @param $page  当前页
     */
	public function getGoodsList($where,$page,$field,$order){
		$list = M('data_goods',NULL)->alias('g')->field($field)
					->where($where)
					-> page($page)
					-> order($order)
					-> limit(C('PAGE_SIZE'))
					-> select();
		return $list;
	}
	
}