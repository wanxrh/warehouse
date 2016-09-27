<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>文章修改</title>
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
				<li>权限管理</li>
				<li><a href="/level">管理员权限列表</a></li>
				<li>修改权限</li>
			</ul>
		</div>

		<div class="g-mnr">
			<table class="tablelist">
				<tbody>
					<form id="article_form"  method="post">
						<ul class="forminfo">

							<li id="all_checkbox"><label>选择权限<b>*</b></label>
								<?php foreach ($level as $key => $val): ?>
									<span style="float: left; width: 110px;">                           	
										<b style="color:#F00"><input <?php if (in_array($val['level_id'], $level_id)): ?> checked="checked"<?php endif; ?> type="checkbox" value="<?php echo $val['level_id'] ?>" name="level_id[]" /><?php echo $val['level_name'] ?></b>
										<?php if (isset($val['child'])): ?>
										<?php foreach ($val['child'] as $k => $v): ?>
										<span><input <?php if (in_array($v['level_id'], $level_id)): ?> checked="checked"<?php endif; ?> type="checkbox" value="<?php echo $v['level_id'] ?>" name="level_id[]" /><?php echo $v['level_name'] ?></span>
										<?php endforeach; ?>
										<?php endif;?>
									</span> 
								<?php endforeach; ?>
							</li><br />

							<li style="line-height: 35px;"><label>操作<b>*</b></label>
								<a href="javascript:" id="all_check" style="color:#0F0">全选</a> | 
								<a href="javascript:" id="all_none" style="color:#F00">取消</a> | 
								<a href="javascript:" id="all_uncheck" style="color:#F00">反选</a>
							</li>


							<li><label>&nbsp;</label><input name="" type="submit" class="u-btn" value="提交"/></li>
					</form>
				</tbody>
			</table>
		</div>    
		<script type="text/javascript">
			$('.imgtable tbody tr:odd').addClass('odd');
		</script>

	</body>

</html>
<script type="text/javascript">
	$("#all_check").click(function () {
		$("#all_checkbox input").attr("checked", "checkbed");
	});

	$("#all_none").click(function () {
		$("#all_checkbox input").attr("checked", "");
	});

	$("#all_uncheck").click(function () {
		var len = $("#all_checkbox input").length;
		for (var i = 0; i < len; i++) {
			if ($("#all_checkbox input").eq(i).is(":checked")) {
				$("#all_checkbox input").eq(i).attr("checked", "");
			} else {
				$("#all_checkbox input").eq(i).attr("checked", "checked");
			}

		}
	});
</script>