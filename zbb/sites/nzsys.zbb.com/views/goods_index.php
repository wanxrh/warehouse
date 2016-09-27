<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
<link href="<?php echo $this->config->item('domain_static'); ?>system/css/common.css" rel="stylesheet" type="text/css" />
<link href="<?php echo $this->config->item('domain_static'); ?>system/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>system/js/jquery.js"></script>
<script language="Javascript">
function CheckForm()
{
  if(confirm("确认批量下架处理吗？")==true)
    return true;
  else
    return false;
} 
</script>
</head>
<body>

	<div class="u-bd-tt">
    <span>位置：</span>
    <ul >
    <li>商品管理</li>
    <li><a href="/goods">商品列表</a></li>
    </ul>
    </div>
    
    <div class="g-mnr">
    <div class="tools"> 
  <form method="get" action="/goods/index" style="float:left;">
  <label>商品名:</label><input type="text" style=" width:110px;" class="dfinput" name="good_name" value="<?php echo isset($good_name)?$good_name:'';?>"/>
  <label>店铺名:</label><input type="text" style=" width:110px;" class="dfinput" name="store_name" value="<?php echo isset($store_name)?$store_name:'';?>"/>
  <label>分类名:</label>
 <select name="cate_id" class="dfinput" style=" width:110px; height:25px;">
  <option value="">请选择...</option>
   <?php foreach ($cate as $key=>$item): ?>
  <option value="<?php echo $item['cate_id']?>" <?php echo $cate_id==$item['cate_id']?'selected':''; ?>><?php echo $item['cate_name']?></option>
      <?php endforeach; ?>  
  </select>
  <input type="submit" class="u-btn"  value="查询" /> 
  </form>
    </div>
    
    <table class="tablelist">
    	<thead>
    	<tr>
        <th>编号</th>
        <th>商品名</th>
        <th>店铺名</th>
        <th>分类名</th>
        <th>上架</th>
        <th>禁售</th>
        <th colspan="2">操作</th>
        </tr>
        </thead>
        <tbody>
           <?php foreach ($list as $item): ?>
        <tr>
        <td><?php echo $item['goods_id']?></td>
        <td><?php echo $item['goods_name']?></td>
        <td><?php echo $item['store_name']?></td>
        <td><?php echo $cate_name[$item['cate_id']];?></td>
        <?php if ($item['if_show'] == 1): ?>
      <td><a href="javascript:" class="shelves" id="gid_<?php echo $item['goods_id']?>">是</a></td>
      <?php else: ?>
       <td><a href="javascript:" class="shelves" id="gid_<?php echo $item['goods_id']?>">否</a></td>
       <?php endif; ?>
       
         <?php if ($item['closed'] == 1): ?>  
      <td><a href="javascript:" class="Lock" id="gid_<?php echo $item['goods_id']?>">是</a></td>
       <?php else: ?>
        <td><a href="javascript:" class="Lock" id="gid_<?php echo $item['goods_id']?>">否</a></td>
      <?php endif; ?>
        <td><a href="<?php echo goods_url($item['goods_id'])?>"  target="_blank" class="tablelink">查看</a></td>
        <td><a href="<?php echo $this->config->item('domain_nzsys'); ?>goods/edit?id=<?php echo $item['goods_id'];?>"   class="tablelink">编辑</a></td>
        </tr> 
           <?php endforeach; ?>  
        </tbody>
    </table>
    
   
    <div class="pagin">
  <?php echo $page ?>
    
    </div>
    
    
    <div class="tip">
    	<div class="tiptop"><span>提示信息</span><a></a></div>
        
      <div class="tipinfo">
        <span><img src="images/ticon.png" /></span>
        <div class="tipright">
        <p>是否确认对信息的修改 ？</p>
        <cite>如果是请点击确定按钮 ，否则请点取消。</cite>
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
<script type="text/javascript">
/**商品上下架**/
$(".shelves").click(function(){
var gid=$(this).attr("id").substr(4);
var url="<?php echo $this->config->item('domain_nzsys'); ?>goods/shelves/"+gid;
var obj=$(this);
$.ajax({	
    type:"GET",
	url:url,
	success:function(msg){
		  if(msg == 1){
				 
				 obj.html("是");
				 	  	  
				  }else{ 
				    obj.html("否");	
					  }
			 
		}
		
    })

})

/**是否禁售**/
$(".Lock").click(function(){
var gid=$(this).attr("id").substr(4);
var url="<?php echo $this->config->item('domain_nzsys'); ?>goods/goods_lock/"+gid;
var obj=$(this);
$.ajax({	
    type:"GET",
	url:url,
	success:function(msg){
		  if(msg == 1){
				 obj.html("是");  	  
				  }else{ 
				    obj.html("否");	
					  }
			 
		}	
    })

})






</script>