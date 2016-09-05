<?php $this->load->view('admin/header'); ?>
<div class="main_body">
	<div class="span9 page_message">
		<section id="contents">
			<ul class="tab-nav nav">

			</ul>

			<div class="table-bar">
				<div class="fl">
                    <div class="tools">
						<a class="btn" href="/admin/addPlace">新增</a>
						<button class="btn ajax-post confirm" target-form="ids" url="/admin/delMorePlace">删除</button>
					</div>
				</div>
				<!-- 高级搜索 -->
				<div class="search-form fr cf">
					<div class="sleft">
						<input type="text" name="keyword" class="search-input" value="<?php echo $keyword; ?>" placeholder="请输入代理人微信ID">
						<a class="sch-btn" href="javascript:;" id="search" url="/admin/agentplace/<?php echo $cur_page; ?>">
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
								<th>代理人微信ID</th>
								<th>省份</th>
								<th>城市</th>
								<th>区/县</th>
								<th>详细地址</th>
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
								<td><?php echo $v['open_id']; ?></td>
								<td><?php echo $v['provinces']; ?></td>
								<td><?php echo $v['city']; ?></td>
								<td><?php echo $v['county']; ?></td>
								<td><?php echo $v['address']; ?></td>
								<td>
                                    <a target="_self" href="/admin/editplace/<?php echo $v['id']; ?>">编辑</a>
									<a class="confirm" href="/admin/delPlace/<?php echo $v['id']; ?>">删除</a>
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