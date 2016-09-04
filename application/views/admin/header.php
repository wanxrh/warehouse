<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8">
<meta content="weiphp,互联网+,微信开源开发框架" name="keywords"/>
<meta content="weiphp是互联网+的IT综合解决方案" name="description"/>
<!-- <link rel="shortcut icon" href="http://www.xxx.com/favicon.ico"> -->
<title>老山圈</title>
<link href="<?php echo $this->config->base_url(); ?>static/css/admin/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="<?php echo $this->config->base_url(); ?>static/css/admin/base.css" rel="stylesheet">
<link href="<?php echo $this->config->base_url(); ?>static/css/admin/module.css" rel="stylesheet">
<link href="<?php echo $this->config->base_url(); ?>static/css/admin/weiphp.css" rel="stylesheet">
<link href="<?php echo $this->config->base_url(); ?>static/css/admin/emoji.css" rel="stylesheet">
<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
<script src="/Public/static/bootstrap/js/html5shiv.js?v=20150826"></script>
<![endif]-->

<!--[if lt IE 9]>
<script type="text/javascript" src="/Public/static/jquery-1.10.2.min.js"></script>
<![endif]-->
<!--[if gte IE 9]><!-->
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/js/jquery-2.0.3.min.js"></script>
<!--<![endif]-->
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/zclip/ZeroClipboard.min.js"></script>
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/js/dialog.js"></script>
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/js/admin_common.js"></script>
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/js/admin_image.js"></script>
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/masonry/masonry.pkgd.min.js"></script>
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/js/jquery.dragsort-0.5.2.min.js"></script> 
<!-- 页面header钩子，一般用于加载插件CSS文件和代码 -->

</head>
<body>
    <!-- 头部 -->
    <!-- 提示 -->
<div id="top-alert" class="top-alert-tips alert-error" style="display: none;">
  <a class="close" href="javascript:;"><b class="fa fa-times-circle"></b></a>
  <div class="alert-content"></div>
</div>
<!-- 导航条
================================================== -->
<div class="navbar navbar-inverse navbar-fixed-top">
    <div class="wrap">             
        <div class="top_nav">
            <ul class="nav" style="margin-right:0">
                     
                <li data-id="" class=""><a href="/login/logout">退出</a></li>
                
            </ul>
        </div>
    </div>
</div>
    <!-- /头部 -->
    
    <!-- 主体 -->
    
<div id="main-container" class="admin_container">
  <div class="sidebar">
      <ul class="sidenav">
        <li>
            <a class="sidenav_parent" href="javascript:;">菜单栏</a>
            <ul class="sidenav_sub">
            	<!-- class="active" -->
                <li ><a href="/admin/index"> 商品管理 </a><b class="active_arrow"></b></li>
                <li ><a href="/admin/category"> 商品分类 </a><b class="active_arrow"></b></li>
                <li ><a href="/admin/order"> 订单管理 </a><b class="active_arrow"></b></li>
                <li ><a href="/admin/product"> 产品溯源 </a><b class="active_arrow"></b></li>
                <li ><a href="/admin/voucher"> 商品兑换卷 </a><b class="active_arrow"></b></li>
                <li><a href="/admin/slideshow"> 首页幻灯片 </a><b class="active_arrow"></b></li>
                <li><a href="/admin/qrcode"> 代理管理 </a><b class="active_arrow"></b></li>
				<li><a href="/admin/cash"> 提现管理 </a><b class="active_arrow"></b></li>
            </ul>
        </li>
         <!-- <li>
            <a class="sidenav_parent" href="javascript:;">公众号功能</a>
            <ul class="sidenav_sub">
                <li ><a href="/admin/welcome"> 欢迎语设置 </a><b class="active_arrow"></b></li>
            </ul>
        </li> -->
    </ul>
</div>  