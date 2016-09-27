<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>商品分类修改</title>
<link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
<link href="<?php echo $this->config->item('domain_static'); ?>system/css/common.css" rel="stylesheet" type="text/css" />
<link href="<?php echo $this->config->item('domain_static'); ?>system/css/style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>common/js/jquery-1.11.0.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>system/js/cate.js"></script>

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
    <li><a href="/gcategory">分类管理</a></li>
    <li>编辑</li>
    </ul>
    </div>
    
<div class="g-mnr">
<table class="tablelist">
    	<tbody>
<form id="article_form" enctype="multipart/form-data" method="post">
<ul class="forminfo">
<li><label>分类名称<b>*</b></label>
<input name="cate_name" type="text" maxLength="15" class="dfinput" value="<?php echo $cate_info['cate_name']?>"  style="width:300px;"/>
  <i>名称不能超过15个字符</i>
</li>


<li><label>上级分类<b>*</b></label>
  <select id="parent_id" class="dfinput" style="width:110px;" name="parent_id">
   <option value="0">顶级分类</option>
        <?php foreach($top_cate as $v){ ?>
        <option value="<?php echo $v['cate_id']; ?>" <?php echo $cate_info['parent_id']==$v['cate_id']?"selected":""; ?> ><?php echo $v['cate_name']; ?></option>  
        <?php 
        foreach ($second_cate as $m) { 
          if($m['parent_id']==$v['cate_id']){
        ?>
        <option value="<?php echo $m['cate_id']; ?>" <?php echo $cate_info['parent_id']==$m['cate_id']?"selected":""; ?>>&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $m['cate_name']; ?></option> 
        <?php }}?>
        <?php } ?>    
  </select>
</li>
    <li><label>类别图片<b>*</b></label>
        <input class="infoTableFile2" id="category_pic" name="category" type="file">
        <?php if ($cate_info['cate_images']):?>
    </li>
    <li><label>当前图片<b>*</b></label>
        <img src="<?php echo img_url($cate_info['cate_images']); ?>" width="80" />
        <?php endif;?>
    </li>

<li><label>排序<b>*</b></label>
<input maxLength="3" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" name="sort_order" type="text" class="dfinput" value="<?php echo $cate_info['sort_order'] ?>"  style="width:300px;"/>
</li>   
   

<li><label>&nbsp;</label><input name="" type="submit" class="u-btn" value="提交"/></li>
</ul>
</form>
</tbody>
</table>
</div>    
<script type="text/javascript">
	$('.imgtable tbody tr:odd').addClass('odd');
	</script>
    
</body>

</html>
