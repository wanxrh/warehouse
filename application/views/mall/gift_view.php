<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/css/mall/public/shop.css"></script>
<body class="withFoot">
    <div class="container">
    	<div class="order_detail">

    	<div class="order">

        	<img src="<?php echo imgUrl($gift['cover']); ?>"/>
            <p class="info">
            	<?php echo $gift['title']; ?>
                <br/>数量：<?php echo $gift['number']; ?>
                <br/>价值:<?php echo $gift['price']*$gift['number']; ?>元
            </p>
            <br />
        </div>

         <div class="order_action">
        	
        		<?php if($gift['status'] == 1){ ?>
                    <h3 class="mb_10">礼品券未使用...</h3>
                	<p class="wait_pay"></p>
                    <div class="m_15">
                        <img src="<?php echo $confirm_gift_url; ?>"/>
                    </div>
                <?php }else{ ?>
                     <h3 class="mb_10">礼品券已经使用</h3>
                <?php }; ?>
            
        </div>
         
        </div>
    </div>	
    <!-- 底部导航 -->
    <?php $this->load->view('mall/_footer'); ?>
</block>
</body>
</html>