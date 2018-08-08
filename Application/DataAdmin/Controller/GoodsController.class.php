<?php
namespace DataAdmin\Controller;

use Think\Controller;

class GoodsController extends BaseController
{

    public function index()
    {
        $params['tag'] = $tag;
        $name = I('name', '', 'trim');
        $page = I('get.p');
        $state = I('get.state');
        $cid=I("cid");
        $is_pinpai = I('is_pinpai');
        $is_haowu = I('is_haowu');

        $paixu = I('paixu');
        if($paixu!=""){
            if($paixu=="up"){
               $order = "click_num ASC,id DESC";
            }elseif($paixu=="down"){
               $order = "click_num DESC,id DESC";
            }elseif($paixu=="csortdown"){
               $order = "csort DESC,id DESC";
            }elseif($paixu=="csortup"){
               $order = "csort ASC,id DESC";
            }elseif ($paixu=="id"){
               $order = "id DESC";
            }
        }else{
            $order = "goods_id DESC";
        }
        if (! empty($name)) {
            $condi['g.name'] = array(
                'like',
                '%' . $name . '%'
            );
            $params['name'] = $name;
        }
        if ($state != '') {
            $condi['g.status'] = $state;
            $params['state'] = $state;
        }
        if ($is_pinpai != '') {
            $condi['g.is_pinpai'] = $is_pinpai;
            $params['is_pinpai'] = $is_pinpai;
        }
        
        if ($is_haowu != '') {
            $condi['g.is_haowu'] = $is_haowu;
            $params['is_haowu'] = $is_haowu;
        }
        if ($cid) {
            $condi['g.goods_type'] = $cid;
            $params['category_id'] =$cid;
        }
        if (empty($page))
            $page = 1;
        $count = D('Goods')->getGoodsCount($condi);
        $p = getpage($count, C('PAGE_SIZE'), $params);
        $show = $p->newshow();
        $field = 'g.*';
        $list = D('Goods')->getGoodsList($condi, $page, $field,$order);
        $this->assign('catInfo',C('goodsCate'));
        $this->assign('page', $show);
        $this->assign('list', $list);
        $this->assign('p',$page);
        $this->display();
    }
    // 添加
    public function add()
    {
        $cate_id = (int)I('post.category');
        $goodsCate = C('goodsCate');
        if (!isset($goodsCate[$cate_id])) {
            $this->assign('list',$goodsCate);
            $this->display('addFirst');
            exit;
        }
        $this->assign('cate_id',$cate_id);
        $this->assign('cate',$goodsCate[$cate_id]);
        switch ($cate_id) {
            case 1:
                $template = 'phone_recharge';
                break;
            case 2:
                $template = 'shiyou';
                break;
            case 3:
                $template = 'gold';
                break;
            default:
                $template = 'add';
                break;
        }
        $this->display($template);
    }
    // 修改
    public function edit1()
    {
        $id = I('get.id');
        // 得到分类列表
        $clist = D('Category')->getList('');
        // 得到信息
        $goodsData = M('goods')->field('g.*,shopid')
            ->alias('g')
            ->join('inner join data_shop as s on s.id = g.shop_id')
            ->where("g.id=" . $id)
            ->find();

        $goodsData['goods_pics'] = unserialize($goodsData['pic']);
        $goodsData['arguments'] = unserialize($goodsData['arguments']);

        if($goodsData['extended_attributes'] == 1){
            $goodsData['attribute'] = unserialize($goodsData['attribute']);

            $stock = M('goods_attr',null)->field('flag,price,stock,img')->where('goods_id = %s',$id)->select();
            if($stock) $this->assign('stock',$stock);
        }

        $this->assign('clist', $clist);
        $this->assign('list', $goodsData);
        $this->display();
    }

    public function edit(){
        $goods_id = I('goods_id/d', '', 'intval');
        if(!$goods_id) $this->error('请选择要修改的商品');

        $goods = M('goods')->where('goods_id = %d', $goods_id)->find();
        if(!$goods) $this->error('商品不存在或已被管理员删');
        $cate_id = $goods['goods_type'];
        $goodsCate = C('goodsCate');
        if (!isset($goodsCate[$cate_id])) {
            $this->error('商品分类不存在，该商品将自动下架');
        }
        $this->assign('cate_id',$cate_id);
        $this->assign('cate',$goodsCate[$cate_id]);
        switch ($cate_id) {
            case 1:
                $template = 'phone_recharge';
                break;
            case 2:
                $template = 'shiyou';
                break;
            case 3:
                $template = 'gold';
                break;
            default:
                $template = 'add';
                break;
        }
        $this->assign('goods', $goods);
        $this->assign('goods_pics', explode('||', $goods['goods_pics']));
        $this->display($template);
    }
    public function act_do()
    {
        $goods_id = I('goods_id');
        $data['goods_name'] = I('name');
        $img = I('img');
        $data['price'] = I('price');
        $data['market_price'] = I('market_price');
        $userimg = I('userimg');
        $data['status'] = $_POST['status'];
        $data['intro'] = I('intro');
        $data['goods_detail'] = $_POST['content'];
        $data['goods_stock'] = I('stock');
        if (empty($data['status']))
            $data['status'] = 0;
        if (empty($data['price'])) {
            $this->error('销售价格不能为空');
        }
        if ($data['goods_stock'] == '') {
            $this->error('库存不能为空');
        } elseif (! is_numeric($data['goods_stock'])) {
            $this->error('库存应该是数字');
        }
        // 处理图片
        $picData = explode('||', $userimg);
        $data['goods_img'] = $picData[0];
        $data['goods_pics'] = $userimg;
        $data['dec_stock_type'] = 1;

        $cate_id = (int)I('post.cate_id');
        switch ($cate_id) {
            case 1:
                if (empty($data['market_price'])) {
                    $this->error('话费面额不能为空');
                }
                $data['goods_img'] = $img;
                $data['dec_stock_type'] = 3;
                break;
            case 2:
                if (empty($img)) {
                    $this->error('请上传缩略图');
                }
                $data['goods_img'] = $img;
                break;
            case 3:
                if (empty($img)) {
                    $this->error('请上传缩略图');
                }
                $data['goods_img'] = $img;
                break;
            default:
                if (empty($data['goods_img'])) {
                    $this->error('图片至少上传一张');
                }
                break;
        }

        
        if (empty($goods_id)) {
            $goodsCate = C('goodsCate');
            if (!isset($goodsCate[$cate_id])) {
                $this->error('请选择商品分类');
            }
            $data['last_update'] = time();
            $data['dateline'] = time();
            $data['goods_type'] = $cate_id;
            $result = M('goods')->add($data);
            if ($result) {
                $this->success('添加成功',U('Goods/index'));
            } else {
                $this->error('添加失败');
            }
        } else {
            $result = M('goods')->where("goods_id=" . $goods_id)->save($data);
            if ($result !== false) {
                $this->success('修改成功',U('Goods/index'));
            } else {
                $this->error('修改失败');
            }
        }
    }
    // 添加图片
    private function addPic($picData, $id)
    {
        foreach ($picData as $pic) {
            $data['pic_url'] = $pic;
            $data['goods_id'] = $id;
            M('goods_pic')->add($data);
        }
    }
    // 删除图片
    private function delPic($id)
    {
        M('goods_pic')->where("goods_id=" . $id)->delete();
    }
    // 展示设置规格
    public function setattribute()
    {
        $id = I('get.id');
        $list = M('goods')->alias('attribute')
            ->where("id=" . $id)
            ->find();
        $stock = M('goods_attr')->field('flag,price,stock,img')
            ->where(' goods_id = %s', $id)
            ->select();
        if ($stock)
            $this->assign('stock', $stock);
        $this->assign('id', $id);
        $this->assign('stock', $stock);
        $this->assign('attribute', unserialize($list['attribute']));
        $this->display();
    }
    // 设置规格操作
    public function setattribute_do()
    {
        $id = I('post.id');
        $attribute = I('post.attribute');
        $stock_info = I('stock');
        if (! empty($attribute)) {
            $data['attribute'] = serialize($attribute);
            $goods_stock = $this->getStockSum($stock_info);
            $data['stock'] = $goods_stock;
            M('goods')->where("id=" . $id)->save($data);
        }

        if (is_array($stock_info)) {
            // 先删除所有规格
            M('goods_attr')->where("goods_id=" . $id)->delete();
            foreach ($stock_info as $k => $item) {
                $stock_info[$k]['goods_id'] = $id;
            }
            M('goods_attr')->addAll($stock_info);
        }
        $this->success('设置成功', U('Goods/index'));
    }

    /**
     * 计算商品库存
     */
    private function getStockSum($stock)
    {
        $sum = 0;
        foreach ($stock as $s) {
            $sum += $s['stock'];
        }
        return $sum;
    }

    /**
     * 计算商品库存
     */
    private function _getStockSum($stock){
        $sum = 0;
        foreach($stock as $s){
            $sum += $s['stock'];
        }
        return $sum;
    }

    public function delGoods()
    {
        $id = I('post.id');
        $result = true;
        M()->startTrans();
        $result = $result && M('goods')->where("goods_id=" . $id)->delete();
        //$result2 = M('goods_pic')->where("goods_id=" . $id)->delete();
        //$result3 = M('goods_attr')->where("goods_id=" . $id)->delete();
        if ($result && $result2 !== false && $result3 !== false) {
            M()->commit();
            $data['code'] = 'S';
        } else {
            $data['code'] = 'E';
            M()->rollback();
        }
        echo json_encode($data);
    }
    // 批量设置状态
    public function setGoodsStatus()
    {
        $type = I('post.type');
        $idStr = implode(',', array_filter($_POST['idStr']));
        M('goods')->where("goods_id IN(%s)", $idStr)->save(array(
                'status' => $type,
                'last_update' => time()
            ));
        $data['code'] = 'S';
        echo json_encode($data);
    }

    //修改状态
    public function status()
    {
        extract(require_check("id"));
        $status = I('status');
        if (!$id) {
            err('请选择操作数据');
        }
        $data = array(
            'status' => $status
        );
        $result = M('goods')->where(array(
            'id' => $id
        ))->save($data);

        succ($result);
    }

    //拒绝商品上架
    public function  set_refuse(){
        $id = I('id');
        $cause = I('cause');
        $status = 4;
        $info = M("goods",NULL)->where(array('id'=>$id))->find();
        if($info){
            if($info['status']==1){
                err("该商品已发布!");
            }else{
                if(M("goods",NULL)->where("id=".$id)->save(array("cause"=>$cause,'status'=>$status))){
                    succ("设置成功!");
                }else{
                    err("设置失败!");
                }
            }
        }else{
            err("设置失败!");
        }
    }

    //设置商品参考价
    public function set_lookprice(){
        $goodsid = I("goodsid");
        $look_price = I("look");
        $info = M("goods",NULL)->where(array('id'=>$goodsid))->find();
        if($info){
            if(M("goods",NULL)->where(array('id'=>$goodsid))->save(array("look_price"=>$look_price))){
                succ("设置成功!");
            }else{
                err("设置失败!");
            }
        }else{
            err("设置失败!");
        }
    }

    //设置分类列表商品排序
    public function set_csort(){
        $goodsid = I("goodsid");
        $num = I("num");
        if($num<0){
            err("设置参数不正确，请填写大于0的");
        }
        $info = M("goods",NULL)->where(array('id'=>$goodsid))->find();
        if($info){
            if(M("goods",NULL)->where(array('id'=>$goodsid))->save(array("csort"=>$num))){
                succ("设置成功!");
            }else{
                err("设置失败!");
            }
        }else{
            err("设置失败!");
        }
    }

    /**
     * App闪屏列表
     */
    public function screen_list(){
        $page = I('get.p');
        $condi['type'] = 5;
        $count = M('goods_recommend', NULL)->where($condi)->count();
        $p = getpage($count, C('PAGE_SIZE'),$condi);
        $show = $p->newshow();
        $list = M('goods_recommend', NULL)->where($condi)->page($page)->limit(C('PAGE_SIZE'))->select();
        $now = time();
        foreach ($list as $k=>$v){
            if($v['etime']<$now){
                $list[$k]['status'] = 1;
            }else{
                $list[$k]['status'] = 0;
            }
        }
        $this->assign("list",$list);
        $this->assign('page', $show);
        $this->assign('p',$page);
        $this->display();
    }

    /**
     * 添加APP闪屏
     */
    public function add_screen(){
        $id = I("id");
        $info = M('goods_recommend', NULL)->where(array("id"=>$id))->find();
        $this->assign("id",$id);
        $this->assign("info",$info);
        $this->display();
    }

    public function addscreen_to(){
        if (IS_POST) {
            $id = I("id");
            $title = I('title');
            $link = I('link');
            $linktype = I('link_type');
            $etime = I('etime');
            $pic = I('pic');
            $arr = array(
                'title'=>$title,
                'link' => $link,
                'link_type' => $linktype,
                'etime'=>strtotime($etime),
                'pic'=>$pic,
                'type'=>5
            );
            if($id!=""){
                $rtn = M('goods_recommend', NULL)->where(array("id"=>$id))->save($arr);
            }else{
                $rtn = M('goods_recommend', NULL)->add($arr);
            }
            if ($rtn) {
                $this->success("设置成功!",U('screen_list'));
            } else {
                $this->error("设置失败!",U('screen_list'));
            }
        }
    }

    /**
     * 删除闪屏
     */
    public function del_screen(){
        $id = I("id");
        $info = M('goods_recommend', NULL)->where(array("id"=>$id))->find();
        if($info){
            $rtn = M('goods_recommend', NULL)->where(array("id"=>$id))->delete();
            if ($rtn) {
                $this->success("删除成功!",U('screen_list'));
            } else {
                $this->error("删除失败!",U('screen_list'));
            }
        }
    }
    
    /**
     * 品牌列表
     */
    public function big_brand(){
        $p = I("p");
        $count = M("data_brand",null)->where(array("type"=>0))->count();
        $p = getpage($count, C('PAGE_SIZE'));
        $show = $p->newshow();
        $list = M("data_brand",null)->where(array("type"=>0))->page($p)->limit(C('PAGE_SIZE'))->select();
        $this->assign("page",$show);
        $this->assign("list",$list);
        $this->assign("p",$p);
        $this->display();
    }
    
    /**
     * 添加品牌
     */
    public function addBrand(){
        $id = I("id");
        $this->assign("id",$id);
        $info = M("data_brand",null)->where(array("id"=>$id,"type"=>0))->find();
        $this->assign("info",$info);
        $this->display();
    }
    
    /**
     * 执行添加品牌名称
     */
    public function to_addbrand(){
        $id = I("id");
        $name = I('name','','trim');
        $info = M("data_brand",null)->where(array("id"=>$id,"type"=>0))->find();
        if(empty($info)){
            $rtn = M("data_brand",null)->add(array("name"=>$name,"type"=>0));
            if($rtn){
                $this->success("添加成功");
            }else{
                $this->error("添加失败");
            }
        }else{
            $rtn = M("data_brand",null)->where(array("id"=>$id))->save(array("name"=>$name));
            if($rtn){
                $this->success("修改成功");
            }else{
                $this->error("修改失败");
            }
        }
    }

    /**
     * 发现好物
     * @Author   xiaoqiang
     * @DateTime 2017年12月25日
     */
    public function FoundGoods(){
        $p = I("p");
        $count = M("data_brand",null)->where(array('type'=>1))->count();
        $p = getpage($count, C('PAGE_SIZE'));
        $show = $p->newshow();
        $list = M("data_brand",null)->where(array('type'=>1))->page($p)->limit(C('PAGE_SIZE'))->select();
        $this->assign("page",$show);
        $this->assign("list",$list);
        $this->assign("p",$p);
        $this->display();
    }
    
    //添加好物
    public function addFound(){
        $id = I("id");
        $this->assign("id",$id);
        $info = M("data_brand",null)->where(array("id"=>$id,'type'=>1))->find();
        $this->assign("info",$info);
        $this->display();
    }
    
    //好物提交
    public function to_addFound(){
        $id = I("id");
        $name = I('name','','trim');
        $info = M("data_brand",null)->where(array("id"=>$id,'type'=>1))->find();
        if(empty($info)){
            $rtn = M("data_brand",null)->add(array("name"=>$name,'type'=>1));
            if($rtn){
                $this->success("添加成功");
            }else{
                $this->error("添加失败");
            }
        }else{
            $rtn = M("data_brand",null)->where(array("id"=>$id,'type'=>1))->save(array("name"=>$name));
            if($rtn){
                $this->success("修改成功");
            }else{
                $this->error("修改失败");
            }
        }
    }
    
    //搜索栏关键字列表
    public function search_list(){
        $page = I("p");
        $count = M("data_defsearch",null)->count();
        $list = M("data_defsearch",null)->page($page)->limit(10)->select();
        $p = getpage($count, C('PAGE_SIZE'));
        $show = $p->newshow();
        $this->assign("list",$list);
        $this->assign("page",$show);
        $this->display();
    }
    public function edit_search(){
        $id = I("id");
        $info = M("data_defsearch",null)->where(array("id"=>$id))->find();
        $this->assign("info",$info);
        $this->display();
    }
    public function search_to(){
        $id = I("id");
        $name = I("name");
        $type = I("type");
        if(IS_POST){
            $array = array(
                'name'=>$name,
                'type'=>$type,
                'ctime'=>time()
            );
            if(empty($id)){
                $rtn = M("data_defsearch",null)->add($array);
            }else{
                $rtn = M("data_defsearch",null)->where(array("id"=>$id))->save($array);
            }
            if ($rtn) {
                $this->success("设置成功!",U('search_list'));
            } else {
                $this->error("设置失败!",U('edit_search'));
            }
        }
    }
    
    public function delsearch(){
        $id = I("id");
        $info = M("data_defsearch",null)->where(array("id"=>$id))->find();
        if($info){
            $rtn = M("data_defsearch",null)->where(array("id"=>$id))->delete();
            if($rtn){
                succ("删除成功");
            }else{
                err("删除失败");
            }
        }
    }
}
