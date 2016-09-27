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
				<a href="/order">订单列表</a>
			</li>
			<li>订单详情</li>
		</ul>
	</div>
	<div class="g-mnr">
		<ul class="forminfo">
			<li>
				<h3>订单状态</h3>
			</li>
			<li>
				<p>
					订单号：
					<?php echo $order_info['order_sn'] ?></p>
			</li>
			<li>
				<p>
					订单总价：
					<?php echo $order_info['discount'] ?></p>
			</li>

			</ul>
		<br/>
		<ul class="forminfo">
			<li>
				<h3>订单详情</h3>
			</li>
			<li>
				<p>
					商品名称：
					<?php foreach ($goods as $val){ ?>
						<a href="<?php echo goods_url($val['goods_id']); ?>" target="_blank"><?php echo $val['goods_name'] ?></a>
					<?php } ?>
				</p>
			</li>
			<li>
				<p>
					买家名称：
					<?php echo $order_info['buyer_name'] ?></p>
			</li>
			<li>
				<p>
					店铺名称：
					<?php echo $order_info['store_name'] ?></p>
			</li>
			<li>
				<p>
					下单时间：
					<?php if($order_info['add_time'])  echo date('Y-m-d H:i:s',$order_info['add_time']); ?>
				</p>
				<p>
					支付时间：
					<?php  if($order_info['pay_time'])  echo date('Y-m-d H:i:s',$order_info['pay_time']);; ?>
				</p>
				<p>
					发货时间：
					<?php  if($order_info['ship_time'])  echo date('Y-m-d H:i:s',$order_info['ship_time']);; ?>
				</p>
				<p>
					结束时间：
					<?php  if($order_info['finished_time'])  echo date('Y-m-d H:i:s',$order_info['finished_time']); ?>
				</p>
			</li>
		</ul>
		<ul class="forminfo">
			<li>
				<h3>收货人及发货信息</h3>
			</li>
			<li>
				<p>
					收货人姓名：
					<?php echo $order_info['consignee'] ?></p>
			</li>
			<li>
				<p>
					买家留言：
					<?php echo $order_info['postscript'] ?></p>
			</li>
			<li>
				<p>
					所在地区：
					<?php echo $order_info['region_name'] ?></p>
			</li>
			<li>
				<p>
					邮政编码：
					<?php echo $order_info['zipcode'] ?></p>
			</li>
			<li>
				<p>
					电话号码：
					<?php echo $order_info['tel'] ?></p>
			</li>
			<li>
				<p>
					手机号码：
					<?php echo $order_info['mobile'] ?></p>
			</li>
			<li>
				<p>
					详细地址：
					<?php echo $order_info['address'] ?></p>
			</li>
		</ul>
	</div>
	<script type="text/javascript">
		$('.imgtable tbody tr:odd').addClass('odd');
	</script>
</body>
</html>