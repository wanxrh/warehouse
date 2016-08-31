<?php $this->load->view('mall/mobile_head'); ?>
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/mobile/shop.js"></script>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<link href="<?php echo $this->config->base_url(); ?>static/css/mall/public/shop.css" rel="stylesheet" type="text/css">
<body>
    <div class="container">
    	<form class="search_form" action="/mall/lists" method="get">
        	<a href="<?php echo isset($_SERVER[' HTTP_REFERER'])?$_SERVER[' HTTP_REFERER']:'/mall' ?>" class="back_icon">&nbsp;</a>
            <input type="text" placeholder="输入关键字搜索商品" value="" name="search_key" />
            <button type="button" id="search" url="/mall/lists">搜索</button>
            <a href="javascript:void(0);" class="cate_icon" onClick="showPopCategory()">&nbsp;</a>
        </form>
        <?php if(!$goods_info){ ?>
        	<br/><br/>
        	<p style="text-align: center;color: red;">抱歉，该商品不存在，已被删除</p>
        <?php }elseif (!$goods_info['is_show']){ ?>
        		<br/><br/>
        		<p style="text-align: center;color: red;">抱歉，该商品已下架</p>
        <?php }else{ ?>
        	
        <!-- 相册 -->
        <section class="photoList">
        	<ul>
        	<?php foreach (explode(',',$goods_info['imgs']) as $v){ ?>
                <li>
                    <img src="<?php echo imgUrl( $v ); ?>"/>
                </li>
             <?php }; ?>            
            </ul>
            <span class="identify">
            <?php foreach (explode(',',$goods_info['imgs']) as $v){ ?>
                <em></em>
           	<?php }; ?>  
            </span>
        </section>
        <!-- 详情信息 -->
        <form id="detailForm" action="/mall/confirmorder" method="post">
        <input type="hidden" name="goods_id" value="<?php echo $goods_info['id']; ?>"/>
        <div class="detail_info">
        	<div class="info_item">
        		<h6 class="name"><?php echo $goods_info['title']; ?></h6>
            	<p class="price">
                	￥<span id="price"><?php echo $goods_info['price']; ?></span>
                	<notempty name="goods.old_price"><del>￥<?php echo $goods_info['old_price']; ?></del></notempty>
                </p>
            </div>
            <div class="info_item">
<!--            	<p>型号</p>
            	<a class="sku_item" href="javascript:;" data-price="122.00">黄色 38<input type="checkbox" class="sku_check" name="sku[0]" value="1"/></a>
                <a class="sku_item select"href="javascript:;" data-price="122.00">绿色 39<input type="checkbox" class="sku_check" name="sku[1]" value="1"/></a>
                <a class="sku_item" href="javascript:;" data-price="122.00">红色 40<input type="checkbox" class="sku_check" name="sku[2]" value="1"/></a>-->
                <p>数量</p>
                <div class="buy_count">
                	<a class="reduce" href="javascript:;">-</a>
                    <input type="text" name="buyCount" value="1"/>
                    <a class="add" href="javascript:;">+</a>
                </div>
            </div>
        </div>
		<?php if(!$goods_info['reserve']) { ?>
        <div class="detail_comment">
        	<a href="/mall/evaluation/<?php echo $goods_info['id']; ?>">
        	<span class="t">评价：</span>
            <span class="star_rader">
            	<span class="star_select" style="width:<?php echo $evaluation_score; ?>%"></span>
            </span>
            <span class="t comment_count">&nbsp;&nbsp;&nbsp;(<?php echo $evaluation_num; ?>人)</span>
            <a href="/mall/evaluation/<?php echo $goods_info['id']; ?>"><em style="float:right;" class="arrow_right">&nbsp;</em></a>        
        </div>
		<?php }else{ ?>
		<div class="detail_comment">
			<span class="t"><?php echo '注意：此商品于'.date('Y-m-d',$goods_info['reserve_time']).'后发货或自提' ?></span>
		</div>
		<?php } ?>
        <!-- 商品介绍 -->
        <div class="detail_content">
        	<h6 class="t">商品介绍</h6>
            <div class="content">
            <?php echo $goods_info['content'];?>
            </div>
        </div>
        </form>
    </div>
        <!-- 分类目录 -->
    <?php $this->load->view('mall/_category'); ?>
    
    <!-- 底部加入购物车等 -->
    <div class="detail_bottom">
		<?php if(!$goods_info['reserve']) { ?>
			<a class="add_favorite" href = "javascript:;" onClick = "addToFavorite()" > 收藏</a >
        	<a class="add_cart" href = "javascript:;" onClick = "addToCart()" > 加入购物车</a >
		<?php };?>
		<a class="buy_now" href="javascript:;" onClick="buyNow()">立即购买</a>
        <a class="my_cart" href="/mall/cart">购物车<span class="count" id="cartCount"><?php echo $cart_count?$cart_count:''; ?></span></a>
    </div>
  <?php }; ?>
	<p class="copyright">版本由圆梦云科技有限公司所有</p>
<script type="text/javascript">
//加入收藏
function addToFavorite(){
	$.Dialog.loading();
	var data = $('#detailForm').serializeArray();
	$.ajax({
		url:"/mall/addToCollect",
		data:data,
		dataType:'JSON',
		type:"POST",
		success:function(data){
			if(data){
				$.Dialog.success(data.info);
			}
		}
	})
}
function addToCart(){
	
	if(parseInt($('input[name="buyCount"]').text())>0){
		$.Dialog.fail("购物数量不能小于1件");
		return;	
	}
//	if(!$('.sku_check:checked').val()){
//		$.Dialog.fail("请选择型号");
//		return;	
//	}
	$.Dialog.loading();
	var data = $('#detailForm').serializeArray();
	$.ajax({
		url:"/mall/addtocart",
		data:data,
		dataType:'html',
		type:"POST",
		success:function(res){
			if(res){
				$.Dialog.success("加入购物车成功");
				$('#cartCount').text(res);
			}
		}
	})
}
function buyNow(){
	if(parseInt($('input[name="buyCount"]').text())>0){
		$.Dialog.fail("购物数量不能小于1件");
		return;	
	}
//	if(!$('.sku_check:checked').val()){
//		$.Dialog.fail("请选择型号");
//		return;	
//	}
	$('#detailForm').submit();
}
$(function(){
	$.WeiPHP.gallery('.photoList','.photoList ul');
	$('.sku_item').click(function(){
		$('#price').text($(this).data('price'));
		$(this).addClass('select').siblings().removeClass('select');
		$(this).find('input').prop("checked",true);
		$(this).siblings().find('input').prop("checked",false);
	})
	//图片预览
	var picList = [];
	$('.photoList li img').each(function(index, element) {
		var picUrl = $(this).attr("src");
		picList[index] = picUrl;
        $(this).click(function(){
			wx.previewImage({
				current: picUrl, // 当前显示的图片链接
				urls: picList // 需要预览的图片链接列表
			});
		})
    });
	
		//搜索功能
	$("#search").click(function(){
		var url = $(this).attr('url');
        var query  = $('.search_form').find('input').serialize();
        query = query.replace(/(&|^)(\w*?\d*?\-*?_*?)*?=?((?=&)|(?=$))/g,'');
        query = query.replace(/^&/g,'');
        if( url.indexOf('?')>0 ){
            url += '&' + query;
        }else{
            url += '?' + query;
        }
		window.location.href = url;
	});	
})
</script>	
</body>
</html>