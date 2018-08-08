<?php
namespace Api\Controller;
Use Think\Controller;
class UploadController extends Controller{

    public function uploadImg() {
        $upload = new \Think\Upload();// 实例化上传类
        $key = array_shift(array_keys($_FILES));
        $upload->maxSize   =     12582912 ;// 设置附件上传大小
        $upload->exts      =     array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型     
        $upload->savePath = '/authc2/';
        $info=$upload->upload();
        if($upload->getError()){
            $this->error($upload->getError());
        }else{
            $this->success('上传成功','/Uploads'.$info[$key]['savepath'].$info[$key]['savename']); 
        }
    }
    public function uploadHead() {
        $upload = new \Think\Upload();// 实例化上传类
        $key = array_shift(array_keys($_FILES));
        $upload->maxSize   =     12582912 ;// 设置附件上传大小
        $upload->exts      =     array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型     
        $upload->savePath = '/headimg/';
        $info=$upload->upload();
        if($upload->getError()){
            $this->error($upload->getError());
        }else{
            $this->success('上传成功','/Uploads'.$info[$key]['savepath'].$info[$key]['savename']); 
        }
    }
    public function groupLogo() {
        $upload = new \Think\Upload();// 实例化上传类
        $key = array_shift(array_keys($_FILES));
        $upload->maxSize   =     12582912 ;// 设置附件上传大小
        $upload->exts      =     array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型     
        $upload->savePath = '/group/';
        $info=$upload->upload();
        if($upload->getError()){
            $this->error($upload->getError());
        }else{
            $this->success('上传成功','/Uploads'.$info[$key]['savepath'].$info[$key]['savename']); 
        }
    }
    public function uploadScreen() {
        $upload = new \Think\Upload();// 实例化上传类
        $key = array_shift(array_keys($_FILES));
        $upload->maxSize   =     12582912 ;// 设置附件上传大小
        $upload->exts      =     array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型     
        $upload->savePath = '/Problem/';
        $info=$upload->upload();
        if($upload->getError()){
            $this->error($upload->getError());
        }else{
            $this->success('上传成功','/Uploads'.$info[$key]['savepath'].$info[$key]['savename']); 
        }
    }
}

