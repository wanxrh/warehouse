<?php $this->load->view('admin/header'); ?>
<div class="main_body">
	<div class="span9 page_message">
		<section id="contents">
			<ul class="tab-nav nav">

			</ul>

			<div class="table-bar">
				<div class="fl">
                    <div class="tools">
						<a class="btn" href="/admin/addVoucher">新增</a>
						<button class="btn ajax-post confirm" target-form="ids" url="/admin/delMoreVoucher">删除</button>
					</div>
				</div>
				<!-- 高级搜索 -->
				<div class="search-form fr cf">
					<div class="sleft">
						<input type="text" name="keyword" class="search-input" value="<?php echo $keyword; ?>" placeholder="请输入商品ID">
						<a class="sch-btn" href="javascript:;" id="search" url="/admin/voucher/<?php echo $cur_page; ?>">
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
								<th>商品ID</th>
								<th>数量</th>
								<th>电子券拥有者微信ID</th>
								<th>转电子券时间</th>
								<th>使用时间</th>
								<th>状态</th>
								<th>二维码</th>
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
								<td><?php echo $v['goods_id']; ?></td>
								<td><?php echo $v['number']; ?></td>
								<td><?php echo $v['owner_id']; ?></td>
								<td><?php if($v['get_time']){?> <?php echo date("Y-m-d H:i:s",$v['get_time']);?><?php }else{?>未转电子券<?php };?></td>
								<td><?php if($v['use_time']){?> <?php echo date("Y-m-d H:i:s",$v['use_time']); ?><?php }?></td>
								<td><?php if($v['status']==0){echo '未使用';}elseif($v['status']==1){echo '转电子券';}else{echo '已使用';}; ?></td>
								<td width="15%"><img src="http://bshare.optimix.asia/barCode?site=weixin&url=<?php echo 'http://lao337.zinongweb.com/'.'coupon/present?id='.$v['id'].'&time='.($time = time()).'&sign='.md5($v['sign'].$time);?>" height="100"></td>
								<td><?php echo date("Y-m-d H:i:s",$v['addtime']); ?></td>
								<td>
									<a class="confirm" href="/admin/delVoucher/<?php echo $v['id']; ?>">删除</a>
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