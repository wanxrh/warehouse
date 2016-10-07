<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/mobile/shop.js"></script>
<body class="withFoot">
    <div class="container">
    	<div class="top_tab">
        	<a href="/mall/myorder" class="<?php echo isset($allClass)?$allClass:''; ?>">全部订单</a>
            <a href="/mall/unpayorder" class="<?php echo isset($unPayClass)?$unPayClass:''; ?>">待付款</a>
            <a href="/mall/shippingorder" class="<?php echo isset($shippingClass)?$shippingClass:''; ?>">配送中</a>
            <a href="/mall/waitcommentorder" class="<?php echo isset($waitClass)?$waitClass:''; ?>">待评价</a>
        </div>
    	
        <?php if(!$order_list){ ?>
       		 <div class="empty_container"><p>暂时无订单数据</p></div>
        <?php }else{ ?>
        <!-- 订单信息 -->
        <div class="order_list">
        	<ul>
            	<?php foreach ($order_list as $order){ ?>
                <li>
                	<a style="display:block" href="/mall/orderdetail/<?php echo $order['id']; ?>">
                	<p class="top">
                    <span class="t">订单编号：<?php echo $order['order_number']; ?></span><br/>
                    <span class="c">订单状态：<span class="blue"><?php echo $order['status_code_name']; ?></span></span><br/>
                    <?php if($order['reserve']){ ?>
                    <span class="t" style="color: red;"><?php echo '此订单为预付订单，商品于'.date('Y-m-d',$order['reserve_time']).'后发货或自提' ?></span>
                    <?php }; ?>
                    </p>
                    
                    <?php foreach ($order['goods_datas'] as $goods){ ?>
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
                        <?php if(isset($goods['evaluation']) ){ ?>
                        <div style="float: right; margin: -40px 20px">
                         	<a href="/mall/orderdetail/<?php echo $order['id']; ?>">已评价</a>
                        </div>
                        <?php }; ?>
                        <?php if(!isset($goods['evaluation']) && in_array($order['status_code'], array(4,5)) ){ ?>
                        <div style="float: right; margin: -40px 20px">
                         	<a class="btn small_btn" href="/mall/orderdetail/<?php echo $order['id']; ?>">评价</a>
                        </div>
                        <?php }; ?>                        
                    </div>
                    <?php }; ?>
                    </a>
                    <div class="order_list_bottom">
                    	<?php if($order['pay_status'] ==0 && $order['pay_type'] !=10 ){ ?>
                             <a class="btn small_btn" href="/mall/choosepay?order_id=<?php echo $order['id']; ?>">立即付款</a>
                        <?php }else{ ?>
                            <?php if($order['is_send'] ==0){ ?>
                                <span>等待卖家发货</span>
                            <?php }else{ ?>
                            	<?php if($order['status_code'] ==3){ ?>
                                <a class="btn small_btn" href="javascript:;" onClick="confirmGetGoods('/mall/confirmGetGoods/<?php echo $order['id']; ?>');">确认收货</a>
                                <?php }; ?>
                            <?php }; ?>
                        <?php }; ?>
                    	
                    </div>
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