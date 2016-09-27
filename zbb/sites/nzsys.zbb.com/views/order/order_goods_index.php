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
		<script type="text/javascript">
			$(document).ready(function () {
				$(".click").click(function () {
					$(".tip").fadeIn(200);
				});

				$(".tiptop a").click(function () {
					$(".tip").fadeOut(200);
				});

				$(".sure").click(function () {
					$(".tip").fadeOut(100);
				});

				$(".cancel").click(function () {
					$(".tip").fadeOut(100);
				});

			});
		</script>


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
				<form method="get" id="form" action="/order/order_goods">

					<select name="field">
						<option value="seller_name" <?php echo $this->input->get('field', TRUE) == 'seller_name' ? 'selected' : ''; ?>>店铺名称</option>
						
						<option value="order_sn" <?php echo $this->input->get('field', TRUE) == 'order_sn' ? 'selected' : ''; ?>>订单号</option>
					</select>
					 
					<input type="text" class="dfinput" style="width:120px;" value="<?php echo $this->input->get('search_name', TRUE); ?>" name="search_name">
                    
                  
                     
                            
                    
						<span class="order_statius">商品状态<img src="<?php echo $this->config->item('domain_static'); ?>system/images/uew_icon.png"></span>
							<div class="status_choose">
								 <label><input type="checkbox" name="status[]" value="11" <?php echo in_array('11', $status_arr) ? 'checked' : ''; ?>>待付款</label>
								 <label><input type="checkbox" name="status[]" value="21" <?php echo in_array('21', $status_arr) ? 'checked' : ''; ?>>待发货</label>
								 <label><input type="checkbox" name="status[]" value="31" <?php echo in_array('31', $status_arr) ? 'checked' : ''; ?>>待收货</label>
								 <label><input type="checkbox" name="status[]" value="41" <?php echo in_array('41', $status_arr) ? 'checked' : ''; ?>>已完成</label>
								 <label><input type="checkbox" name="status[]" value="50" <?php echo in_array('50', $status_arr) ? 'checked' : ''; ?>>退款中</label>
								 <label><input type="checkbox" name="status[]" value="51" <?php echo in_array('51', $status_arr) ? 'checked' : ''; ?>>退款成功</label>
								 <label><input type="checkbox" name="status[]" value="60" <?php echo in_array('60', $status_arr) ? 'checked' : ''; ?>>退货中</label>
								 <label><input type="checkbox" name="status[]" value="61" <?php echo in_array('61', $status_arr) ? 'checked' : ''; ?>>退货成功</label>
							     <label><input type="checkbox" name="status[]" value="0" <?php echo in_array('0', $status_arr) ? 'checked' : ''; ?>>已取消</label>
							</div>

									金额：<?php echo $total?$total:0; ?>	
										<input type="submit" class="u-btn" style="width:70px;" value="查询">
									
											<a href="javascript:" id="click_xls" class="u-btn" style="width:60px;">导出xls</a> 
											</form>

											</div>

											<table class="tablelist">

												<thead>
													<tr>
														<th><input name="" type="checkbox" value="" checked="checked"/></th>
														<th>编号</th>
														<th>订单号</th>
														<th>店铺名称</th>
														<th>商品名称</th>
														<th>尺码颜色</th>
														<th>价格*数量</th>
														<th>商品状态</th>
														<th>操作</th>
													</tr>
												</thead>

												<tbody>
													<?php foreach ($list as $item): ?>
														<tr>
															<td><input type="checkbox" class="checkitem" value="<?php echo $item['order_id'] ?>" /></td>
															<td><?php echo $item['rec_id'] ?></td>
															<td><?php echo $item['order_sn'] ?></td>
															<td><?php echo $item['store_name'] ?></td>
															<td width="480"><?php echo $item['goods_name'] ?></td>
															<td><?php echo $item['specification'];?></td>
															<td><?php echo $item['price'].'*'.$item['quantity'] ;?></td>
															<?php $temp=order_goods_status_name();?>
															<td><?php echo $temp[$item['order_goods_status']]; ?></td>
															<td><a href="/order/goods_info?id=<?php echo $item['rec_id']; ?>">查看</a></td>
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

													$('#add_time_from,#pay_time_from').focus(function () {
														WdatePicker({
															skin: 'whyGreen',
															dateFmt: 'yyyy-MM-dd',
															maxDate: '#F{$dp.$D(\'add_time_to\');}'
														});
													});
													$('#add_time_to,#pay_time_to').focus(function () {
														WdatePicker({
															skin: 'whyGreen',
															dateFmt: 'yyyy-MM-dd',
															minDate: '#F{$dp.$D(\'add_time_from\');}'
														});
													});
												});
												$('#finished_time_from').focus(function () {
													WdatePicker({
														skin: 'whyGreen',
														dateFmt: 'yyyy-MM-dd',
														maxDate: '#F{$dp.$D(\'finished_time_to\');}'
													});
												});
												$('#finished_time_to').focus(function () {
													WdatePicker({
														skin: 'whyGreen',
														dateFmt: 'yyyy-MM-dd',
														minDate: '#F{$dp.$D(\'finished_time_from\');}'
													});
												});
											

												$("#click_xls").click(function () {
													$("#form").attr("action", "/order/export_xls");
													$("#form").submit();
													$("#form").attr("action", "/order/order_goods");
												});

												$(".order_statius").click(function(){
													$(".status_choose").show();
												});
												$(".status_choose").mouseleave(function(){
													$(this).hide();
												});

											</script>