<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<body class="withFoot">
    <div class="container">
    	<div class="center_header">
        	<img src="<?php echo $headimgurl; ?>"/>
        	<?php echo $nickname; ?>
        </div>		
        <div class="center_nav">
        	<a href="/mall/myorder">全部订单</a>
            <a href="/mall/unpayorder">待付款</a>
            <a href="/mall/shippingorder">配送中</a>
            <a href="/mall/waitcommentorder">待评价</a>
        </div>
        <div class="block">
            <a class="block_a" href="/mall/coupon">兑换券<em class="arrow_right">&nbsp;</em></a>
            <a class="block_a" href="/mall/gift">礼品<em class="arrow_right">&nbsp;</em></a>
        	<a class="block_a" href="/mall/cart">我的购物车<em class="arrow_right">&nbsp;</em></a>
            <a class="block_a" href="/mall/mycollect">我的收藏<em class="arrow_right">&nbsp;</em></a>
            <a class="block_a block_last" href="/mall/myaddress">我的收货地址<em class="arrow_right">&nbsp;</em></a>
        </div>
    </div>	
    <!-- 底部导航 -->
    <?php $this->load->view('mall/_footer'); ?>
</body>
</html>