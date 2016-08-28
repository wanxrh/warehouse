<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/mobile/shop.js"></script>
<body class="withFoot">
    <div class="container">

        <?php if(!$list){ ?>
       		 <div class="empty_container"><p>暂无内容</p></div>
        <?php }else{ ?>
        <!-- 产品追溯 -->
        <div class="order_list">
        	<ul>

                <li>
                	<a style="display:block" href="/product/index/<?php echo $list['id']; ?>">
                	<p class="top">
                    <span class="c"><?php echo $list['type']; ?>-><span class="blue"><?php echo $list['title']; ?></span></span>
                    </p>

                    </a>
                    <div class="goods_item">
                        <div class="info">
                            <?php echo $list['content'];?>
                        </div>
                    </div>
                    <p class="property">
                        <span class="colorless">二维码：</span>
                    </p>
                    <img src="http://pan.baidu.com/share/qrcode?w=100&h=100&url=<?php echo base_url().'product/index?id='.$list['id'];?>" height="100">
                </li>

                
            </ul>
         </div>
        <?php }; ?>
         
        
    </div>	
    <!-- 底部导航 -->
</body>
</html>