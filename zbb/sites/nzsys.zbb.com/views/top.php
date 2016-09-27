<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>无标题文档</title>
    <link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
    <link href="<?php echo $this->config->item('domain_static'); ?>system/css/top.css" rel="stylesheet" type="text/css" />
    <script language="JavaScript" src="<?php echo $this->config->item('domain_static'); ?>system/js/jquery.js"></script>
    <script type="text/javascript">
        $(function(){	
	//顶部导航切换
	$(".g-nav a").click(function(){
		$(".g-nav a.selected").removeClass("selected")
		$(this).addClass("selected");
	})	
})	
    </script>


</head>

<body class="body-topbar clearfix">
    <div class="g-topleft">
        <img src="<?php echo $this->config->item('domain_static'); ?>system/images/logo.png" title="系统首页" />
    </div>

    <ul class="g-nav">
        <?php if(in_array(18,$level_id)): ?>
            <li><a href="/user" target="rightFrame"><img src="<?php echo $this->config->item('domain_static'); ?>system/images/icon02.png" /><h2>会员管理</h2></a></li>
        <?php endif; ?>
        <?php if(in_array(19,$level_id)): ?>
            <li><a href="/store"  target="rightFrame"><img src="<?php echo $this->config->item('domain_static'); ?>system/images/icon03.png" /><h2>店铺管理</h2></a></li>
        <?php endif; ?>
        <?php if(in_array(20,$level_id)): ?>
            <li><a href="/goods"  target="rightFrame"><img src="<?php echo $this->config->item('domain_static'); ?>system/images/icon04.png"  /><h2>商品管理</h2></a></li>
        <?php endif; ?>
        <?php if(in_array(21,$level_id)): ?>
            <li><a href="/order" target="rightFrame"><img src="<?php echo $this->config->item('domain_static'); ?>system/images/icon05.png" /><h2>订单管理</h2></a></li>
        <?php endif; ?>
        <li><a href="/main/right"  target="rightFrame"><img src="<?php echo $this->config->item('domain_static'); ?>system/images/icon06.png" title="系统设置" /><h2>系统设置</h2></a></li>
    </ul>

    <div class="g-topright">    
        <ul>
            <li><a href="<?php echo $this->config->item('domain_www'); ?>" target="_blank">查看首页</a></li>
            <li><a href="<?php echo $this->config->item('domain_login'); ?>home/logout" target="_parent">退出</a></li>
        </ul>  
        <div class="m-user">
          <span><?php echo get_admin(TRUE);?></span>
        </div>    
  </div>

</body>
</html>
