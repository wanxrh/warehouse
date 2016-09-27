<div class="order-side">
    <div class="tt">
        <p>退款申请</p>
    </div>
    <div class="goods-info">
        <a target="_blank" href="<?php echo goods_url($refund_info['goods_id']);?>" class="pic"><img title="<?php echo $refund_info['goods_name'];?>" src="<?php echo img_url($refund_info['goods_image']);?>"></a>
        <div class="info">
            <a title="<?php echo $refund_info['goods_name'];?>" target="_blank" href="<?php echo goods_url($refund_info['goods_id']);?>"><?php echo $refund_info['goods_name'];?></a>
            <p class="size"><?php echo $refund_info['specification'];?></p>
        </div>
    </div>
    <div class="order-info">
        <ul class="info-lst">
            <li><em>买&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;家：</em><span><?php echo $refund_info['buyer_name'];?></span></li>
            <li><em>订单编号：</em><span class="s-fc-yellow"><?php echo $refund_info['order_sn'];?></span></li>
            <li><em>单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价：</em><span><i class="s-fc-red"><?php echo $refund_info['price'];?></i> 元 * <i class="s-fc-red"><?php echo $refund_info['quantity'];?></i></span></li>
        </ul>
    </div>
    
        <div class="draw-info">
        <ul class="info-lst">
            <li><em>退款金额：</em><span class="s-fc-red"><?php echo $refund_info['money'];?></span> 元</li>
            <li><em>原&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;因：</em><span><?php echo $reason_name['reason'];?></span></li>
            <li><em>要&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;求：</em><span><?php echo $refund_info['type']==2?'退货退款':'退款';?></span></li>
            <li><em>货物状态：</em><span><?php echo order_status_name()[$refund_info['order_status']];?></span></li>
            <li><em>说&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;明：</em><span><?php echo $refund_info['supplement'];?></span></li>
        </ul>
    </div>
</div>