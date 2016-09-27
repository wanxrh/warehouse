<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>无标题文档</title>
		<link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
<link href="<?php echo $this->config->item('domain_static'); ?>system/css/common.css" rel="stylesheet" type="text/css" />
		<link href="<?php echo $this->config->item('domain_static'); ?>system/css/style.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>system/js/jquery.js"></script>

		<script type="text/javascript">
			$(document).ready(function () {
				$(".click").click(function () {
					$(".tip").fadeIn(200);
				});

				$(".tiptop a").click(function () {
					$(".tip").fadeOut(200);
				});

				$(".sure").click(function () {
					$(".tip").fadeOut(100);
				});

				$(".cancel").click(function () {
					$(".tip").fadeOut(100);
				});

			});
		</script>


	</head>


	<body>

		<div class="u-bd-tt">
			<span>位置：</span>
			<ul >
				<li>推送管理</li>
				<li><a href="/recom">商品推送</a></li>
				<?php if ($cid == 6): ?>
					<li><a href="/recom/add?cid=<?php echo $cid ?>">新品上线</a></li>
				<?php elseif ($cid == 7): ?>
					<li><a href="/recom/add?cid=<?php echo $cid ?>">限量特卖</a></li>
				<?php endif; ?>

			</ul>
		</div>

		<div class="g-mnr">

			<table class="tablelist">
				<div class="tools"> 
					<form method="get" action="">
						<input type="hidden" name="cid" value="<?php echo $cid; ?>"></input>
						<label>商品名/编号:</label><input type="text" style=" width:110px;" class="dfinput" name="good_name" />
						<input type="submit" class="u-btn"  value="查询" /> 
					</form>
				</div>

				<thead>
					<tr>
						<th>编号</th>
						<th>商品名称</th>
						<th>所属分类</th>
						<th>添加时间</th>
						<th>操作</th>
					</tr>
				</thead>

				<tbody>
					<?php $ret = array_column($glist, 'target_id'); ?>
					<?php foreach ($alist as $v): ?> 
						<tr>
							<td><?php echo $v['goods_id']; ?></td>
							<td><?php echo $v['goods_name']; ?></td>
							<td><?php echo $cate_name[$v['cate_id']]; ?></td>
							<td><?php echo date('Y-m-d',$v['add_time']) ?></td>
							<td>
								<?php if (!in_array($v['goods_id'], $ret)) { ?>
									<a href="/recom/recom_act?cid=<?php echo $cid; ?>&goods_id=<?php echo $v['goods_id']; ?>&page=<?php echo $cur_page; ?>">推荐</a> 
								<?php } else { ?>
									已推荐
								<?php } ?>
							</td>
						</tr>
					<?php endforeach; ?>
					<tr><td colspan="5"><?php echo $page; ?></td></tr>
				</tbody>

			</table>

			<br />
			<br />



			<table class="tablelist">
				<thead>
					<tr>
					    <th>编号</th>
						<th>商品编号</th>
						<th>商品名称</th>
						<th>排序</th>
						<th>操作</th>
					</tr>
				</thead>

				<tbody>
                    <?php $i=1;?>
					<?php foreach ($glist as $v): ?>
						<tr>
						    <td><?php echo $i;?></td>
							<td><?php echo $v['target_id']; ?></td>
							<td><?php echo $v['title']; ?></td>
							<td><?php echo $v['sort']; ?></td>
							<td><a href="/recom/edit?id=<?php echo $v['id']; ?>&cid=<?php echo $v['cid']; ?>">修改</a> | <a href="/recom/up?cid=<?php echo $v['cid']; ?>&sort=<?php echo $v['sort']; ?>&id=<?php echo $v['id']; ?>">上移</a> | 
								<a href="/recom/down?id=<?php echo $v['id']; ?>&sort=<?php echo $v['sort']; ?>&cid=<?php echo $v['cid']; ?>">下移</a> | <a href="/recom/delete?id=<?php echo $v['id']; ?>&cid=<?php echo $v['cid']; ?>">取消</a> | 
							</td>
						</tr>
						<?php $i=$i+1;?>
					<?php endforeach; ?>
				</tbody>

			</table>


		</div>

		<script type="text/javascript">
			$('.imgtable tbody tr:odd').addClass('odd');
		</script>

	</body>

</html>
