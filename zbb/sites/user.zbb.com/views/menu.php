<?php
$temp= '/'.$this->router->fetch_class().'/'.$this->router->fetch_method();
function get_cur($temp,$menu){
    if($temp==$menu){
        echo ' class="z-crt"';
    }
}
?>
<dl>
    <dt>宝贝管理</dt>
        <dd<?php get_cur($temp,'/goods/add');?>><a href="/goods/add">发布宝贝</a></dd>
        <dd<?php get_cur($temp,'/goods/index');?>><a href="/goods/index">全部宝贝管理</a></dd>
    <dt>交易管理</dt>
        <dd<?php get_cur($temp,'/orders/lists');?>><a href="/orders/lists">已卖出宝贝</a></dd>
    <dt>退货管理</dt>
    <dd<?php get_cur($temp,'/service/lists');?>><a href="/service/lists">退货管理</a></dd>
    <dt>物流管理</dt>
        <dd<?php get_cur($temp,'/address/lists');?>><a href="/address/lists">退货地址</a></dd>
    <dt>店铺管理</dt>
        <dd<?php get_cur($temp,'/message/lists');?>><a href="/message/lists">我的消息</a></dd>
        <dd<?php get_cur($temp,'/store/manage');?>><a href="/store/manage">店铺设置</a></dd>
        <dd<?php get_cur($temp,'/cate/lists');?>><a href="/cate/lists">宝贝分类管理</a></dd>
        <dd><a href="<?php echo $this->config->item('domain_hlpay_www'); ?>" target="_blank">互联支付</a></dd>
</dl>
