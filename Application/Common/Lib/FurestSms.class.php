<?php

namespace Common\Lib;

class FurestSms{

    //主帐号,对应开官网发者主账号下的 ACCOUNT SID

    private $_private_key = 'MIICeQIBADANBgkqhkiG9w0BAQEFAASCAmMwggJfAgEAAoGBANtwbqLc71VAhcOPwHScsHbN5gEVvgKUjmwVT+sXw1d4gNop0ZBnuzcDUfH7hoL0wGEA8V+jKBJRPWFv+DnkUCrIWSNflSSSGgIIwLeR78T01gtizDuCUQ1rX/4xemoBTbwDRPkgggEFayiz6GlvBi+fOlBbCLd6lOj5R6kDnFBlAgMBAAECgYEA2I2M8TY9DhG9r+9WCv5yetvYpqtxNxSptGoX0zZBNTobVrC8OdjUfYbOQJJq/SNSEqieizX1HpaDj3uzKFZy8OCuZIKW/qbWBX7uKtaVsTBlBNV6hUmWalCd4NhVFZrYKxIRQd6WU+7K54fcLMa0Htran9y5grQlb7iFwETcg8ECQQD9S2gSFGvdp8VAoAU4HTQaKZuRiOs4w27So0iivhcTs5t3T8QPGs7ltZW82b3YJiTbyVM1DqWKyUMymVu+5Z4RAkEA3ch0HBP8woDXkcU25uBwvpfJIikKJ5GeJCx7A6CIhe2rnG9Lv9ev8cIxFBKNASGDZzZRGfxePMJbqnfxp/vJFQJBALShYcYC6ilXy0Ma2p35tX4yzc4rZhNEy3NLHjFwfeR+4Q9kwtxCsej+ZZoXbVsHWKGkIMJlf4hJnrImy1aHSQECQQDQbe2o4aPey6VMKpKhQfbTN+TfxL/1VeXQSzlEvF7xtt5cA0CmR7bjtsPXAGQh1vQeUK7BhCqwYVwyhczHOVrNAkEA4j6wfu/oGNzmgAedZns1WqcKv1UeTEY2WkckhC3MmQwWiiLkpwUmcbbf6366wsUq+soQ4LlHckfodl29tzJ8wQ==';


    //	开发者在付啦开放平台管理后台(https://open.fulapay.com/login.html)创建的APP的ID

    private  	$_app_id=1000203;


    //字符编码 默认UTF-8 目前仅支持UTF-8

    private  $_charset='UTF-8';



    //接口地址(线上环境)：https//api.fulapay.com /sms/send

    private  $_url='https://api.fulapay.com/sms/send';








    /**

     * 发送模板短信

     * @param to 短信接收彿手机号码集合,用英文逗号分开

     * @param datas 内容数据

     * @param $tempId 模板Id

     */

    function sendTemplateSMS($to,$datas,$tempId)

    {
        $data = array(
            'service' => 'sms.send',
            'charset' => 'UTF-8',
            'app_id' => $this->_app_id,
            'nonce_str' => uniqid(),
            'sign_type' => 'RSA',
            'tpl_id' => 220,
            'mobile'=>$to,
            'content'=>$datas
        );

        $string = $this->makeString($data);

        $sign = $this-> makeSign($string, $this->_private_key);
        $data['sign'] = $sign;
        $header = array('Content-type: text/html');
        $data = $this->array2xml($data);

        $result =$this->http($this->_url, $data, 'POST', $header);

       return $this->xml2array($result);
    }


    function makeString($data) {
        ksort($data);
        $flag = 1;
        foreach ($data as $k => $v) {
            if ($flag) {
                $string = $k . '=' . $v;
                $flag = 0;
            } else {
                $string .= '&' . $k . '=' . $v;
            }
        }
        return $string;
    }

    // php RSA 签名、加密 http://www.cnblogs.com/bwteacher/p/5757361.html
    function makeSign($string, $priKey) {
        $pem=chunk_split($priKey,64,"\n");
        $pem="-----BEGIN PRIVATE KEY-----\n".$pem."-----END PRIVATE KEY-----\n";
        $res = openssl_pkey_get_private($pem);
        $signature = '';
        openssl_sign($string, $signature, $res);
        openssl_free_key($res);
        return base64_encode($signature);
    }


    /**
     * 将数组转换成XML string
     * @param  array $array
     * @return xml
     */
    private  function array2xml($array = array()) {
        if (!is_array($array) || count($array) <= 0) {
            Log::error("array2xml --> 数组数据异常！");
        }
        $xml = "<xml>";
        foreach ($array as $key => $val) {
            if (is_numeric($val)) {
                $xml.="<" . $key . ">" . $val . "</" . $key . ">";
            } else {
                $xml.="<" . $key . "><![CDATA[" . $val . "]]></" . $key . ">";
            }
        }
        $xml.="</xml>";
        return $xml;
    }


    function http($url, $params, $method = 'GET', $httpHeader = '', $ssl = false) {

        $opts = array(CURLOPT_TIMEOUT => 2, CURLOPT_RETURNTRANSFER => 1, CURLOPT_SSL_VERIFYPEER => false, CURLOPT_SSL_VERIFYHOST => false);
        /* 根据请求类型设置特定参数 */
        switch (strtoupper($method)) {
            case 'GET':
                $getQuerys = !empty($params) ? '?' . urldecode(http_build_query($params)) : '';
                $opts[CURLOPT_URL] = $url . $getQuerys;
                // Log::record($opts[CURLOPT_URL]);
                break;
            case 'POST':
                $opts[CURLOPT_URL] = $url;
                $opts[CURLOPT_POST] = 1;
                $opts[CURLOPT_POSTFIELDS] = $params;
                break;
        }
        /* 初始化并执行curl请求 */
        $ch = curl_init();
        if (!empty($httpHeader) && is_array($httpHeader)) {
            curl_setopt($ch, CURLOPT_HTTPHEADER, $httpHeader);
        }

        curl_setopt_array($ch, $opts);
        curl_setopt($ch, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);
        $data = curl_exec($ch);

        $err = curl_errno($ch);
        $errmsg = curl_error($ch);
        curl_close($ch);
        if ($err > 0) {
            return false;
        } else {
            return $data;
        }
    }


    //**********************xml与array格式转换**********
    private  function xml2array($xml) {
        $data = (array) simplexml_load_string($xml, 'SimpleXMLElement', LIBXML_NOCDATA);
        return array_change_key_case($data, CASE_LOWER);
    }
}

?>

