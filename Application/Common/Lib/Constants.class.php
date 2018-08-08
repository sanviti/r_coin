<?php
namespace Common\Lib;
/**
 * 全局常量
 */
class Constants{

    # AUTH_TOKEN 登录令牌
    # USER_TOKEN 用户令牌
    const PUB_SALT = '#YGYH3i8Y0!z3*'; //公共盐
    const SIGN_SALT = '###Xabas8un8C225653'; //公共盐
    const BASE_URL = '192.168.0.129';
    const PUB_CACHE_TIME = 300; //缓存时间 秒
    const AUTH_TOKEN_TIME = 43200; //session token过期时间 12h
    const SMS_INTERVAL_TIME = 80; //短信发送间隔 单位秒
    const SMS_EXPIRE_TIME = 300; //验证码有效期

    const IMAGE_CODE_EXPIRE_TIME = 300; //图形验证码有效期

    #短信类型
    const SMS_REGISTER_CODE = 1; //注册验证码
    const SMS_APPLYCASH_CODE = 2; //申请提现验证码
    const SMS_FINDPWD_CODE = 3; //找回密码验证码
    const SMS_RESETPAYPWD_CODE = 4; //找回密码验证码
    #短信模板ID
    const SMSTEMPLATE_REG_VCODE = 247020;
    const SMSTEMPLATE_FINDPWD_VCODE = 247020;
    #错误代码
    const ERRCODE_AUTHTOKEN_VOID = 10000; //登录失效
    const ERRCODE_MEMBER_VOID = 10001; //用户不存在
    const ERRCODE_MEMBER_LOCK = 10002; //用户锁定
    const ERRCODE_SIGNTRUE_VOID = 10003; //签名失效
    const DEAL_FEE = 0.3; #交易手续费 30%

    #计划任务
    const PLAN_CLOSE_MILL = 'PLAN_CLOSE_MILL';  //关闭矿机 任务名
    const PLAN_AWARD_POWER = 'PLAN_AWARD_POWER'; //小区分红最后处理ID
  	const PLAN_ORDERS = 'PLAN_ORDERS'; //交易
}