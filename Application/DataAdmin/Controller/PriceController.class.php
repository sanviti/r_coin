<?php 
namespace DataAdmin\Controller;
use Think\Controller;
class PriceController extends BaseController{
	
 //价格列表
    public function priceList() {
        $KeySetPriceModel = M("price");
        $count = $KeySetPriceModel->count(); 
        $list = $KeySetPriceModel->field('id,price,date as ctime,high,low')->page(I('get.p'))->order('ctime desc')->limit(10)->select();

		$zero_time = strtotime(date("Y-m-d"));
		for($i=0;$i<count($list);$i++){
			$list[$i]['price'] =round($list[$i]['price'],2);
			$list[$i]['editable'] =0;
			if($list[$i]['ctime']>$zero_time){
				$list[$i]['editable'] = 1;
			}
		}

        $p = getpage($count, C('PAGE_SIZE'));;
        $show = $p->show();
        $this->assign('list', $list);
        $this->assign('page', $show);
        $this->display();
    }
    //保存价格
    public function savePrice(){
		$today_price = trim(I('today_price'));
		$today_price_high = trim(I('today_price_high'));
		$today_price_low = trim(I('today_price_low'));
		
		$coinData = array();
        if ($today_price!="") {
			if (!preg_match('/^[0-9]+(.[0-9]{1,2})?$/', $today_price)) {
				$this->error('价格最多为2位小数1');
			}
			$coinData['price'] = $today_price;
        }
		if ($today_price_high!="") {
			if (!preg_match('/^[0-9]+(.[0-9]{1,2})?$/', $today_price_high)) {
				$this->error('价格最多为2位小数2');
			}
			$coinData['high'] = $today_price_high;
        }
		if ($today_price_low!="") {
			if (!preg_match('/^[0-9]+(.[0-9]{1,2})?$/', $today_price_low)) {
				$this->error('价格最多为2位小数3');
			}
			$coinData['low'] = $today_price_low;
        }
		
		$start_time = strtotime(date("Y-m-d"));
		$coinData['date'] = $start_time;
		
		$end_time = strtotime(date("Y-m-d"))+3600*24;
		$condi['_string'] = "date < $end_time";
		
		$today_data =  M('price')->field('id,price,date')->where($condi)->order('id desc')->find();
		if($today_data['date'] < $start_time){
			$res = M('price')->add($coinData);  
			$this->success('设置成功！');
		}else{
				$res = M('price')->where(array('id' => $today_data['id']))->save($coinData);
				$this->success('修改成功！');
		}
        $this->redirect('Price/priceList');
    }

	    //保存价格
    public function save_next_price(){
		$tom_price = trim(I('tom_price'));
		$tom_price_high = trim(I('tom_price_high'));
		$tom_price_low = trim(I('tom_price_low'));

		$coinData = array();
        if ($tom_price!="") {
			if (!preg_match('/^[0-9]+(.[0-9]{1,2})?$/', $tom_price)) {
				$this->error('价格最多为2位小数1');
			}
			$coinData['price'] = $tom_price;
        }
		
		if ($tom_price_high!="") {
			if (!preg_match('/^[0-9]+(.[0-9]{1,2})?$/', $tom_price_high)) {
				$this->error('价格最多为2位小数1');
			}
			$coinData['high'] = $tom_price_high;
        }
		
		if ($tom_price_low!="") {
			if (!preg_match('/^[0-9]+(.[0-9]{1,2})?$/', $tom_price_low)) {
				$this->error('价格最多为2位小数1');
			}
			$coinData['low'] = $tom_price_low;
        }
		
		$next_start_time = strtotime(date("Y-m-d"))+3600*24;
		$next_end_time = strtotime(date("Y-m-d"))+3600*24*2;
		
		$coinData['date'] = $next_start_time;
        
		
		$condi['_string'] = "date = $next_start_time";
		
		$tom_data =  M('price')->field('id,price,date')->where($condi)->order('id desc')->find();
		
		if(!$tom_data){
			$res = M('price')->add($coinData);  
			$this->success('设置成功！');
		}else{
			$res = M('price')->where(array('id' => $tom_data['id']))->save($coinData);
			$this->success('修改成功！');
		}
			
        $this->redirect('Price/priceList');
    }
	
}
?>