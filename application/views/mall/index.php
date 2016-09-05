<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<link href="<?php echo $this->config->base_url(); ?>static/css/mall/public/shop.css" rel="stylesheet" type="text/css">
<body class="withFoot">
    <div class="container">
    	<form class="search_form" action="/mall/lists" method="get">
        	<a href="javascript:void(0);" class="cate_icon" onClick="showPopCategory()">&nbsp;</a>
            <input type="text" placeholder="输入关键字搜索商品" value="" name="search_key"/>
            <button type="button" id="search" url="/mall/lists">搜索</button>
        </form>
        <!-- banner -->
        <div class="banner">
        	<ul>
        	<?php foreach ($banner as $v){ ?>
                <li>
                    <a href="<?php echo $v['url']; ?>"><img src="<?php echo imgUrl( $v['img'] ); ?>"/></a>
                </li>
             <?php }; ?>
            </ul>
            <span class="identify">
            	
            <?php foreach ($banner as $v){ ?>
               <em></em>
            <?php }; ?>
            </span>
        </div>
        <div class="index_nav">
        	<a href="/mall/lists">全部商品</a>
            <span class="line"></span>
            <a href="/mall/reserve">领养圈</a>
            <span class="line"></span>
            <a href="/mall/service" style="color: #1d98d6">服务点</a>
            <!--<span class="line"></span>
            <a href="">店铺简介</a>
            <span class="line"></span>
            <a href="">联系卖家</a>-->
        </div>
        
        <!-- 推荐商品 -->
        <!-- <div class="recommend_list">
        	<h6 class="cate_title">商城推荐</h6>
            <div class="product_list">
                <ul>
                	<?php //foreach ($recommend as $v){ ?>
                    <li>
                        <a href="<?php //echo goodsUrl($v['id']); ?>">
                            <img src="<?php //echo imgUrl($v['cover']); ?>"/>
                            <div class="desc">
                            	<p class="name"><?php //echo $v['title']; ?></p>
                            	<p class="price">￥<?php //echo $v['price']; ?></p>
                            </div>
                        </a>
                    </li>
                    <?php //}; ?>
                </ul>
            </div>
        </div> -->
        
        <!-- 所有商品 -->
        <div class="all_list">
        	<h6 class="cate_title">所有商品</h6>
            <div class="product_list">
                <ul>
                	<?php foreach ($goods as $v){ ?>
                    <li>
                        <a href="<?php echo goodsUrl($v['id']); ?>">
                            <img src="<?php echo imgUrl($v['cover']); ?>"/>
                            <div class="desc">
                            	<p class="name"><?php echo $v['title']; ?></p>
                            	<p class="price">￥<?php echo $v['price']; ?></p>
                            </div>
                        </a>
                    </li>
                    <?php }; ?>
                </ul>
            </div>
            <a class="list_bottom_btn" href="/mall/lists">查看所有商品&gt;</a>
        </div>
        
    </div>	
    <!-- 分类目录 -->
    <?php $this->load->view('mall/_category'); ?>
    
    <!-- 底部导航 -->
   <?php $this->load->view('mall/_footer'); ?>
   
<script type="text/javascript">
$(function(){
	//通用banner 滑动
	$.WeiPHP.initBanner(true,5000);
	
	//搜索功能
	$("#search").click(function(){
		var url = $(this).attr('url');
        var query  = $('.search_form').serialize();
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