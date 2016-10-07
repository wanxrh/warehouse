<html>
<head>
    <meta http-equiv="content-type" content="text/html;charset=utf-8"/>
    <meta name="viewport"content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;">
	<meta name="apple-mobile-web-app-capable"content="yes">
    <meta name="apple-mobile-web-app-status-bar-style"content="black">
    <meta name="format-detection"content="telephone=no">
    <title>老山圈</title>
    <script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/js/jquery-2.0.3.min.js"></script>
    <style type="text/css">
		*{ padding:0; margin:0;}
    	.payHead{ background:#096; padding:60px; text-align:center; color:#fff}
		.payHead .span1{ font-size:24px;}
		.payHead .price{ font-size:30px; line-height:40px; font-weight:bold;}
		.button{ color:#fff; font-size:16px; background:#0C3; border-radius:5px; padding:12px 0; text-align:center; display:block; margin:20px; -webkit-appearance:none; border:none; text-decoration:none;}
		.failMsg{ padding:15px; margin:20px; background:#FFC; text-align:left; color:red;}
    </style>
    <script type="text/javascript">
    	function call(){
        	var mobile = $('input[name="mobile"]').val();
        	if(!mobile){
            	return;
            }
        	var patrn = /^0?(13[0-9]|15[0123456789]|18[0123456789]|14[0123456789])[0-9]{8}$/;
        	if (!patrn.exec($.trim(mobile))) {
        		alert('请输入正确的手机号码！');
        		return;
        	}
        	$('#form').submit();
        }
	</script>
</head>
<body>
	<div>	
		<div class="payHead">
        	<span class="span1">请正确填写你的手机号码</span><br/>
        </div>	
		<form id="form" action="" method="post" >
			<input style="width:89%;padding:12px 0; text-align:center; margin:20px; text-decoration:none;" type="text" name="mobile" value="">
		</form>
		<div class="" id="payDom">
        	<a href="javascript:void(0);" class="button" onClick="call()" >点击进行激活</a>
        </div>	
	</div>
</body>
</html>