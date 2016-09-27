<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>衣扮网后台管理中心</title>
        <link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
        <link href="<?php echo $this->config->item('domain_static'); ?>system/css/left.css" rel="stylesheet" type="text/css" />
        <script language="JavaScript" src="<?php echo $this->config->item('domain_static'); ?>system/js/jquery.js"></script>

        <script type="text/javascript">
            $(function() {
                //导航切换
                $(".m-menu li").click(function() {
                    $(".m-menu li.active").removeClass("active")
                    $(this).addClass("active");
                });

                $('.u-title').click(function() {
                    var $ul = $(this).next('ul');
                    $('dd').find('ul').slideUp();
                    if ($ul.is(':visible')) {
                        $(this).next('ul').slideUp();
                    } else {
                        $(this).next('ul').slideDown();
                    }
                });
            })
        </script>
    </head>

    <body>
        <div class="g-lefttop"><span></span>系统管理</div>
        <dl class="g-leftmenu">
            <?php if (in_array(18, $level_id)): ?>
                <dd>
                    <div class="u-title">
                        <span><img src="<?php echo $this->config->item('domain_static'); ?>system/images/leftico01.png" /></span>会员管理
                    </div>
                    <ul class="m-menu m-menu-ctr">
                        <?php if (in_array(1, $level_id)): ?>
                            <li><cite></cite><a href="/user" target="rightFrame">会员列表</a><i></i></li>
                        <?php endif; ?>

                        <?php if (in_array(3, $level_id)): ?>
                            <li><cite></cite><a href="/message" target="rightFrame">消息群发</a><i></i></li>
                        <?php endif; ?>
                    </ul>    
                </dd>
            <?php endif; ?>

            <?php if (in_array(19, $level_id)): ?>
                <dd>
                    <div class="u-title">
                        <span><img src="<?php echo $this->config->item('domain_static'); ?>system/images/leftico01.png" /></span>店铺管理
                    </div>
                    <ul class="m-menu">
                        <?php if (in_array(4, $level_id)): ?>
                            <li><cite></cite><a href="/store?store_license=0" target="rightFrame">店铺列表</a><i></i></li>
                        <?php endif; ?>
                        <li><cite></cite><a href="/store/apply" target="rightFrame">申请店铺列表</a><i></i></li>
                    </ul>    
                </dd>
            <?php endif; ?>

            <?php if (in_array(20, $level_id)): ?>
                <dd>
                    <div class="u-title">
                        <span><img src="<?php echo $this->config->item('domain_static'); ?>system/images/leftico01.png" /></span>商品管理
                    </div>
                    <ul class="m-menu">
                        <?php if (in_array(5, $level_id)): ?>
                            <li><cite></cite><a href="/goods" target="rightFrame">商品列表</a><i></i></li>
                        <?php endif; ?>
                        <?php if (in_array(6, $level_id)): ?>
                            <li><cite></cite><a href="/gcategory" target="rightFrame">分类管理</a><i></i></li>
                        <?php endif; ?>
                    </ul>    
                </dd>
            <?php endif; ?>

            <?php if (in_array(21, $level_id)): ?>
                <dd>
                    <div class="u-title">
                        <span><img src="<?php echo $this->config->item('domain_static'); ?>system/images/leftico01.png" /></span>订单管理
                    </div>
                    <ul class="m-menu">
                        <?php if (in_array(8, $level_id)): ?>
                            <li><cite></cite><a href="/order" target="rightFrame">订单列表</a><i></i></li>  
                        <?php endif; ?>
                         <?php if (in_array(62, $level_id)): ?>
                        <li><cite></cite><a href="/order/order_goods" target="rightFrame">订单商品列表</a><i></i></li>
                        <?php endif; ?>
                        <li><cite></cite><a href="/appeal/lists" target="rightFrame">待处理申诉列表</a><i></i></li>
                        <li><cite></cite><a href="/appeal/handled" target="rightFrame">已处理申诉列表</a><i></i></li>
                    </ul>    
                </dd>
            <?php endif; ?>

            <?php if (in_array(22, $level_id)): ?>
                <dd>
                    <div class="u-title">
                        <span><img src="<?php echo $this->config->item('domain_static'); ?>system/images/leftico01.png" /></span>文章管理
                    </div>
                    <ul class="m-menu">
                        <?php if (in_array(10, $level_id)): ?>
                            <li><cite></cite><a href="/article" target="rightFrame">文章列表</a><i></i></li>
                        <?php endif; ?>
                        <?php if (in_array(11, $level_id)): ?>
                            <li><cite></cite><a href="/acategory" target="rightFrame">文章分类</a><i></i></li>
                        <?php endif; ?>
                    </ul>    
                </dd>
            <?php endif; ?>

            <?php if (in_array(23, $level_id)): ?>
                <dd>
                    <div class="u-title">
                        <span><img src="<?php echo $this->config->item('domain_static'); ?>system/images/leftico01.png" /></span>推送管理
                    </div>
                    <ul class="m-menu">
                        <?php if (in_array(12, $level_id)): ?>
                            <li><cite></cite><a href="/linkecate?type=1" target="rightFrame">文字推送</a><i></i></li>
                        <?php endif; ?>
                        <?php if (in_array(13, $level_id)): ?>
                            <li><cite></cite><a href="/linkecate?type=2" target="rightFrame">图片推送</a><i></i></li>
                        <?php endif; ?>
                        <?php if (in_array(14, $level_id)): ?>
                            <li><cite></cite><a href="/recom" target="rightFrame">商品推送</a><i></i></li>
                        <?php endif; ?>
                    </ul>    
                </dd>
            <?php endif; ?>

            <?php if (in_array(24, $level_id)): ?>
                <dd>
                    <div class="u-title">
                        <span><img src="<?php echo $this->config->item('domain_static'); ?>system/images/leftico01.png" /></span>权限管理
                    </div>
                    <ul class="m-menu">
                        <?php if (in_array(17, $level_id)): ?>
                            <li><cite></cite><a href="/level" target="rightFrame">管理员权限列表</a><i></i></li>
                        <?php endif; ?>
                        <?php if (in_array(27, $level_id)): ?>
                            <li><cite></cite><a href="/level/level_list" target="rightFrame">权限列表</a><i></i></li>
                        <?php endif; ?>
                        <?php if (in_array(2, $level_id)): ?>
                            <li><cite></cite><a href="/admin" target="rightFrame">管理员列表</a><i></i></li>
                        <?php endif; ?>
                    </ul>    
                </dd>
            <?php endif; ?>


            <?php if (in_array(32, $level_id)): ?>
                <dd>
                    <div class="u-title">
                        <span><img src="<?php echo $this->config->item('domain_static'); ?>system/images/leftico01.png" /></span>资金管理
                    </div>
                    <ul class="m-menu">
                        <?php if (in_array(33, $level_id)): ?>
                            <li><cite></cite><a href="/service" target="rightFrame">技术服务费</a><i></i></li>
                        <?php endif; ?>
                        <li><cite></cite><a href="/rate" target="rightFrame">服务费资费标准</a><i></i></li>
                        <!--                        --><?php //if (in_array(38, $level_id)): ?>
<!--                            <li><cite></cite><a href="/goldconf/percent" target="rightFrame">服务配置</a><i></i></li>-->
<!--                        --><?php //endif; ?>
                    </ul>    
                </dd>
            <?php endif; ?>

            <?php if (in_array(26, $level_id)): ?>
                <dd>
                    <div class="u-title">
                        <span><img src="<?php echo $this->config->item('domain_static'); ?>system/images/leftico01.png" /></span>其他管理
                    </div>
                    <ul class="m-menu">
                       <?php if (in_array(71, $level_id)): ?>
                        <li><cite></cite><a href="/apk/index" target="rightFrame">apk更新</a><i></i></li>
                        <?php endif; ?>
                        <?php if (in_array(15, $level_id)): ?>
                            <li><cite></cite><a href="/region" target="rightFrame">地区管理</a><i></i></li>
                        <?php endif; ?>
                        	<li><cite></cite><a href="/payment" target="rightFrame">支付管理</a><i></i></li>
                          <?php if (in_array(72, $level_id)): ?>
                        <li><cite></cite><a href="/client" target="rightFrame">文件列表</a><i></i></li>
                        <?php endif; ?>
                        <li><cite></cite><a href="/logs/look" target="rightFrame">日志查看</a><i></i></li>
                    </ul>    
                </dd>
            <?php endif; ?>
        </dl>
    </body>
</html>
