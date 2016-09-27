<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>地区列表</title>
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
    <li>商品管理</li>
    <li><a href="/gcategory">分类列表</a></li>
    
    </ul>
    </div>
    
    <div class="g-mnr">
    <div class="tools">
    	<ul class="toolbar">
        <li class="click"><a href="/gcategory/add/<?php if(!empty($cate_id)){echo $cate_id;}; ?>"><span><img src="<?php echo $this->config->item('domain_static'); ?>system/images/t01.png" /></span>添加</a></li>
        </ul>
    </div>
    <table class="tablelist">
    <thead>
    <tr>
    <th><input name="" type="checkbox" value=""/></th>
    <th>编号</th>
    <th>分类名</th>
    <th>排序</th>
    <th>显示</th>
    <th>操作</th>
    </tr>
    </thead>
    
    <tbody>
    <?php foreach($gcategory  as $item): ?>
    <tr>
    <td><input type="checkbox" class="checkitem" value="<?php echo $item['cate_id']?>" /></td>
    <td><?php echo $item['cate_id']?></td>
    <td><?php echo $item['cate_name']?></td>
    <td><?php echo $item['sort_order']?></td>
     <?php if ($item['if_show'] == 1): ?>
    <td><a href="/gcategory/gcategory_show/id/<?php echo $item['cate_id']?>">是</a></td>
         <?php else: ?>
          <td><a href="/gcategory/gcategory_show/id/<?php echo $item['cate_id']?>">否</a></td>
          <?php endif; ?>
    <td><a href="/gcategory/next_level/id/<?php echo $item['cate_id']?>">下一级</a> | 
    	<a href="/gcategory/save/id/<?php echo $item['cate_id']?>">编辑</a> | 
    	<a href="/gcategory/delete/id/<?php echo $item['cate_id']?>" onclick="if(confirm('确定删除?')==false)return false;">删除</a>
	</td>
	</td>
    </tr>
    <?php endforeach; ?>
    </tbody>
    
    </table>
   
    
    
<script type="text/javascript">
	$('.imgtable tbody tr:odd').addClass('odd');
	</script>
    
</body>

</html>

