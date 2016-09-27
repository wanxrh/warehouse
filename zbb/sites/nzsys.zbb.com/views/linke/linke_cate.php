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
$(document).ready(function(){
  $(".click").click(function(){
  $(".tip").fadeIn(200);
  });
  
  $(".tiptop a").click(function(){
  $(".tip").fadeOut(200);
});

  $(".sure").click(function(){
  $(".tip").fadeOut(100);
});

  $(".cancel").click(function(){
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
    <?php if($type == 1):  ?>
    <li><a href="/linkecate?type=1">文字推送</a></li>
    <?php elseif($type == 2): ?>
    <li><a href="/linkecate?type=2">图片推送</a></li>
    <?php endif; ?>
    <?php if (!empty($p_cate)) : ?>
        <?php foreach ($p_cate as $val) : ?>
            <li><a href="/linkecate/linke_add?type=<?php echo $val['type'];?>&cid=<?php echo $val['id']; ?>"><?php echo $val['name']; ?></a></li>
        <?php endforeach;?>
    <?php endif; ?>
    </ul>
    </div>
    
    <div class="g-mnr">


    
    <table class="tablelist">
    
    <thead>
    <tr>
   
    
    <th>分类名称</th>
   
    <th>操作</th>
    </tr>
    </thead>
    
    <tbody>
    <?php foreach($category as $v):?>
    <tr>
    <td><?php echo $v['name'];?></td>
    <td><a href="/linkecate/linke_add?cid=<?php echo $v['id'];?>&type=<?php echo $v['type'];?>">进入</a> | <a href="/linkecate/cate_mod?id=<?php echo $v['id'];?>&type=<?php echo $v['type'];?>">修改</a>
    	
	</td>
    </tr>
  <?php endforeach;?>
    </tbody>
    
    </table>
   
    
    
<script type="text/javascript">
	$('.imgtable tbody tr:odd').addClass('odd');
	</script>
    
</body>

</html>
