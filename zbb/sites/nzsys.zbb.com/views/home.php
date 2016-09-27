<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>欢迎登录后台管理系统</title>
    <link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet" type="text/css" />
    <link href="<?php echo $this->config->item('domain_static'); ?>system/css/login.css" rel="stylesheet" type="text/css" />
    <script language="JavaScript" src="<?php echo $this->config->item('domain_static'); ?>system/js/jquery.js"></script>
    <script src="<?php echo $this->config->item('domain_static'); ?>system/js/cloud.js" type="text/javascript"></script>
    <script language="javascript">
     $(function(){
        $('.g-bdc').css({'position':'absolute','left':($(window).width()-692)/2});
        $(window).resize(function(){  
            $('.g-bdc').css({'position':'absolute','left':($(window).width()-692)/2});
        })  
    });  
 </script> 
</head>
<body>
  <div id="mainBody" class="g-mn">
   <div id="cloud1" class="g-mnc"></div>
   <div id="cloud2" class="g-mnc g-mnc-2"></div>
</div>  
<div class="g-hd">    
 <h1>欢迎登录后台管理界面平台</h1>    
 <ul>
     <li><a href="<?php echo $this->config->item('domain_www'); ?>">回首页</a></li>
 </ul>    
</div>

<div class="g-bd">
    <div class="u-logo"></div> 
    <div class="g-bdc">
        <form action="/home/login" method="post">
            <ul>
                <li><input name="user_name" type="text" class="u-text u-text-user" value="" onclick="JavaScript:this.value=''"/></li>
                <li><input name="password" type="password" class="u-text u-text-pwd" value="" onclick="JavaScript:this.value=''"/></li>
                <li><input name="" type="submit" class="u-btn-login" value="登录"  onclick=""  /></li>
            </ul>
        </form>
    </div>  
</div>
</body>
</html>
