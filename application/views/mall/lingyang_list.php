<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/mobile/shop.js"></script>
<body class="withFoot">
    <div class="container">

        <?php if(!$list){ ?>
       		 <div class="empty_container"><p>暂无领养</p></div>
        <?php }else{ ?>
        <!-- 订单信息 -->
        <div class="order_list">
        	<ul>
            	<?php foreach ($list as $value){ ?>
                <li>
                	<a style="display:block" href="/mall/lingyangview/<?php echo $value['id']; ?>">
                	<p class="top">
                        <span class="t">领养编号：<?php echo $value['order_number']; ?></span><br/>
                    <?php if($value['status_code'] == 0){ ?>
                        <span class="c">状态：<span class="blue"><?php echo $value['status_code_name']; ?></span></span><br/>
                    <?php }else{ ?>
                        <?php if($value['reserve_time'] > time()){ ?>
                            <span class="t" style="color: red;"><?php echo date('Y-m-d H:i:s',$value['reserve_time']).'后可认领'; ?></span>
                        <?php }else{ ?>
                            <span class="c">状态：<span class="blue"><?php echo $value['status_code_name']; ?></span></span><br/>
                        <?php }; ?>
                    <?php }; ?>
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
                                <span class="colorless">领养数</span>
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