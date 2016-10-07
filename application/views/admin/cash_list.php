<?php $this->load->view('admin/header'); ?>
<div class="main_body">

	<div class="span9 page_message">
		<section id="contents">
			<ul class="tab-nav nav">

			</ul>

			<div class="table-bar">
				<div class="fl">
					<div class="tools">
						<form action="/admin/cash" method="get">
							<select name="status">
								<option value="0">请选择</option>
								<option <?php if($status == 1){ echo 'selected' ;} ?> value="1">申请中</option>
								<option <?php if($status == 2){ echo 'selected' ;} ?> value="2">已完成</option>
							</select>
							<input type="submit" class="btn" >
						</form>
					</div>
				</div>
			</div>
			<!-- 数据列表 -->
			<div class="data-table">
				<div class="table-striped">
					<table cellspacing="1">
						<!-- 表头 -->
						<thead>
							<tr>
								<th>微信ID</th>
								<th>申请日期</th>
								<th>提现金额</th>
								<th>支付宝</th>
								<th>状态</th>
								<th>操作</th>
							</tr>
						</thead>

						<!-- 列表 -->
						<tbody>
							<?php foreach($list as $v){ ?>
							<tr>
								<td><?php echo $v['openid']; ?></td>
								<td><?php echo date('Y-m-d H:i',$v['apply_time']); ?></td>
								<td><?php echo $v['apply_money']; ?></td>
								<td><?php echo $v['alipay']; ?></td>
								<td><?php if($v['status'] == 1){echo '申请中';}elseif ($v['status'] == 2){echo '成功';}; ?></td>
								<td>
									<?php if($v['status'] == 1){ ?>
									<a target="_self" href="/admin/finishcash/<?php echo $v['id']; ?>">确认提现</a>
									<?php }; ?>
								</td>
							</tr>
							<?php }; ?>
						</tbody>
					</table>
				</div>
			</div>
			<div class="page"></div>
		</section>
	</div>

</div>
</div>
<?php $this->load->view('admin/footer'); ?>