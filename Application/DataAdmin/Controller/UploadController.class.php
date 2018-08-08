<?php
namespace DataAdmin\Controller;
use Think\Controller;
use Think;
class UploadController extends Controller {

    public function editor() {
        $upload = new \Think\Upload();// 实例化上传类
        $upload->maxSize   =     3145728 ;// 设置附件上传大小
        $upload->exts      =     array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型     
        $upload->savePath  = '/images/';
        $info=$upload->upload();
        echo json_encode( array( 
         'url'=>$info['upfile']['savepath'].'/'.$info['upfile']['savename'],                           
         'original'=>$info['upfile']['savepath'].'/'.$info['upfile']['savename'],       
         'state'=>'SUCCESS',       
        )); 
    }

    public function uploadImg() {
        $upload = new \Think\Upload();// 实例化上传类
        $key = array_shift(array_keys($_FILES));
        $upload->maxSize   =     2097152 ;// 设置附件上传大小
        $upload->exts      =     array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型     
        $upload->savePath = '/images/';
        $info=$upload->upload();
        if($upload->getError()){
            $this->error($upload->getError());
        }else{
            $this->success('上传成功','/Uploads'.$info[$key]['savepath'].$info[$key]['savename']); 
        }
    }
}
