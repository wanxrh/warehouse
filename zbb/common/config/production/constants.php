<?php

$config = array();
define('COOKIE_NAME', 'NZW_YZ');

// 密钥 - COOKIE
define('KEY_COOKIE_CRYPT', '9a0c9baE');
define('KEY_COOKIE_CRYPT_IV', '0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF');

//注册绑定互联支付接口
//define('EXIST_HLUSER_URL', 'http://regapi.hulianpay.com/common/isExistOfUser'); //查询用户是否存在接口地址
//define('GET_HLUSER_URL', 'http://regapi.hulianpay.com/common/queryUserState'); //查询用户信息接口地址
//define('REG_HLUSER_URL', 'http://regapi.hulianpay.com/common/otherRegister'); //注册互联支付接口地址
//define('BIND_HLUSER_URL', 'http://regapi.hulianpay.com/common/registerBinding'); //绑定互联支付接口地址
define('EXIST_HLUSER_URL', 'http://192.168.0.55:6032/common/isExistOfUser'); //查询用户是否存在接口地址
define('GET_HLUSER_URL', 'http://192.168.0.55:6032/common/queryUserState'); //查询用户信息接口地址
define('REG_HLUSER_URL', 'http://192.168.0.55:6032/common/otherRegister'); //注册互联支付接口地址
define('BIND_HLUSER_URL', 'http://192.168.0.55:6032/common/registerBinding'); //绑定互联支付接口地址
define('HL_USER_BLANCE_URL', 'http://192.168.0.55:6032/common/queryUserBlance'); //绑定互联支付余额地址
define('HL_COMMON_KEY', 'yibanphp2015'); //绑定互联支付接口秘钥
//define('HL_COMMON_KEY', '7*appKEY'); //绑定互联支付接口秘钥
define('YIBAN_HUASUAN_ID', '2091722313');
define('YIBAN_HL_ID', '2091722312');//衣扮网余额收款互联支付ID
define('YIBAN_HLCHARGE_ID', '2091722313');//衣扮网充值收款互联支付ID
define('GUARANTEE_TRADING_FREEZE', 'http://192.168.0.55:6032/pay-to-medium-web/pay');//新版互联支付担保交易接口 --冻结
define('GUARANTEE_TRADING_PAY', 'http://192.168.0.55:6032/pay-to-medium-web/confirm');//新版互联支付担保交易接口 --支付
define('APP_GUARANTEE_TRADING_FREEZE', 'http://192.168.0.55:6032/medium-wap/pay');
define('APP_GUARANTEE_TRADING_PAY', 'http://192.168.0.55:6032/medium-wap/confirm');//APP担保交易接口 --支付
define('AUTOMATIC_GUARANTEE_TRADING_PAY', 'http://192.168.0.55:6032/pay-to-medium-web/pay-back-automatic');//新版互联支付担保交易接口 --自动返款
define('GUARANTEE_TRADING_KEY', 'm7');//担保交易秘钥
define('OPEN_CHARGE_PAY', FALSE); //开启充值支付
define('NEW_HL_CHARGE_TO_PAY', 'https://reg.hulianpay.com/recharge/recharge-yiban');
define('NEW_HL_WEIXIN_PAY', 'https://reg.hulianpay.com/recharge/weixin/weixin-native-pay');
define('NEW_HL_EBANK_PAY', 'https://reg.hulianpay.com/recharge/recharge');
define('NEW_HL_APP_EBANK_PAY', 'http://192.168.62.169:6032/wap-recharge/recharge-wap');
define('NEW_HL_APP_CHARGE_TO_PAY', 'http://192.168.62.169:6032/wap-recharge/recharge-app');
//define('NEW_HL_CHARGE_TO_PAY', 'http://192.168.0.55:6032/recharge/recharge');//新版互联支付充值支付接口
define('APP_HL_CHARGE_TO_PAY', 'http://192.168.0.220:6032/recharge/recharge-wap');//新版互联支付充值支付接口
define('NEW_CHARGE_TO_PAY_KEY', '777777'); //新版互联支付充值支付秘钥

define('IM_URL', 'http://192.168.62.191:5880/'); //聊天工具地址
define('IM_KEY', '95F0E6B3D5E14C20935D2F09EC663F46'); //聊天工具接口key
define('HLPAY_URL', 'http://www.weipay.com/'); //互联支付地址，必须以/结尾
define('HLPAY_GATEWAY', 'http://www.weipay.com/Trade/pay'); //互联支付网关地址
define('HLPAY_CHARGE', 'http://inpour.weipay.com/user/inpour');//互联支付充值地址'http://192.168.63.183:8080/recharge-web/recharge''http://inpour.weipay.com/user/inpour''http://inpour.hulianpay.com/recharge/recharge'
define('HL_CHARGE_TO_PAY', 'http://inpour.weipay.com/user/pay');//互联支付充值支付地址
define('HLPAY_AMOUNT', 'http://192.168.63.211:6032/common-web/queryUserBlance');//互联支付余额地址
define('HLPAY_KEY', '777777'); //互联支付密钥
define('CHARGE_TO_PAY_KEY', '777777'); //互联支付充值支付秘钥
define('HLCHARGE_KEY', '777777'); //互联充值密钥GirlZWApi@$# '777777'
define('HLAMOUNT_KEY', '777777'); //互联余额密钥yibanphp2015
define('HLPAY_SITE', '7'); //互联支付分配的站点类型
// 互联支付 - 调试开关
define('HLPAY_DEBUG', TRUE);

// 金币接口相关参数
define('COIN_PLATFORM_ID', 3); // 衣扮网平台金币账户id
define('COIN_URL', 'api.sk4.com/'); // 金币接口地址
define('COIN_KEY', 'SKLM%JBJY@KEY'); // 金币接口key

//订单状态
define('ORDER_PENDING', 11); // 等待买家付款
define('ORDER_ACCEPTED', 20); // 买家已付款，等待卖家发货
define('ORDER_SHIPPED', 30); // 卖家已发货
define('ORDER_FINISHED', 40); // 已完成
define('ORDER_CANCELED', 0); // 已取消
define('ORDER_DRAWBACK', 50); // 待退款
define('ORDER_NOTSHOW', 60); // 买家已经删除的订单
define('ORDER_RETURNING', 70); //退货中

//商品状态
define('GOODS_SHOW', 1); // 上架-if_show
define('GOODS_NOTSHOW', 0); // 下架-if_show
define('GOODS_NOTRELEASE', -1); // 未发布-if_show
define('GOODS_CLOSED', 1); // 禁售-closed
define('GOODS_NOTCLOSED', 0); // 非禁售-closed
define('GOODS_DELETED', 1); // 删除-is_del
define('GOODS_NOTDELETED', 0); // 非删除-is_del
define('GOODS_RECOMMENDED', 1); // 推荐-recommended
define('GOODS_NOTRECOMMENDED', 0); // 不推荐-recommended

define('IS_POST', (strtoupper($_SERVER['REQUEST_METHOD']) == 'POST'));
define('IS_GET', (strtoupper($_SERVER['REQUEST_METHOD']) == 'GET'));

//允许图片类型
define('IMAGE_FILE_TYPE', 'gif|jpg|jpeg|png');

//自动操作时间

define('ATUO_CANCEL', 1);                  // 未付款自动取消订单号，天数
define('ATUO_DRAWBACK', 2);                // 发货前申请退款，未处理，自动返款天数
define('ATUO_COMFIRM', 10);                //自动收货天数
define('ATUO_DRAWBACK_GOODS', 5);          //已发货的的情况下申请退款和退货
define('ATUO_DRAWBACK_LIMIT', 7);          //同意退货后，买家退货的时间限制
define('ATUO_DRAWBACK_MOD_TIMES', 7);      //拒绝退款、退货后，买家修改的时间
define('ATUO_DRAWBACK_SHIP', 5);            //已发货的的情况下,申请退款、退货时间
define('ATUO_RETURNED_LIMIT', 10);            //买家退货之后，商家响应的时间限制
//语音API
define('VOICE', 'http://voice-api.luosimao.com/v1/verify.json');
define('VOICE_KEY', 'api:key-efacaff5d68e344af552db5168418a4b');
