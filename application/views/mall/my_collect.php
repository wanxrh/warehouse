<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<body class="withFoot">
    <div class="container">
    	
    	<h6 style="text-align:center; padding-top:10px;">我的收藏</h6>
         <?php if(!$collect){ ?>
       		 <div class="empty_container"><p>暂无收藏</p></div>
        <?php }else{ ?>
        <!-- 收藏 -->
        <div class="order_list">
        	<ul>
        		<?php foreach ($collect as $v){ ?>
                <li>
                	
                    <a class="goods_item" href="/mall/detail/<?php echo $v['id']; ?>">
                        <img src="<?php echo imgUrl($v['cover']); ?>"/>
                        <div class="info">
                            <P class="name"><?php echo $v['title']; ?></P>
                            <!--
                            <p class="property">
                                <span class="colorless">型号</span>
                                <span>红色 34</span>
                            </p>
                            -->
                            <p class="property">
                                <span class="colorless">价格</span>
                                <span class="orange">￥<?php echo $v['price']; ?></span>
                            </p>
                        </div>
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