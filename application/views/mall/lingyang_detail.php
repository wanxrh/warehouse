<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/css/mall/public/shop.css"></script>
<body class="withFoot">
    <div class="container">
    	<div class="order_detail">
    	
    	<form id="form" action="/mall/comment" method="post" onSubmit="return tgSubmit()">
    	<div class="order">
        	<h3 class="mb_10">订单号:<?php echo $order_info['order_number']; ?></h3>
        	<input name="oid" type="hidden" value="<?php echo $order_info['id']; ?>">
            <?php foreach ($goods_datas as $v){ ?>
        	<img src="<?php echo imgUrl($v['cover']); ?>"/>
            <p class="info">
            	<?php echo $v['title']; ?>
                <br/>购买数量：<?php echo $v['num']; ?>
                <br/>价格:<?php echo $v['price']; ?>元
            </p>
            <?php }; ?>
        </form>

        <?php if($address_info){ ?>
        <div class="order_adress">
        	<p class="info">
            	收件人：<?php echo $address_info['truename']; ?><br/>
                联系方式：<?php echo $address_info['mobile']; ?><br/>
                收货地址：<?php echo $address_info['region_name'].' '.$address_info['address']; ?><br/>
            </p>
        </div>
         <?php }; ?>
         <div class="order_action">
        	
        		<?php if($order_info['pay_status'] == 0 && $order_info['pay_type'] != 10  ){ ?>
                	<p class="wait_pay">等待付款中...</p>
                    <div class="m_15">
                    <a href="/mall/choosepay?order_id=<?php echo $order_info['id']; ?>" class="btn">立即付款</a>
                    </div>
                <?php }else{ ?>
                    <?php if(!$order_info['delivery']){ ?>
                        <?php if($order_info['reserve_time'] > time()){ ?>
                            时间未到
                        <?php }else{ ?>
                            <form id="form" action="/mall/submit_lingyang" method="post" onSubmit="return lySubmit()">

                                <!-- 选择收货地址 -->
                                <a class="choose_address" href="/mall/chooseaddress?source=1&id=<?php echo $order_info['id']; ?>">
                                <empty name="address">
                                    <input type="hidden" name="oid" value="<?php echo $order_info['id']; ?>" />
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
                                <p class="t">配送方式</p>
                                <p>
                                    <select name="delivery">
                                        <option value="1">快递配送</option>
                                        <option value="2">电子券自提</option>
                                    </select>
                                </p>
                                <p class="t">是否宰杀</p>
                                <p>
                                    <select name="kill">
                                        <option value="0">否</option>
                                        <option value="1">是</option>
                                    </select>
                                </p>
                                <button class="btn" type="submit">确认领养</button>
                            </form>
                        <?php }; ?>
                    <?php }else{ ?>
                        <?php if($order_info['is_send'] == 0){ ?>
                            <p>等待卖家发货</p>
                        <?php }else{ ?>
                            <?php if($order_info['is_send'] == 2){ ?>
                            <p>商品已发货&nbsp;&nbsp;&nbsp;</p>
                            <p>发货方式:<?php echo $order_info['send_code_name']; ?></p>
                            <p>快递单号:<?php echo $order_info['send_number']; ?></p>
                            <p class="m_10">
                            <?php }elseif ($order_info['is_send'] == 1){ ?>
                            <p>商品在同城派送中......</p>
                            <?php }; ?>
                            <?php if($order_info['status_code'] ==3){ ?>
                            <a class="btn" href="javascript:;" >确认收货</a>
                            <?php }; ?>
                            </p>
                            <div class="shipping_info" <?php if(!$order_log){ echo 'style="display:none"';} ?>>
                                <?php foreach ($order_log as $v){ ?>
                                    <P><span><?php echo date('Y-m-d H:i:s',$v['cTime']); ?></span></P>
                                    <p><?php echo $v['remark']; ?></p>
                                    <p>&nbsp;</p>
                                <?php }; ?>
                            </div>
                        <?php }; ?>
                    <?php }; ?>
                <?php }; ?>
            
        </div>
         
        </div>
    </div>	
    <!-- 底部导航 -->
    <?php $this->load->view('mall/_footer'); ?>
<script type="text/javascript">
var init = 0;
function tgSubmit() {      
	/* var userName = $('#truename').val();
	if ($.trim(userName) == "") {
		$.Dialog.fail('请填写姓名');
		return false;
	}
	var regionName = $("input[name=region_name]").val();
	var regionID = $("input[name=region_id]").val();
	if(!regionName || regionID == 0){
		$.Dialog.fail('请选择地址所在地');
		return false;
	}
	var addContent = $("#address").val();
	if( !addContent ){
		$.Dialog.fail('请填写详细地址');
		return false;
	}
	var userPhone = $("#mobile").val();
	if ($.trim(userPhone) == "") {
		$.Dialog.fail('请填写您的手机号码');
		return false;
	}                   
	var patrn = /^0?(13[0-9]|15[0123456789]|18[0123456789]|14[0123456789])[0-9]{8}$/;
	if (!patrn.exec($.trim(userPhone))) {
		$.Dialog.fail('手机号格式错误');
		return false;
	} */
	if(init != 0){
		return false;
	}
	init = 1;
	return true;
}
function lySubmit() {
    if(init != 0){
        return false;
    }
    init = 1;
    return true;
}
</script>
</block>
</body>
</html>