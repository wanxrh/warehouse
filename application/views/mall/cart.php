<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/mobile/shop.js"></script>
<body>
    <div class="container">
    <?php if(!$cart_count){ ?>
    	<div class="cart_empty">
        <img src="<?php echo $this->config->base_url(); ?>static/mobile/cart.png"/>
    	<p>购物车还是空的</p>
    	<p><a href="/mall">去店里逛逛吧</a></p>
    	</div>
        
            <!-- 底部导航 -->
    <?php $this->load->view('mall/_footer'); ?>
    <?php }else{ ?>
    	<div class="cart_list_top">
        	<a class="fr orange" href="javascript:void(0);" onClick="deleteCartItem()">删除商品</a>
        </div>
        <form action="/mall/confirmorder?rear=1" method="post" onSubmit="return checkCartSubmit()">
        <div class="cart_list">
        	<ul>
                <?php foreach ($cart_list['list'] as $v){ ?>
                      <li class="cart_item">
                          <input class="custom_check" id="item_<?php echo $v['id']; ?>" rel="<?php echo $v['id']; ?>" name="goods_ids[]" type="checkbox" value="<?php echo $v['goods_id']; ?>" checked="checked" />
                          <label for="item_<?php echo $v['id']; ?>"><em>&nbsp;</em></label>
                          <div class="goods_item">
                          <a href="/mall/detail/<?php echo $v['goods_id']; ?>">
                            <img class="goods_img" src="<?php echo imgUrl($v['cover']); ?>"/></a>
                              <div class="goods_desc">
                                  <a class="name" href="/mall/detail/<?php echo $v['goods_id']; ?>"><?php echo $v['title']; ?></a>
                                  <!--<p class="info"><span class="colorless">型号:</span>蓝色 23</p>-->
                                  <p class="info"><span class="colorless">单价:</span><span class="orange">￥<span class="singlePrice"><?php echo $v['price']; ?></span></span></p>
                                  <div class="buy_count">
                                      <a class="reduce" href="javascript:;">-</a>
                                      <input type="text" name="buyCount[<?php echo $v['goods_id']; ?>]" value="<?php echo $v['num']; ?>" rel="buyCount"/>
                                      <a class="add" href="javascript:;">+</a>
                                  </div>
                              </div>
                          </div>
                      </li>
                <?php }; ?>
            </ul>
        </div>
        <!-- cart_list end -->
        <div class="cartBottom">
        	<div class="check_all">
        	<input class="custom_check check_all" id="checkAll" name="checkAll" type="checkbox"  checked="checked"/>
            <label for="checkAll"><em>&nbsp;</em>全选</label>
            </div>
            <div class="total">
            	<p>总价：<span class="orange">￥<span id="totalPrice"><?php echo $cart_list['total']; ?></span></span></p>
               <!--  <p class="count">(共<span id="totalCount">12</span>件。不含运费)</p> -->
            </div>
            <button class="settlement" type="submit">去结算</button>
        </div>
        </form>
        <?php }; ?>
    </div>	
    
</body>
</html>
<script type="text/javascript">
$(function(){
   updatePriceAndCount();	
});
//删除沟通车的商品
function deleteCartItem(){
	if($('input[name="goods_ids[]"]:checked').size()==0){
		$.Dialog.fail("请选择要删除的购物车物品");
	}else if(confirm('确认删除？')){
		var cartIds = "";
		$('input[name="goods_ids[]"]:checked').each(function(index, element) {
			cartIds += $(this).attr('rel')+",";
		});
		$.Dialog.loading();
		$.ajax({
			url:"/mall/delCart",
			data:{ids:cartIds},
			dataType:"json",
			type:"post",
			success:function(data){
				$.Dialog.success("删除成功");
				window.location.reload();	
			}
		})
	}
}
</script>