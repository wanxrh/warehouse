<?php

// 各站点域名（若定义其它站点，则格式为：domain_主域名_二级域名）
$config['domain_www'] = 'http://www.zbb0.com/';
$config['domain_user'] = 'http://user.zbb0.com/';
$config['domain_static'] = 'http://static.zbb0.com/';
$config['domain_nzsys'] = 'http://nzsys.zbb0.com/';
$config['domain_mobile'] = 'http://mobile.zbb0.com/';
$config['domain_img'] = 'http://img.zbb0.com/';
$config['domain_app'] = 'http://app.zbb0.com/';
$config['domain_paynotify'] = 'http://paynotify.zbb0.com/';
// 其它站点
$config['domain_hlpay_www'] = 'http://www.shikeehlpay.com/';
$config['domain_hlpay_soap'] = 'http://www.shikeehlpay.com/';
$config['domain_hlpay_trade'] = 'http://trade.shikeehlpay.com/';
$config['domain_zhs_www'] = 'http://www.zhs.com/';
$config['domain_zhs_list'] = 'http://list.zhs.com/';

//会员模块图片上传
$config['_root_dir'] = 'd:/zbb_img';// 网站物理根目录
$config['_allowed_file_type'] =array('gif','jpg','jpeg','png');
$config['_allowed_file_size'] ='204800';// 200KB

//订单状态相应的文字表述
$config['order_pending'] =  '待付款';
$config['order_accepted'] =  '待发货';
$config['order_canceled'] =  '已取消';
$config['order_drawback'] =  '买家申请退款';
$config['order_submitted'] =  '已提交';
$config['order_shipped'] =  '已发货';
$config['order_finished'] =  '已完成';
$config['order_returning'] =  '买家申请退货';
$config['order_notshow'] =  '已删除';

//发送邮件，调用配置
$config['smtp_user'] = '769390531@qq.com';

//注册关键字过滤
$config['key_word'] = array('是划算', 'Shihuasuan', 'shihuasuan', 'Zhonghuasuan', 'zhonghuasuan', '专员', '是划', '客服', '质检', '质检局', '官方', '审核', '试客联盟', '联盟', '管理员', '共产党', '法轮功', '台独', 'admin', 'shikee', 'Shikee', 'sklm', '天客', 'tiankee', 'tianke', '盟主室', '盟主', '兼职', '众划算', '划算', '众划', '兼耳只', '柏宋', '周柏宋', '批量申请', '朋贝网', '朋贝', '贝网', 'Pengbeiwang', 'Pengbei', '官网', '小二', 'Pengbay', 'Pengbaywang', '质量检查');

//cookie 站点
$config['cookie_domain'] = 'zbb0.com';