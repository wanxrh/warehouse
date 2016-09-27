<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>文章预览页</title>
<link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
<link href="<?php echo $this->config->item('domain_static'); ?>system/css/common.css" rel="stylesheet" type="text/css" />
<link href="<?php echo $this->config->item('domain_static'); ?>system/css/style.css" rel="stylesheet" type="text/css" />
<link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
<link href="<?php echo $this->config->item('domain_static'); ?>common/css/public.css" rel="stylesheet"/>
<link href="<?php echo $this->config->item('domain_static'); ?>common/css/ui.css" rel="stylesheet" type="text/css" />
<link href="<?php echo $this->config->item('domain_static'); ?>help/css/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>system/js/jquery.js"></script>
</head>
<body>
<div class="g-bd">
	<div class="g-wrap">
		<div class="g-mn">
			<div class="m-bd">
				<div class="g-bd-article_info">
					<h1><?php echo $article['title']?></h1>
					<div class="article_info"><?php echo $article['content']?></div>
				</div>
			</div>
		</div>
   <div>
</div>
</body>

</html>