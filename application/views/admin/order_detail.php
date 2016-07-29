<?php $this->load->view('admin/header'); ?>
<div class="main_body">
<style type="text/css">
.order_info{ margin:20px 0; min-height:100px; border:1px solid #eee; background:#f3f3f3; padding:10px;}
.order_info p{ color:#888; font-size:12px;}
.order_info p.title{ font-size:16px; line-height:30px; color:#333;}
.order_info .cover{ float:left; width:100px; height:100px;}
.order_info .info_content{ padding-left:110px; line-height:22px;}
.address_info{ padding:10px;border:1px solid #eee; background:#f3f3f3;}
.address_info p{ line-height:30px;}
.address_info p span{ color:#888;}
.action_wrap{ margin:20px 0; border:1px solid #F90; background:#fef5ea; padding:20px;}
#sendDiv .tab{ height:40px; margin:15px 0 0; }
#sendDiv .tab a{ height:40px; line-height:40px; float:left; padding:0 20px; }
#sendDiv .tab a.current{background:#44b549; color:#fff}
.tab_content{ padding:10px; background:#fff;border:1px solid #44b549;}
.f_i{ margin:10px 0;}
</style>
  <div class="span9 page_message">
  <section id="contents"> 
  	
    <div class="tab-content"> 
    	<div class="order_detail">
        	<h3>订单编号：<?php echo $info['order_number']; ?></h3>
        	<?php foreach ($info['goods_datas'] as $goods){ ?>
            <div class="order_info">
            	<img class="cover" src="<?php echo imgUrl($goods['cover']); ?>"/>
                <div class="info_content">
                <p class="title"><?php echo $goods['title']; ?></p>
                <p>购买数量：<?php echo $goods['num']; ?></p>
                <p>单价：<?php echo $goods['price']; ?>元</p>
                <p>总价：<?php echo $goods['price']*$goods['num']; ?>元</p>
            	</div>
            </div>
            <?php }; ?>
            <div class="address_info">
            	<p><span>收件人：</span><?php echo $address['truename']; ?></p>
                <p><span>联系方式：</span><?php echo $address['mobile']; ?></p>
                <p><span>收货地址：</span><?php echo $address['region_name'].' '.$address['address']; ?></p>
                <p><span>付款方式: </span><?php echo $info['pay_type_name']; ?></p>
                <p><span>总价: </span>元<?php echo $info['total_price']; ?></p>
            	<p><span>订单留言: </span><?php echo $info['remark']; ?></p>                
             </div>
             <div class="action_wrap">
             	<?php if($info['pay_status']==0 && $info['pay_type']!=10){ ?>
                	<p class="wait_pay">等待买家付款中...</p>
                <?php }else{ ?>
                	<?php if($info['is_send'] == 0){ ?>
                    	<p>
                    		<?php if($info['pay_type'] == 10){ ?>
	                    		买家选择货到付款
	                    	<?php }else{ ?>
	                    	买家已付款
	                    	<?php }; ?>
	                    	&nbsp;&nbsp;&nbsp;&nbsp;
	                    	<a class="btn" href="javascript:;" onClick="$('#sendDiv').show();$(this).parent().hide()">发货</a>
                    	</p>
                        <form id="sendDiv" action="/admin/dosend" method="post" style="display:none">
                            <div class="tab_content" id="tab1_content">
                                <div class="f_i">
                                    <label>物流公司</label>
                                    <select name="send_code">
                                        <option>请选择物流公司</option>
                                        <option value="intra-city">同城派送</option>
                                        <option value="sf">顺丰</option>
                                        <option value="sto">申通</option>
                                        <option value="yt">圆通</option>
                                        <option value="yd">韵达</option>
                                        <option value="tt">天天</option>
                                        <option value="ems">EMS</option>
                                        <option value="zto">中通</option>
                                        <option value="ht">汇通</option>
                                        <option value="qf">全峰</option>
                                    </select>
                                </div>
                                <div class="f_i">
                                    <label>快递单号</label>
                                    <input type="text" name="send_number" />
                                </div>
                                <input type="hidden" name="order_id" value="<?php echo $info['id']; ?>" />
								<button class="btn submit-btn" type="submit">发货</button>
                            </div>                            
                        </form>
                    <?php }else{ ?>
                    	<?php if($info['is_send'] == 2){ ?>
                    	商品已发货
                        <p>物流公司: <?php echo $info['send_code_name']; ?> &nbsp;&nbsp;&nbsp;快递单号: <?php echo $info['send_number']; ?></p>
                        <p><a href="javascript:;" onClick="getShopping();">跟踪物流</a></p>
                        <div class="shipping_info" style="display:none">
                        	<P>正在加载物流信息...</P>
                        </div>
                        <?php }elseif ($info['is_send'] == 1){ ?>
                        <p>商家同城派送中......</p>
                        <?php }; ?>
                        <?php if($info['pay_type']==10 && $info['pay_status']==0){ ?>
                        
                        <p>此订单为货到付款，如果您已经收到款项，请点击：&nbsp;&nbsp;&nbsp;<a href="javascript:;" onClick="doPay();">确认已经收款</a></p>
                        <?php }; ?>
                    <?php }; ?>
                <?php }; ?>
                
            </div>
                
                
        </div>
           
    </div>
  </section>
  </div>
</div>
</div>
<script type="text/javascript">
function tabForm(_this,type){
	$(_this).addClass('current').siblings().removeClass('current');
    $('#tab'+type+'_content').show().siblings('.tab_content').hide();
}
function getShopping(){
	$('.shipping_info').show();
	//加载物流信息到shipping_info
	$.post("{:U('get_send_info')}",{id:"{$info.id}"},function(html){
		if(html==''){
			$('.shipping_info').html('<P>暂时无物流信息</P>');
		}else{
			$('.shipping_info').html(html);
		}
	    
	});
}
function doPay(){
	if(confirm('确认设置为已收款？')){
		$.post("/admin/setpay",{id:"<?php echo $info['id']; ?>"},function(res){
			 location.reload();
	    });
	}
}
</script>
<?php $this->load->view('admin/footer'); ?>