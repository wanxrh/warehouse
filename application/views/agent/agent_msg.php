<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<body class="withFoot">
    <div class="container">
    	<div class="center_header">
        	<img src="<?php echo $headimgurl; ?>"/>
        	<?php echo $nickname; ?>
			<span><a href="<?php echo $focus_url; ?>">&nbsp;&nbsp;推广二维码</a></span>
        </div>
        <?php if(isset($unagent)){ ?>
        <div class="block">
        	<a class="block_a" style="border-bottom:none" href="javascript:;">您好，您尚未获得代理权。</a>
        	<a class="block_a" href="javascript:;">1、点击菜单栏“申请代理”进行申请。</a>
        	<a class="block_a" href="javascript:;">2、直接发送微信消息到“老山圈”公众号，</a>
        	<a class="block_a" href="javascript:;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如“我要做代理，我的电话是XXXXXX”</a>
        	<a class="block_a" href="javascript:;">3、致电全国统一客服电话4000422330</a>
        </div>
        <?php }else{ ?>		
        <div class="center_nav">
        	<a href="/agent/cash">佣金余额：<span style="color:red;font-size:20px;"><?php echo $balance; ?></span>&nbsp元</a>
            <a href="javascript:;">今日关注人数/总数：<span style="color:red;font-size:20px;"><?php echo $today.'/'.$total; ?></span>&nbsp人</a>
        </div>
        一周明细
        <div class="block">
        	<?php if(!$list){ ?>
        	<a class="block_a" href="javascript:;">暂无数据.......</a>
        	<?php }; ?>
        	<?php foreach ($list as $v){ ?>
        	<a class="block_a" href="javascript:;"><?php echo $v['msg'];?></a>
        	<?php }; ?>
        </div>
        <?php }; ?>
    </div>	
</body>
</html>