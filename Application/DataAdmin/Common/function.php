<?php
/**
 * 获取客户端IP地址
 * @return [type] [description]
 */
function get_clientIP()
{
    if (getenv("HTTP_CLIENT_IP")){
        $ip = getenv("HTTP_CLIENT_IP");
    }
    else if(getenv("HTTP_X_FORWARDED_FOR")){
        $ip = getenv("HTTP_X_FORWARDED_FOR");
    }
    else if(getenv("REMOTE_ADDR")){
        $ip = getenv("REMOTE_ADDR");
    }else{
        $ip = "Unknow";
    }
    return $ip;
}
/**
 * 二位数组去重
 * @param  [type] $arr     
 * @param  [type] $newKey  0 原始键名 1新键名
 * @return [type] array    
 */
function array_unique_re($arr, $newKey = 0){
    $temp = array();
    $key  = 0;
    foreach ($arr as $oldkey => $value) {
        if(!in_array($value, $temp)){
            if($newKey){
                $key = $key == 0 ? 0 : $key++;
            }else{
                $key = $oldkey;
            }
            $temp[$key] = $value;
        }
    }
    return $temp;
}

?>