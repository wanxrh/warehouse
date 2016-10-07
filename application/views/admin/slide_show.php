<?php $this->load->view('admin/header'); ?>
<div class="main_body">

	<div class="span9 page_message">
		<section id="contents">
			<ul class="tab-nav nav">

			</ul>

			<div class="table-bar">
				<div class="fl">
					<div class="tools">
						<a class="btn" href="/admin/addslideshow">新增</a>
						<button class="btn ajax-post confirm" target-form="ids" url="/admin/delmoreslide">删除</button>
					</div>
				</div>
				<!-- 高级搜索 -->
				<!-- <div class="search-form fr cf">
					<div class="sleft">
						<input type="text" name="title" class="search-input" value=""
							placeholder="请输入关键字">
						<a class="sch-btn" href="javascript:;" id="search"
							url="http://www.wxphp.com/index.php?s=/addon/Shop/Slideshow/lists/mdm/38%7C56/model/shop_slideshow.html">
							<i class="btn-search"></i>
						</a>
					</div>
				</div> -->
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
								<th>图片</th>
								<th>链接地址</th>
								<th>显示</th>
								<th>排序</th>
								<th>操作</th>
							</tr>
						</thead>

						<!-- 列表 -->
						<tbody>
							<?php foreach($list as $v){ ?>
							<tr>
								<td>
									<input class="ids regular-checkbox" type="checkbox" value="<?php echo $v['id']; ?>" name="ids[]" id="check_<?php echo $v['id']; ?>">
									<label for="check_<?php echo $v['id']; ?>"></label>
								</td>
								<td><?php echo $v['title']; ?></td>
								<td>
									<img src="<?php echo imgUrl( $v['img'] ); ?>" width="50px">
								</td>
								<td><?php echo $v['url']; ?></td>
								<td><?php if($v['is_show']){echo '显示';}else{echo '不显示';}; ?></td>
								<td><?php echo $v['sort']; ?></td>
								<td>
									<a target="_self" href="/admin/editslideshow/<?php echo $v['id']; ?>">编辑</a>
									<a class="confirm" href="/admin/delslide/<?php echo $v['id']; ?>">删除</a>
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