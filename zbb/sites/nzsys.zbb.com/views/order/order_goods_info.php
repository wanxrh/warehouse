<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>订单详情</title>
	<link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
	<link href="<?php echo $this->config->item('domain_static'); ?>system/css/common.css" rel="stylesheet" type="text/css" />
	<link href="<?php echo $this->config->item('domain_static'); ?>system/css/style.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>system/js/jquery.js"></script>
</head>

<body>
	<div class="u-bd-tt">
		<span>位置：</span>
		<ul >
			<li>订单管理</li>
			<li>
				<a href="/order/order_goods">订单商品列表</a>
			</li>
			<li>订单商品详情</li>
		</ul>
	</div>
	<div class="g-mnr">

		<ul class="forminfo">
			<li>
				<h3>订单商品详情</h3>
			</li>
			<li>
				<p>
				商品名称：
					<a href="<?php echo goods_url($goods['goods_id']); ?>"><?php echo $goods['goods_name'] ; ?></a>
				</p>
				<p>
				购买属性：
					<a href="javascript:;"><?php echo $goods['specification']; ?></a>
				</p>
			</li>
			<li>
				<p>
					下单时间：
					<?php if($goods['add_time']) echo date('Y-m-d H:i:s',$goods['add_time']) ;?></p>
			</li>
			<li>
				<p>
					支付时间：
					<?php if($goods['pay_time']) echo date('Y-m-d H:i:s',$goods['pay_time']) ;?></p>
			</li>
			<li>
				<p>
					发货时间：
					<?php if($goods['ship_time']) echo date('Y-m-d H:i:s',$goods['ship_time']) ;?></p>
			</li>
			<li>
				<p>
					结束时间：
					<?php if($goods['finished_time']) echo date('Y-m-d H:i:s',$goods['finished_time']) ;?></p>
			</li>

			<li>
				<p>
					预计自动收货时间：
					<?php if($goods['auto_comfirm_time']) echo date('Y-m-d H:i:s',$goods['auto_comfirm_time']) ;?></p>
			</li>
			
		</ul>
		<ul class="forminfo">
			<li>
				<h3>操作日志</h3>
			</li>
		</ul>
		<div class="cont">
			<?php if(isset($log_arr)){?>
				<?php foreach ($log_arr as $v){?>
					<div class="lst">
						<div class="info">
							<p>
								<span><?php echo date('Y-m-d H:i:s',$v['node_time']);?></span>
							</p>
							<p><span><?php echo $v['node'];?><span></p>
							<p>
								<?php foreach (explode(',',$v['proof']) as $m){?>
									<img src="<?php echo $m;?>" width="100" height="100">
								<?php }?>
							</p>
							<p><span>补充说明：<?php echo $v['supplement'];?><span></p>
						</div>
					</div>
				<?php }?>
			<?php }?>
		</div>
	</div>
	<script type="text/javascript">
		$('.imgtable tbody tr:odd').addClass('odd');
	</script>
</body>
</html>