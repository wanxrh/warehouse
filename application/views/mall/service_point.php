<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/mobile/shop.js"></script>
<body class="withFoot">
    <div class="container">

        <?php if(!$list){ ?>
       		 <div class="empty_container"><p>暂无服务点</p></div>
        <?php }else{ ?>
        <!-- 信息 -->
        <div class="order_list">
        	<ul>
            	<?php foreach ($list as $value){ ?>
                <li>
                	<a style="display:block" href="/mall/serviceinfo/<?php echo $value['id']; ?>">
                	<p class="top">
                    <span class="c">服务点：<span class="blue"></span></span><br/>
                    <?php if($value['latitude']){ ?>
                        <span class="t" style="color: red;"><?php echo $value['provinces'].'-'.$value['city'].'-'.$value['county'].'&nbsp;&nbsp;&nbsp;'.$value['address'];?></span><a href="/mall/serviceinfo/<?php echo $value['id']; ?>">点击查看详情</a>
                    <?php }; ?>
                    </p>
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