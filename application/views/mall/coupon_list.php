<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/mobile/shop.js"></script>
<body class="withFoot">
    <div class="container">

        <?php if(!$list){ ?>
       		 <div class="empty_container"><p>暂无代金券</p></div>
        <?php }else{ ?>
        <!-- 订单信息 -->
        <div class="order_list">
        	<ul>
            	<?php foreach ($list as $value){ ?>
                <li>
                	<a style="display:block" href="/mall/coupondetail/<?php echo $value['coupon_id']; ?>">
                	<p class="top">
                    <span class="c">代金券状态：<span class="blue"><?php echo $value['status']; ?></span></span>
                    </p>
                    
                    <?php foreach ($value['goods_datas'] as $goods){ ?>
                    <div class="goods_item">
                        <img src="<?php echo imgUrl($goods['cover']); ?>"/>
                        <div class="info">
                            <P class="name"><?php echo $goods['title']; ?></P>
                            <p class="property">
                                <span class="colorless">价格</span>
                                <span class="orange">￥<?php echo $goods['price']; ?>元</span>                              
                            </p>
                            <p class="property">
                                <span class="colorless">数量</span>
                                <span><?php echo $goods['num']; ?></span>
                            </p>
                        </div>
                    </div>
                    <?php }; ?>
                    </a>

                </li>
                <?php }; ?>
                
            </ul>
         </div>
        <?php }; ?>
         
        
    </div>	
    <!-- 底部导航 -->
    <?php $this->load->view('mall/_footer'); ?>
</body>
</html>