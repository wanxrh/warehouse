<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<body class="withFoot">
    <div class="container">
    	<div class="address_list">
        	<ul>
             <?php foreach ($address as $v){ ?>
            	<li>
                	<span class="address_item" style="padding-left:10px">
                    	<p><?php echo $v['region_name']; ?></p>
                    	<p><?php echo $v['address']; ?></p>
                        <p><b><?php echo $v['truename']; ?></b>  <?php echo $v['mobile']; ?></p>
                    </span>
                    <a class="write_icon" href="/mall/addaddress/<?php echo $v['id']; ?>" title="编辑">&nbsp;</a>
                </li>
                <?php }; ?>
            </ul>
            <a class="add_address" href="/mall/addaddress"><em class="add_icon">&nbsp;</em>新增收货地址<em class="arrow_right">&nbsp;</em></a>
        </div>
    </div>	
     <!-- 底部导航 -->
    <?php $this->load->view('mall/_footer'); ?>
</body>
</html>