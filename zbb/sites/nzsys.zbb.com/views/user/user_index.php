<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>会员列表</title>
		<link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
		<link href="<?php echo $this->config->item('domain_static'); ?>system/css/common.css" rel="stylesheet" type="text/css" />
		<link href="<?php echo $this->config->item('domain_static'); ?>system/css/style.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>system/js/jquery.js"></script>

		<script type="text/javascript">
			$(document).ready(function () {
				$(".show_mob").click(function () {
					$(".tip").fadeIn(200);
					var user_id =$(this).attr('locat');
					var url = '/user/select_uc_mob';
					$.ajax({
						type: "post",
						url: url,
						dataType: "json",
						data: {"user_id": user_id},
						success: function (msg) {
							var html = '';
							if(msg.mobile){
								html += '<p>手机号码：'+msg.mobile+'</p>';
							}else{
								html += '<p>手机号码：暂无信息</p>';
							}
							 if(msg.email){
								html += '<p>邮 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp箱：'+msg.email+'</p>';
							}else{
								html += '<p>邮 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp箱：暂无信息</p>';
							}
							 $(".tipright").html(html);
						}
					});
					
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
			<ul>
				<li>会员管理</li>
				<li><a href="/user">会员列表</a></li>
			</ul>
		</div>

		<div class="g-mnr">

			<div class="tools">
				<ul class="toolbar">
					<li><a href="/user/add">添加<span><img src="<?php echo $this->config->item('domain_static'); ?>system/images/t01.png" /></span></a></li>
				</ul>
				<form action="/user/index" method="get">
					<ul class="toolbar1">
						<select name="field_name">
							<option value="user_name">会员名</option>
							<option value="email">电子邮箱</option>
							<option value="real_name">真实姓名</option>
							<option value="user_id">用户编号</option>
						</select>
						<input class="dfinput" style="width:150px;" type="text" name="field_value" value="" />
						排序:
						<select name="sort">
							<option value="reg_time DESC">注册时间</option>
							<option value="last_login DESC">最后登录</option>
							<option value="logins DESC">登录次数</option>
						</select>
						<input type="submit" class="u-btn" style="width:80px;" value="查询" />
					</ul>
				</form>
			</div>


			<table class="tablelist">
				<thead>
					<tr>
						<th><input name="" type="checkbox" value="" checked="checked"/></th>
						<th>编号</th>
						<th>会员名</th>
						<th>联系方式</th>
						<th>注册时间</th>
						<th>最后登录</th>
						<th>登录次数</th>
						<th>冻结帐号</th>
					</tr>
				</thead>

				<tbody>

					<?php foreach ($list as $item): ?>
						<tr>
							<td><input type="checkbox" class="checkitem" value="<?php echo $item['user_id'] ?>" /></td>
							<td><?php echo $item['user_id'] ?></td>
							<td><?php echo $item['user_name'] ?></td>
							<td><a class="show_mob" href="javascript:void(0)" locat="<?php echo $item['user_id'] ?>">点击查看</a></td>
							<td><?php echo date('Y-m-d',$item['reg_time']); ?></td>
							<td><?php echo date('Y-m-d',$item['last_login']); ?></td>
							<td><?php echo $item['logins'] ?></td>
							<td><?php echo $item['lock'] ?></td>
						</tr>
					<?php endforeach; ?> 


				</tbody>
			</table>


			<div class="pagin">
				<?php echo $page; ?>
			</div>


			<div class="tip">
				<div class="tiptop"><span>提示信息</span><a></a></div>

				<div class="tipinfo">
<!--					<span><img src="images/ticon.png" /></span>-->
					<div class="tipright">
<!--						<p>是否确认对信息的修改 ？</p>
						<cite>如果是请点击确定按钮 ，否则请点取消。</cite>-->
					</div>
				</div>

				<div class="tipbtn">
					<input name="" type="button"  class="sure" value="确定" />&nbsp;
					<input name="" type="button"  class="cancel" value="取消" />
				</div>

			</div>




		</div>

		<script type="text/javascript">
			$('.tablelist tbody tr:odd').addClass('odd');
		</script>

	</body>

</html>
