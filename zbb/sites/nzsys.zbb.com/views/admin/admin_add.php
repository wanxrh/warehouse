<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>添加管理员</title>
<link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
<link href="<?php echo $this->config->item('domain_static'); ?>system/css/common.css" rel="stylesheet" type="text/css" />
<link href="<?php echo $this->config->item('domain_static'); ?>system/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>system/js/jquery.js"></script>

<script type="text/javascript">
$(document).ready(function(){
  $(".click").click(function(){
  $(".tip").fadeIn(200);
  });
  
  $(".tiptop a").click(function(){
  $(".tip").fadeOut(200);
});

  $(".sure").click(function(){
  $(".tip").fadeOut(100);
});

  $(".cancel").click(function(){
  $(".tip").fadeOut(100);
});

});
</script>


</head>


<body>

	<div class="u-bd-tt">
    <span>位置：</span>
    <ul >
        <li>权限管理</li>
    <li><a href="/admin">管理员列表</a></li>
    <li><a href="/admin/add">新增管理员</a></li>
    </ul>
    </div>
    
    <div class="g-mnr">       
    
    <table class="tablelist">
    	<tbody>
    	<form method="post" enctype="multipart/form-data" id="user_form" action="">
    	<ul class="forminfo">
    	
	    	<li><label>会员名<b>*</b></label>
	    	<input name="user_name" type="text" class="dfinput" value=""  style="width:300px;"/>请先输入会员名
	    	</li>       
        	
        
	    	

	    	<li><label>&nbsp;</label><input name="" type="submit" class="u-btn" value="提交"/></li>
        </ul>
        </form>
        </tbody>
    </table>
    
   

    
    
    <div class="tip">
    	<div class="tiptop"><span>提示信息</span><a></a></div>
        
      <div class="tipinfo">
        <span><img src="images/ticon.png" /></span>
        <div class="tipright">
        <p>是否确认对信息的修改 ？</p>
        <cite>如果是请点击确定按钮 ，否则请点取消。</cite>
        </div>
        </div>
        
        <div class="tipbtn">
        <input name="" type="button"  class="sure" value="确定" />&nbsp;
        <input name="" type="button"  class="cancel" value="取消" />
        </div>
    
    </div>
    
    
    
    
    </div>
    
    <script type="text/javascript">
	$('.tablelist tbody tr:odd').addClass('odd');
	</script>

</body>

</html>
