<section class="pop_category" style="display:none">
  <div class="pop_category_head"> <a href="javascript:;" onClick="hidePopCategory()">取消</a> </div>
  <ul>
    <!-- <volist name="category_list" id="cate">
        <li><a href="{:U('goodsListsByCategory',array('shop_id'=>$shop_id,'cid0'=>$cate[id]))}">{$cate.title}</a></li>
        <notempty name="cate.child">
            <ul>
            <volist name="cate.child" id="cd">
                <li><a href="{:U('lists',array('shop_id'=>$shop_id,'cid0'=>$cate[id],'cid1'=>$cd[id]))}">{$cd.title}</a></li>
            </volist>
            </ul>
        </notempty>
    </volist> -->
    <?php foreach ($category as $v){ ?>
    <li><a href="/mall/lists?cate=<?php echo $v['id']; ?>"><?php echo $v['title']; ?></a></li>
    <?php }; ?>
  </ul>
</section>
<script type="text/javascript">
function showPopCategory(){
	$('body').addClass('noscroll');
	$('.pop_category').addClass('show_category').show();
}
function hidePopCategory(){
	$('body').removeClass('noscroll');
	$('.pop_category').removeClass('show_category').hide();	
}
</script> 