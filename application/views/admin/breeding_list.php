<?php $this->load->view('admin/header'); ?>
<div class="main_body">
	<div class="span9 page_message">
		<section id="contents">
			<ul class="tab-nav nav">

			</ul>

			<div class="table-bar">
				<div class="fl">
                    <div class="tools">
						<a class="btn" href="/admin/addbreeding">新增</a>
						<button class="btn ajax-post confirm" target-form="ids" url="/admin/delMorebreeding">删除</button>
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
									<input type="checkbox" id="checkAll"
										class="check-all regular-checkbox">
									<label for="checkAll"></label>
								</th>
								<th>编号</th>
								<th>图片</th>
								<th>说明</th>
								<th>商品ID</th>
								<th>倒计时</th>
								<th>添加时间</th>
								<th>操作</th>
							</tr>
						</thead>

						<!-- 列表 -->
						<tbody>
							<?php foreach ($list as $v){ ?>
							<tr>
                                <td width="5%">
									<input class="ids regular-checkbox" type="checkbox" value="<?php echo $v['id']; ?>"
										   name="ids[]" id="check_<?php echo $v['id']; ?>">
									<label for="check_<?php echo $v['id']; ?>"></label>
								</td>
								<td><?php echo $v['id']; ?></td>
								<td><img class="list_img" src="<?php echo imgUrl(explode(',',$v['picture'])[0]); ?>"></td>
								<td><?php echo mb_substr($v['instructions'],0,50,'utf-8'); ?></td>
								<td><?php echo $v['goods_id']; ?></td>
								<td><?php echo date("Y-m-d",$v['outtime']); ?></td>
								<td><?php echo date("Y-m-d",$v['addtime']); ?></td>
								<td>
                                    <a target="_self" href="/admin/editbreeding/<?php echo $v['id']; ?>">编辑</a>
									<a class="confirm" href="/admin/delbreeding/<?php echo $v['id']; ?>">删除</a>
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