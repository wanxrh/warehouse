<?php $this->load->view('admin/header'); ?>
<div class="main_body">
	<div class="span9 page_message">
		<section id="contents">
			<ul class="tab-nav nav">

			</ul>

			<div class="table-bar">
				<div class="fl">
					<div class="tools">
						<a class="btn"  id="addqr" href="javascript:;">新增</a>
						<!-- <button class="btn ajax-post confirm" target-form="ids" url="/admin/delmoreqrcode">删除</button> -->
					</div>
				</div>
				<!-- 高级搜索 -->
				<div class="search-form fr cf">
					<div class="sleft">
						<input type="text" name="mobile" class="search-input" value="<?php echo $mobile; ?>" placeholder="请输入手机号码">
						<a class="sch-btn" href="javascript:;" id="search" url="/admin/qrcode">
							<i class="btn-search"></i>
						</a>
					</div>
				</div>
				<!-- 多维过滤 -->
			</div>
			<!-- 数据列表 -->
			<div class="data-table">
				<div class="table-striped">
					<table cellspacing="1">
						<!-- 表头 -->
						<thead>
							<tr>
								<th class="row-selected row-selected">
									<input type="checkbox" id="checkAll" class="check-all regular-checkbox">
									<label for="checkAll"></label>
								</th>
								<th>编号</th>
								<th>微信ID</th>
								<th>手机号码</th>
								<th>余额</th>
								<th>代理时间</th>
								<th>操作</th>
							</tr>
						</thead>

						<!-- 列表 -->
						<tbody>
							<?php foreach ($list as $v){ ?>
							<tr>
								<td>
									<input class="ids regular-checkbox" type="checkbox" value="<?php echo $v['id']; ?>" name="ids[]" id="check_<?php echo $v['id']; ?>">
									<label for="check_<?php echo $v['id']; ?>"></label>
								</td>
								<td><?php echo $v['id']; ?></td>
								<td><?php echo $v['openid']; ?></td>
								<td><?php echo $v['mobile']?$v['mobile']:''; ?></td>
								<td><?php echo $v['balance']; ?></td>
								<td><?php echo $v['agenttime']?date('Y-m-d H:i',$v['agenttime']):''; ?></td>
								<td>
									<a target="_self" href="/admin/bill/<?php echo $v['openid']; ?>">账单</a>
									<a target="_self" href="/admin/viewqrcode/<?php echo $v['id']; ?>">查看</a>
									<!-- <a class="confirm" href="/admin/delqrcode">删除</a> -->
								</td>
							</tr>
							<?php }; ?>
						</tbody>
					</table>
				</div>
			</div>
			<div class="page"><?php echo $page; ?></div>
		</section>
	</div>
</div>
</div>
<script>
	$('#addqr').click(function(){
		if(confirm('将会生成一个未激活的代理二维码？')){
			location.href="/admin/addqrcode";
		}
	});
</script>
<?php $this->load->view('admin/footer'); ?>