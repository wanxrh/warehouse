<?php $this->load->view('admin/header'); ?>
<div class="main_body">

	<div class="span9 page_message">
		<section id="contents">
			<ul class="tab-nav nav">

			</ul>

			<div class="table-bar">
				<div class="fl">
					<div class="tools">
						<a class="btn" href="/admin/setfinish">确认收货超时处理</a>
					</div>
				</div>
				<!-- 高级搜索 -->
				<div class="search-form fr cf">
					<div class="sleft">
						<input type="text" name="keyword" class="search-input" value="<?php echo $keyword; ?>" placeholder="请输入订单编号 或 客户昵称">
						<a class="sch-btn" href="javascript:;" id="search" url="/admin/order">
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
								<th width="15%">订单编号</th>
								<th width="20%">下单商品</th>
								<th width="10%">客户</th>
								<th width="7%">总价</th>
								<th width="17%">下单时间</th>
								<th width="10%">支付类型</th>
								<th width="10%">订单跟踪</th>
								<th width="11%">操作</th>
							</tr>
						</thead>

						<!-- 列表 -->
						<tbody>
							<?php foreach($list as $v){ ?>
							<tr>
								<td>
									<a href="/admin/orderdetail/<?php echo $v['id']; ?>"><?php echo $v['order_number'] ?></a>
								</td>
								<td>
									<?php foreach($v['goods_datas'] as $goods){ ?>
									<img width="50" style="vertical-align: middle; margin: 0 10px 0 0" src="<?php echo imgUrl($goods['cover']); ?>" /> <?php echo $goods['title'] ?>
									<?php }; ?>
								</td>
								<td><?php echo $v['username']; ?></td>
								<td><?php echo $v['total_price']; ?></td>
								<td><?php echo date('Y-m-d H:i',$v['cTime']); ?></td>
								<td><?php echo $v['pay_type_name']; ?></td>
								<td><?php echo $v['status_code_name']; ?></td>
								<td>
									<a href="/admin/orderdetail/<?php echo $v['id'] ?>">详情</a>
									<?php if($v['status_code'] == 1){ ?>
									<br><br>
									<a href="/admin/setconfirm/<?php echo $v['id'] ?>">商家确认</a>
									<?php }; ?>
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
<?php $this->load->view('admin/footer'); ?>