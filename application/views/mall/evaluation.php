<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<link href="<?php echo $this->config->base_url(); ?>static/css/mall/public/shop.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/mobile/shop.js"></script>
<body class="withFoot">
    <div class="container">
    	<a href="/mall/detail/<?php echo $goods_id; ?>" class="back_icon">&nbsp;</a>
    	<div class="top_tab">
        	<a href="/mall/evaluation/<?php echo $goods_id; ?>?type=2" <?php if($type ==2){ ?>class="current"<?php }; ?>>好&nbsp;&nbsp;评</a>
            <a href="/mall/evaluation/<?php echo $goods_id; ?>?type=1" <?php if($type ==1){ ?>class="current"<?php }; ?>>中&nbsp;&nbsp;评</a>
            <a href="/mall/evaluation/<?php echo $goods_id; ?>?type=0" <?php if($type ==0){ ?>class="current"<?php }; ?>>差&nbsp;&nbsp;评</a>
        </div>
    	
        <?php if(!$list){ ?>
       		 <div class="empty_container"><p>暂无评价</p></div>
        <?php }else{ ?>
        <!-- 订单信息 -->
        <div class="order_list">
        	<ul>
            	<?php foreach ($list as $v){ ?>
                <li>
                          
                    <span class="t">买&nbsp;&nbsp;家：<?php echo $v['user_name']; ?></span><br/>
                    <span class="c">内&nbsp;&nbsp;容：<span class="blue"><?php echo $v['msg']; ?></span></span>
                             	
                </li>
                <?php }; ?>
                
            </ul>
         </div>
        <?php }; ?>
         
        
    </div>	
    
</body>
</html>