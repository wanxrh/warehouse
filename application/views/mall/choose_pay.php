<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<body>
	<!-- 选择支付-->
    <div class="container">
    	<div class="pay_header">
        	
        </div>
    	<div class="choose_pay_type">
            <a href="#" data-paytype='0'><em class="wxpay">&nbsp;</em>微信支付</a>
        	<!-- <a href="#" data-paytype='1'><em class="alipay">&nbsp;</em>支付宝</a>
            <a href="#" data-paytype='2'><em class="tenpay">&nbsp;</em>财付通</a>
            <a href="#" data-paytype='4'><em class="cardpay">&nbsp;</em>银行卡支付</a>
            <a href="#" data-paytype='10'><em class="rechpay">&nbsp;</em>货到付款</a> -->
        </div>
    </div>	
    
    <!-- 支付成功 -->
    <div class="container" style="display:none">
    	<div class="pay_header_success">
        </div>
    	<div class="pay_result">
        	支付成功
        </div>
        <a class="pay_ok_back" href="#">查看订单</a>
    </div>	
    <!-- 支付失败 -->
    <div class="container" style="display:none">
    	<div class="pay_header_fail">
        </div>
    	<div class="pay_result">
        	支付失败
        </div>
        <a class="pay_ok_back" href="#">重新支付</a>
    </div>	
</body>
</html>
<script type="text/javascript">
	$('.choose_pay_type a').each(function(){
		$(this).click(function(){
			var paytype=$(this).attr('data-paytype');//alert(paytype);
			var order_id=<?php echo $order_id ?>;
			var url="/mall/dopay?paytype="+paytype+"&order_id="+order_id;
			$(this).attr('href',url);
		});
	});
</script>

