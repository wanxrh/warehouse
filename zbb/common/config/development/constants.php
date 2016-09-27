<?php
$config = array();

define('COOKIE_NAME', 'ZHONGBAOBEI');

// 密钥 - COOKIE
define('KEY_COOKIE_CRYPT', '9a0c9baE');
define('KEY_COOKIE_CRYPT_IV', '0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF');

define('IS_POST', (strtoupper($_SERVER['REQUEST_METHOD']) == 'POST'));
define('IS_GET', (strtoupper($_SERVER['REQUEST_METHOD']) == 'GET'));

//允许图片类型
define('IMAGE_FILE_TYPE', 'gif|jpg|jpeg|png');

/*****************************************************************************************************************/
define('DOMAIN_NAME', '众宝贝');
define('SIGN_DEBUG', 0);//用户签名检测开关，1开，0关闭
//登陆错误编码
define('USER_UNDEFINE', 20);//用户不存在
define('BUYER_USER_UNDEFINE', 21);//用户不存在
define('SELLER_USER_UNDEFINE', 22);//用户不存在
define('PASSWORD_ERROR', 23);//密码错误
define('USER_BANED', 24);//账号被封号
define('USER_UNACTIVATE', 25);//账号未激活
define('USER_SHIELD', 26);//账号已屏蔽
define('USER_SHIELDING', 27);//账号已屏蔽，待审核
define('UNDEFINED_LOGIN_SIGN', 28);//登陆签名未定义
define('ERROR_LOGIN_SIGN', 29);//登陆签名不正确

//注册错误编码
define('REG_FAILURE', 30);//注册失败
define('MOBILE_SEND_MAX', 31);//手机验证码发送次数过多
define('MOBILE_FREQUENCY_MAX', 32);//手机验证码发送频率
define('CODE_ERROR', 33);//手机验证码错误
define('CODE_TIME_OUT', 34);//手机验证码超时
define('PASSWORD_UNSAME', 35);//密码不一致

//用户信息错误编码
define('EMAIL_EXISTS', 40);//邮箱已经存在
define('EMAIL_ERROR', 41);//邮箱不规范
define('MOBILE_EXISTS', 42);//手机已经存在
define('MOBILE_ERROR', 43);//手机不规范
define('USERNAME_EXISTS', 44);//用户名已存在
define('NICKRNAME_EXISTS', 45);//昵称已存在
define('ERROR_KEYWORD', 46);//非法字段
define('USERNAME_UNNORM', 47);//用户名不规范
define('PASSWORD_UNNORM', 48);//密码不规范

//订单状态
define('ORDER_UNPAY', 10); // 买家未支付
define('ORDER_PAID', 20); // 买家已付款，等待卖家发货
define('ORDER_SHIPPED', 30); // 卖家已发货
define('ORDER_FINISHED', 40); // 已完成
define('ORDER_CANCELED', 1); // 已取消
//订单商品状态
define('ORDER_GOODS_UNPAY', 11); //订单中商品未支付
define('ORDER_GOODS_CANCELED', 2); //订单中商品取消付款
define('ORDER_GOODS_PAID', 21); //订单中商品已支付，等待卖家发货
define('ORDER_GOODS_SHIPPED', 31); //订单中商品已发货
define('ORDER_GOODS_DRAWBACK', 50); //订单中商品退款中
define('ORDER_GOODS_RETURNING', 60); //订单中商品退货中
define('ORDER_GOODS_DRAWBACKED', 51); //订单中商品退款成功
define('ORDER_GOODS_RETURNED', 61); //订单中商品退货成功
define('ORDER_GOODS_FINISHED', 41); //订单中商品确认收货

//自动操作时间
define('AUTO_CANCEL', 3 * 86400);//未付款自动取消订单
define('AUTO_COMFIRM', 15 * 86400);//自动确认收货
define('AUTO_UNSHIP_DRAWBACK', 2 * 86400);//拍下没发货申请退款，2天内商家无操作，自动退款
define('AUTO_SHIPPED_DRAWBACK', 5 * 86400);//发货下，会员申请仅退款，商家无响应，自动退款。
define('AUTO_SHIPPED_REFUSE_DRAWBACK', 7 * 86400);//发货下，商家拒绝退款，会员7天修改退款协议，否则自动撤销。
define('AUTO_SHIPPED_UNRESPOND_RETURN', 5 * 86400);//发货下,会员申请退货,商家无响应，并发送退货地址。
define('AUTO_SHIPPED_AGREE_RETURN', 7 * 86400);//发货下,会员申请退货,会员7天内填写物流单号，否则自动撤销。
define('AUTO_SHIPPED_REFUSE_RETURN', 7 * 86400);//商家拒绝退货，会员7天修改退货协议，否则自动撤销。
define('AUTO_SHIPPED_REFUSE_RECEIPT', 7 * 86400);//商家拒收退货，会员7天修改退货信息，否则自动撤销。
define('AUTO_SHIPPED_BUYER_RETURNED', 10 * 86400);//会员填写物流单号，商家无响应，10天后自动打款。

//定时器类型
define('CANCEL_TIMER', 1);//未付款自动取消订单
define('COMFIRM_TIMER', 2);//自动确认收货
define('UNSHIP_DRAWBACK_TIMER', 3);//拍下没发货申请退款，2天内商家无操作，自动退款
define('SHIPPED_DRAWBACK_TIMER', 4);//发货下，会员申请仅退款，商家无响应，自动退款。
define('SHIPPED_REFUSE_DRAWBACK_TIMER', 5);//发货下，商家拒绝退款，会员7天修改退款协议，否则自动撤销。
define('SHIPPED_UNRESPOND_RETURN_TIMER', 6);//发货下,会员申请退货,商家无响应，并发送退货地址。
define('SHIPPED_AGREE_RETURN_TIMER', 7);//发货下,会员申请退货,会员7天内填写物流单号，否则自动撤销。
define('SHIPPED_REFUSE_RETURN_TIMER', 8);//商家拒绝退货，会员7天修改退货协议，否则自动撤销。
define('SHIPPED_REFUSE_RECEIPT', 9);//商家拒收退货，会员7天修改退货信息，否则自动撤销。
define('SHIPPED_BUYER_RETURNED_TIMER', 10);//会员填写物流单号，商家无响应，10天后自动打款。

//售后日志节点
define('APPLY_REFUND', 0);//您成功提交退款申请
define('REFUSE_REFUND', 1);//卖家拒绝了您的退款申请
define('MODIFY_REFUND', 2);//您成功修改了退款申请
define('APPLY_RETURN', 3);//您成功提交退款退货申请
//define('REFUSE_RETURN', 4);//卖家拒绝了您的退款/退货申请
define('MODIFY_RETURN', 4);//您成功修改了退款/退货申请
define('AGREE_RETURN', 5);//卖家同意了您的退款/退货申请
define('RETURN_MESSAGE', 6);//您已提交退货信息
define('MODIFY_MESSAGE', 7);//买家修改退货信息
define('APPLY_INTERVENE', 8);//您已申请客服介入处理
define('REFUND_CLOSE', 9);//退款关闭
define('REFUND_SUCCESS', 10);//退款成功

//售后申请状态
define('AFTERMARKET_HANDLE', 0);//等待卖家处理
define('AFTERMARKET_AGREE', 1);//卖家同意
define('AFTERMARKET_REFUSE', 2);//卖家拒绝申请
define('AFTERMARKET_GOODS_RETURNING', 3);//买家退回商品
define('AFTERMARKET_REFUSE_RETURN', 4);//卖家拒绝签收退货商品
define('AFTERMARKET_INTERVENE', 5);//申请客服介入
define('AFTERMARKET_SUCCESS', 6);//退款成功
define('AFTERMARKET_CLOSE', 7);//退款关闭

//客服申述状态
define('APPEAL_HANDLE', 0);//等待处理
define('APPEAL_CLOSE', 1);//关闭
define('APPEAL_SUCCESS', 2);//成功

/*↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓互联支付配置↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓*/

define('HLPAY_SITE', 19); //互联支付分配的站点类型

define('SERVICE_CHARGES_CHARGEDID', '2091722321');//余额支付收取技术服务费互联支付ID

/*↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓互联支付通用接口和秘钥↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓*/
define('EXIST_HLUSER_URL', 'http://192.168.0.55:6032/common/isExistOfUser'); //查询用户是否存在接口地址
define('HL_USER_BLANCE_URL', 'http://192.168.0.55:6032/common/queryUserBlance'); //绑定互联支付余额地址
define('HL_COMMON_KEY', 'c19'); //绑定互联支付接口秘钥
/*↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑互联支付通用接口和秘钥↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑*/

/*↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓互联支付担保交易接口和秘钥↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓*/
define('GUARANTEE_TRADING_FREEZE', 'http://192.168.0.55:6032/medium-wap/pay');//支付冻结
define('GUARANTEE_TRADING_PAY', 'http://192.168.0.55:6032/medium-wap/confirm');//支付
define('GUARANTEE_TRADING_PAY_WEB', 'http://192.168.0.55:6032/pay-to-medium-web/confirm');//PC端 退款
define('AUTOMATIC_GUARANTEE_TRADING_PAY', 'http://192.168.0.55:6032/pay-to-medium-web/pay-back-automatic');//自动返款
define('GUARANTEE_TRADING_KEY', 'm19');//担保交易秘钥
/*↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑互联支付担保交易接口和秘钥↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑*/

/*↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓互联支付充值支付接口和秘钥↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓*/
define('HL_WEIXIN_PAY', 'http://192.168.0.55:6032/wap-recharge/weixin/weixin-app-pay'); //APP微信支付
define('WEIXIN_ORDER_QUERY', 'http://192.168.0.55:6032/wap-recharge/weixin/weixin-order-query'); //微信APP充值结果查询接口
define('CHARGE_TO_PAY_KEY', 'r19'); //支付充值支付秘钥
/*↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑互联支付充值支付接口和秘钥↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑*/

