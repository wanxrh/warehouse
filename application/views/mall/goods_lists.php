<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<link href="<?php echo $this->config->base_url(); ?>static/css/mall/public/shop.css" rel="stylesheet" type="text/css">
<body class="withFoot">
    <div class="container">
    	<form class="search_form" action="/mall/lists" method="get">
        	<a href="/mall" class="back_icon">&nbsp;</a>
            <input type="text" placeholder="输入关键字搜索商品" value="<?php echo $search_key; ?>" name="search_key" />
            <input type="hidden" name="cate" value="<?php echo $cate; ?>">
            <button type="button" id="search" url="/mall/lists">搜索</button>
            <a href="javascript:void(0);" class="cate_icon" onClick="showPopCategory()">&nbsp;</a>
        </form>
        <div class="list_type">
            <a href="/mall/lists?order_key=id&order_type=desc<?php if($search_key){echo '&search_key='.$search_key;}if($cate){echo '&cate='.$cate;} ?>">最新</a>
            <span class="line"></span>
            <a href="/mall/lists?order_key=rank&order_type=desc<?php if($search_key){echo '&search_key='.$search_key;}if($cate){echo '&cate='.$cate;} ?> ">热销</a>
            <span class="line"></span>
            <a href="/mall/lists?order_key=sale_count&order_type=desc<?php if($search_key){echo '&search_key='.$search_key;}if($cate){echo '&cate='.$cate;} ?> ">销量</a>
        </div>
        <!-- 产品列表 -->
        <div class="product_list">
            <ul id="productContainer">
            <?php foreach ($list as $v){ ?>
                <li class="contentItem" data-lastid="<?php echo $v['id']; ?>">
                        <a href="/mall/detail/<?php echo $v['id']; ?>">
                            <img src="<?php echo imgUrl($v['cover']) ?>"/>
                            <div class="desc">
                            	<p class="name"><?php echo $v['title']; ?></p>
                            	<p class="price">￥<?php echo $v['price']; ?></p>
                            </div>
                        </a>                    
                </li>
                <?php }; ?>
            </ul>
        </div>
        <!-- <div class="noMore">没有更多内容</div> 
     	<div class="moreLoading"><em>&nbsp;</em>正在加载更多···</div> -->
        
        
    </div>	
    
    <!-- 分类目录 -->
    <?php $this->load->view('mall/_category'); ?>
    
    <!-- 底部导航 -->
    <?php $this->load->view('mall/_footer'); ?>
    
<script type="text/javascript">
$(function(){	
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