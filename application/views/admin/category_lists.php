<?php $this->load->view('admin/header'); ?>
<div class="main_body">
	<div class="span9 page_message">
		<section id="contents">
			<ul class="tab-nav nav">

			</ul>

			<div class="table-bar">
				<div class="fl">
					<div class="tools">
						<a class="btn" href="/admin/addcategory">新增</a>
						<button class="btn ajax-post confirm" target-form="ids" url="/admin/delmorecategory">删除</button>
					</div>
				</div>
				<!-- 高级搜索 -->
				<div class="search-form fr cf">
					<div class="sleft">
						<input type="text" name="keyword" class="search-input" value="<?php echo $keyword; ?>" placeholder="请输入分类名称">
						<a class="sch-btn" href="javascript:;" id="search" url="/admin/category/<?php echo $cur_page; ?>">
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
								<th>分组</th>
								<th>排序号</th>
								<th>显示</th>
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
								<td><?php echo $v['title']; ?></td>
								<td><?php echo $v['sort']; ?></td>
								<td><?php echo $v['is_show']?'是':'否'; ?></td>
								<td>					
									<a target="_self" href="/admin/editcategory/<?php echo $v['id']; ?>">编辑</a>
									<a class="confirm" href="/admin/delcategory/<?php echo $v['id']; ?>">删除</a>
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