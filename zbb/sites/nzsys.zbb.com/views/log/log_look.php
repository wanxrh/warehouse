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
				<form method="get" id="form" action="/logs/look">
					用户编号：
					<input type="text" class="dfinput" style="width:120px;" value="<?php echo $this->input->get('op_uid', TRUE); ?>" name="op_uid">
						操作时间:
						<input id="add_time_from" class="dfinput" style="width:80px;" type="text" name="add_time_from" value="<?php echo $this->input->get('add_time_from', TRUE); ?>">
							至:
							<input id="add_time_to" class="dfinput" style="width:80px;" type="text" name="add_time_to" value="<?php echo $this->input->get('add_time_to', TRUE); ?>">
										<input type="submit" class="u-btn" style="width:70px;" value="查询">
											</form>

											</div>

											<table class="tablelist">

												<thead>
													<tr>
														<th>编号</th>
														<th>操作名称</th>
														<th>用户编号</th>
														<th>时间</th>
														<th>ip</th>
													</tr>
												</thead>

												<tbody>
													<?php foreach ($list as $item): ?>
														<tr>
															<td><?php echo $item['log_id'] ?></td>
															<td><?php echo $item['action_name'] ?></td>
															<td><?php echo $item['op_uid'] ?></td>
															<td><?php echo date('Y-m-d H:i:s',$item['dateline']); ?></td>
															<td><?php echo long2ip($item['ip']) ?></td>
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