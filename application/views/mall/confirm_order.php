<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<body>
<div class="container"> 
  <!-- 选择收货地址 --> 
  <a class="choose_address" href="/mall/chooseaddress"> 
  <empty name="address">
  <?php if(!$address){ ?>
  <!-- 没有 --> 
  <span class="write"><em class="write_icon">&nbsp;</em>请选择收货地址</span> 
  <input type="hidden" name="address_id" id="address_id" value="" />
  <?php }else{ ?>
  <!-- 已有收货地址 -->
  <div class="adress_item"> <span class="label">送至</span> <span class="address"><?php echo $address['region_name'].' '.$address['address']; ?><br/>
	<?php echo $address['truename'].'  '.$address['mobile']; ?></span> </div>
    <input type="hidden" name="address_id" id="address_id" value="<?php echo $address['id']; ?>" />
    <?php }; ?>
    
  <em class="arrow_right">&nbsp;</em> </a> 
  <!-- 订单信息 -->
  <div class="order_info">
    <p class="t">订单信息</p>
    <ul>
      <volist name="lists" id="vo">
      <?php foreach ($list as $v){ ?>
        <li class="order_item"> <img src="<?php echo imgUrl($v['cover']); ?>" />
          <div class="info">
            <P class="name"><?php echo $v['title']; ?></P>
            <!--<p class="property">
                    	<span class="colorless">编号</span>
                    	<span>1212121212</span>
                    </p>
                    <p class="property">
                    	<span class="colorless">型号</span>
                    	<span>红色 34</span>
                    </p>-->
            <p class="property"> <span class="colorless">价格</span> <span class="orange">￥<?php echo $v['price']; ?></span> </p>
            <p class="property"> <span class="colorless">数量</span> <span><?php echo $v['num']; ?></span> </p>
          </div>
        </li>
      <?php }; ?>
    </ul>
    <!--<p class="ship_type"> <span class="fl">配送方式</span> <span class="fr">快递：10元</span> </p>-->
    <p class="order_remark">
      <textarea placeholder="给卖家给留言" name="remark" id="remark"></textarea>
    </p>
    <p class="total_price"> <span class="orange">共<?php echo $total_price; ?>元</span> </p>
    <a class="btn" href="javascript:void(0)" onClick="doPost()">提交订单</a> </div>
</div>
</body>
</html>
<script type="text/javascript">
function doPost(){
	var address_id = $('#address_id').val();
	if(address_id==''){
	    $.Dialog.fail("请选择收货地址");
		return false;	
	}
	var remark = $('#remark').val();

	var url = "/mall/addorder";
	$.post(url,{'address_id':address_id,'remark':remark},function(res){
		var orderid=parseInt(res);
		if(orderid==0){
			$.Dialog.fail("提交订单失败");
		}else{
			$url="/mall/choosepay?order_id="+orderid;
			window.location.href=$url;
		}
	});
}
</script>