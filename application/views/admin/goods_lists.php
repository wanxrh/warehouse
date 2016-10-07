<?php $this->load->view('admin/header'); ?>
<div class="main_body">
	<div class="span9 page_message">
		<section id="contents">
			<ul class="tab-nav nav">

			</ul>

			<div class="table-bar">
				<div class="fl">
					<div class="tools">
						<a class="btn" href="/admin/addgoods">新增</a>
						<button class="btn ajax-post confirm" target-form="ids" url="/admin/delmore">删除</button>
					</div>
				</div>
				<!-- 高级搜索 -->
				<div class="search-form fr cf">
					<div class="sleft">
						<input type="text" name="keyword" class="search-input" value="<?php echo $keyword; ?>" placeholder="请输入商品名称">
						<a class="sch-btn" href="javascript:;" id="search" url="/admin/index/<?php echo $cur_page; ?>">
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
									<input type="checkbox" id="checkAll"
										class="check-all regular-checkbox">
									<label for="checkAll"></label>
								</th>
								<th>编号</th>
								<th>商品分类</th>
								<th>封面图</th>
								<th>商品名称</th>
								<th>价格</th>
								<th>库存量</th>
								<th>销售量</th>
								<th>排序</th>
								<th>是否上架</th>
								<th>操作</th>
							</tr>
						</thead>

						<!-- 列表 -->
						<tbody>
							<?php foreach ($list as $v){ ?>
							<tr>
								<td>
									<input class="ids regular-checkbox" type="checkbox" value="<?php echo $v['id']; ?>"
										name="ids[]" id="check_<?php echo $v['id']; ?>">
									<label for="check_<?php echo $v['id']; ?>"></label>
								</td>
								<td><?php echo $v['id']; ?></td>
								<td><?php echo $v['gtitle']; ?></td>
								<td>
									<img class="list_img" src="<?php echo imgUrl($v['cover']); ?>">
								</td>
								<td><?php echo $v['title']; ?></td>
								<td><?php echo $v['price']; ?></td>
								<td><?php echo $v['inventory']; ?></td>
								<td><?php echo $v['sale_count']; ?></td>
								<td><?php echo $v['sort']; ?></td>
								<td><?php if($v['is_show']){echo '是';}else{echo '否';}; ?></td>
								<td>
									<a target="_self" href="/admin/setshow/<?php echo $v['id']; ?>">改变上架状态</a>
									<a target="_self" href="/admin/editgoods/<?php echo $v['id']; ?>">编辑</a>
									<a class="confirm" href="/admin/del/<?php echo $v['id']; ?>">删除</a>
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