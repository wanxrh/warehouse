<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>订单列表</title>
		<link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
		<link href="<?php echo $this->config->item('domain_static'); ?>system/css/common.css" rel="stylesheet" type="text/css" />
		<link href="<?php echo $this->config->item('domain_static'); ?>system/css/style.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>system/js/jquery.js"></script>
		<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>common/js/My97DatePicker/WdatePicker.js" charset="utf-8"></script>
	</head>

	<body>
		<div class="u-bd-tt">
			<span>位置：</span>
			<ul >
				<li>订单管理</li>
				<li><a href="/order">订单列表</a></li>
			</ul>
		</div>

		<div class="g-mnr">
			<div class="tools">
				<form method="get" id="form" action="/order/index">

					<select name="field">
						<option value="0" >订单条件</option>
						<option value="seller_name" <?php echo $this->input->get('field', TRUE) == 'seller_name' ? 'selected' : ''; ?>>店铺名称</option>
						<option value="buyer_name" <?php echo $this->input->get('field', TRUE) == 'buyer_name' ? 'selected' : ''; ?>>买家名称</option>
						<option value="order_sn" <?php echo $this->input->get('field', TRUE) == 'order_sn' ? 'selected' : ''; ?>>订单号</option>
					</select>
					
					<input type="text" class="dfinput" style="width:120px;" value="<?php echo $this->input->get('search_name', TRUE); ?>" name="search_name">
						<select name="order_status">
							<option value="0" >支付状态</option>
							<option value="1" <?php echo $this->input->get('order_status', TRUE) == 1 ? 'selected' : ''; ?>>已支付</option>
							<option value="2" <?php echo $this->input->get('order_status', TRUE) == 2 ? 'selected' : ''; ?>>未支付</option>
						</select>
                                            <select name="payment_id">
												<option value="0" >支付方式</option>
												<?php foreach ($payment as $k => $m):?>
												<option value="<?php echo $m['payment_id']?>" <?php echo $this->input->get('payment_id', TRUE) == $m['payment_id'] ? 'selected' : ''; ?>><?php echo $m['payment_name']?></option>
												<?php endforeach;?>
				            				</select>
						下单时间:
						<input id="add_time_from" class="dfinput" style="width:80px;" type="text" name="add_time_from" value="<?php echo $this->input->get('add_time_from', TRUE); ?>">
							至:
							<input id="add_time_to" class="dfinput" style="width:80px;" type="text" name="add_time_to" value="<?php echo $this->input->get('add_time_to', TRUE); ?>">
						付款时间:
						<input id="pay_time_from" class="dfinput" style="width:80px;" type="text" name="pay_time_from" value="<?php echo $this->input->get('pay_time_from', TRUE); ?>">
							至:
							<input id="pay_time_to" class="dfinput" style="width:80px;" type="text" name="pay_time_to" value="<?php echo $this->input->get('pay_time_to', TRUE); ?>">
								金额:
								<input type="text" class="dfinput" style="width:70px;" name="order_amount_from" value="<?php echo $this->input->get('order_amount_from', TRUE); ?>">
									至:
									<input type="text" class="dfinput" style="width:70px;" name="order_amount_to" value="<?php echo $this->input->get('order_amount_to', TRUE); ?>" style="width:60px;">
										<input type="submit" class="u-btn" style="width:70px;" value="查询">
											总金额:￥<b style="color:#F0F;"><?php echo $total['order_amount']; ?></b>
											<a href="javascript:" id="click_xls" class="u-btn" style="width:60px;">导出xls</a>
											</form>

											</div>

											<table class="tablelist">

												<thead>
													<tr>
														<th><input name="" type="checkbox" value="" checked="checked"/></th>
														<th>编号</th>
														<th>店铺名称</th>
														<th>订单号</th>
														<th>下单时间</th>
														<th>买家名称</th>
														<th>支付方式</th>
														<th>订单总价</th>
														<th>支付状态</th>
														<th>操作</th>
													</tr>
												</thead>

												<tbody>
													<?php foreach ($list as $item): ?>
														<tr>
															<td><input type="checkbox" class="checkitem" value="<?php echo $item['order_id'] ?>" /></td>
															<td><?php echo $item['order_id'] ?></td>
															<td><?php echo $item['store_name'] ?></td>
															<td><?php echo $item['order_sn'] ?></td>
															<td><?php echo date('Y-m-d H:i:s',$item['add_time']); ?></td>
															<td><?php echo $item['buyer_name']; ?></td>
															<td><?php echo $item['pay_time']?$item['payment_name']:''; ?></td>
															<td  class="total"><?php echo $item['order_amount'] ?></td>
															<td><?php echo $item['pay_time']?'已支付：'.date('Y-m-d H:i:s',$item['add_time']):'未支付'; ?></td>
															<td><a href="/order/info?id=<?php echo $item['order_id'] ?>&buyer_id=<?php echo $item['buyer_id'] ?>">查看</a></td>
														</tr>
													<?php endforeach; ?>
												</tbody>

											</table>

											<div class="pagin">  	
												<ul class="paginList">
													<?php echo $page; ?>  
												</ul>
											</div>


											</div>

											<div class="tip">
												<div class="tiptop"><span>提示信息</span><a></a></div>

												<div class="tipinfo">
													<span><img src="images/ticon.png" /></span>
													<div class="tipright">
														<p>是否确认对信息的修改 ？</p>
														<cite>如果是请点击确定按钮 ，否则请点取消。</cite>
													</div>
												</div>

												<div class="tipbtn">
													<input name="" type="button"  class="sure" value="确定" />&nbsp;
													<input name="" type="button"  class="cancel" value="取消" />
												</div>

											</div>

											<script type="text/javascript">
												$('.tablelist tbody tr:odd').addClass('odd');
											</script>

											</body>

											</html>
											<script type="text/javascript">


												$(function () {

													$('#add_time_from').focus(function () {
														WdatePicker({
															skin: 'whyGreen',
															dateFmt: 'yyyy-MM-dd',
															maxDate: '#F{$dp.$D(\'add_time_to\');}'
														});
													});
													$('#add_time_to').focus(function () {
														WdatePicker({
															skin: 'whyGreen',
															dateFmt: 'yyyy-MM-dd',
															minDate: '#F{$dp.$D(\'add_time_from\');}'
														});
													});
													$('#pay_time_from').focus(function () {
														WdatePicker({
															skin: 'whyGreen',
															dateFmt: 'yyyy-MM-dd',
															maxDate: '#F{$dp.$D(\'pay_time_to\');}'
														});
													});
													$('#pay_time_to').focus(function () {
														WdatePicker({
															skin: 'whyGreen',
															dateFmt: 'yyyy-MM-dd',
															minDate: '#F{$dp.$D(\'pay_time_from\');}'
														});
													});
												});

												$("#click_xls").click(function () {
													$("#form").attr("action", "/order/exportxls");
													$("#form").submit();
													$("#form").attr("action", "/order/index");
												});

												$(".order_statius").click(function(){
													$(".status_choose").show();
												});
												$(".status_choose").mouseleave(function(){
													$(this).hide();
												});

											</script>