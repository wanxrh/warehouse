<?php $this->load->view('admin/header'); ?>
<div class="main_body">
	<div class="span9 page_message">
		<section id="contents">
			<ul class="tab-nav nav">

			</ul>

			<div class="table-bar">
				<div class="fl">
					<div class="tools">
						<a class="btn" href="/admin/addproduct">新增</a>
						<button class="btn ajax-post confirm" target-form="ids" url="/admin/delmoreproduct">删除</button>
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
								<th>标题</th>
								<th>分类</th>
								<th>排序</th>
								<th>二维码</th>
								<th>操作</th>
							</tr>
						</thead>
						<?php foreach ($list as $v){ ?>
							<tr>
								<td>
									<input class="ids regular-checkbox" type="checkbox" value="<?php echo $v['id']; ?>"
										   name="ids[]" id="check_<?php echo $v['id']; ?>">
									<label for="check_<?php echo $v['id']; ?>"></label>
								</td>
								<td><?php echo $v['title']; ?></td>
								<td><?php echo $v['type']; ?></td>
								<td><?php echo $v['sort']; ?></td>
								<td><img src="http://pan.baidu.com/share/qrcode?w=100&h=100&url=<?php echo base_url().'product/index?id='.$v['id'];?>" height="100"></td>
								<td>
									<a target="_self" href="/product/index/<?php echo $v['id']; ?>">详情</a>
									<a target="_self" href="/admin/editproduct/<?php echo $v['id']; ?>">编辑</a>
									<a class="confirm" href="/admin/delproduct/<?php echo $v['id']; ?>">删除</a>
								</td>
							</tr>
						<?php }; ?>
						<!-- 列表 -->
						<tbody>


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