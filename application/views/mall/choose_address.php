<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<body>
    <div class="container">
    	<div class="address_list">
        	<ul>
             <?php foreach ($address as $v){ ?>
            	<li>
                	<a class="address_item" href="/mall/<?php echo isset($_GET['source'])?'lingyangview/'.$_GET['id']:'confirmorder'  ?>?address_id=<?php echo $v['id'] ?>" title="选择">
                    	<em class="radio_icon">&nbsp;</em>
                    	<p><?php echo $v['region_name']; ?></p>
                    	<p><?php echo $v['address']; ?></p>
                        <p><b><?php echo $v['truename']; ?></b>  <?php echo $v['mobile']; ?></p>
                    </a>
                    <a class="write_icon" href="/mall/addAddress/<?php echo $v['id']; ?>?from=1" title="编辑">&nbsp;</a>
                </li>
                <?php }; ?>
            </ul>
            <a class="add_address" href="/mall/addAddress?from=1"><em class="add_icon">&nbsp;</em>新增收货地址<em class="arrow_right">&nbsp;</em></a>
        </div>
    </div>	
</body>
</html>