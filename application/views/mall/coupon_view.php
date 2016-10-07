<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/css/mall/public/shop.css"></script>
<body class="withFoot">
    <div class="container">
    	<div class="order_detail">

    	<div class="order">
            <?php foreach ($goods_datas as $v){ ?>
        	<img src="<?php echo imgUrl($v['cover']); ?>"/>
            <p class="info">
            	<?php echo $v['title']; ?>
                <br/>数量：<?php echo $v['num']; ?>
                <br/>价值:<?php echo $v['price']*$v['num']; ?>元
            </p>
            <br />
            <?php }; ?>
        </div>
        
        <div class="order_adress">
        	<p class="info">
            	收件人：<?php echo $address_info['truename']; ?><br/>
                联系方式：<?php echo $address_info['mobile']; ?><br/>
                收货地址：<?php echo $address_info['region_name'].' '.$address_info['address']; ?><br/>
            </p>
        </div>
         <div class="order_action">
        	
        		<?php if($coupon['status'] == 0){ ?>
                    <h3 class="mb_10">兑换券未使用...</h3>
                	<p class="wait_pay"></p>
                    <div class="m_15">
                        <img src="<?php echo $confirm_coupon_url; ?>"/>
                    </div>
                    <a href="<?php echo $this->config->base_url().'coupon/share?id='.$coupon['coupon_id'].'&time='.$now.'&sign='.md5($coupon['sign'].$coupon['coupon_id'].$now); ?>" class="btn">赠送好友</a>
                <?php }elseif ($coupon['status'] == 1){ ?>
                     <h3 class="mb_10">兑换券已经使用</h3>
                <?php }elseif ($coupon['status'] == 2){ ?>
                    <h3 class="mb_10">兑换券已赠送好友</h3>
                <?php }; ?>
            
        </div>
         
        </div>
    </div>	
    <!-- 底部导航 -->
    <?php $this->load->view('mall/_footer'); ?>
</block>
</body>
</html>