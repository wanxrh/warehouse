<?php $this->load->view('header');?>

<div class="g-wrap clearfix">
    <div class="m-step">
        <span class="dot">1
            <h3>买家  申请退款</h3>
        </span>
        <span class="dot act-2">2
            <h3>处理退货申请</h3>
        </span>
        <span class="dot-s act-3">3
            <h3>　买家退货　　</h3>
        </span>
         <span class="dot-s act-4">3
            <h3>　退货完成　　</h3>
        </span>
        <div class="line">
            <div class="move-2"></div>
        </div>
    </div>
</div>
<div class="g-wrap clearfix m-refund">
    <div class="g-mn">
        <div class="g-mnc">
            <div id="J_act_1" class="act">
                <div class="tt">
                重要提示：如因您提供的退货地址错误，导致买家无法退货或退回商品后无法送达，由您承担因此产生的费用。
                </div>
               
                <dl class="txt-tip">
                    <dt>
                        退货地址：
                    </dt>
                    <dd>
                        <?php foreach ($return_address as $v){?>
                        <div><label><input type="radio" <?php if($v['is_default']){?>checked="checked"<?php }?> name="addr_id" value="<?php echo $v['addr_id'];?>"><?php echo $v['region_name'];?> <?php echo $v['address'];?> <?php echo $v['consignee'];?> <?php echo $v['mobile'];?>/<?php echo $v['tel'];?></label></div>
                        <?php } ?>
                    </dd>
                </dl>
                <dl class="txt-tip">
                    <dt>
                        退货说明：
                    </dt>
                    <dd>
                        <div>
                            <textarea name="remark" id="remark" cols="30" rows="10" placeholder="您可以告知买家选用哪种物流，或其他注意事项。"></textarea>
                        </div>
                    </dd>
                </dl>
                

                <div class="f-tac">
                    <button class="btn" id="J_agree" data-rid="<?php echo $refund_info['rec_id'];?>" data-url="/refund/drawback_address">发送退货地址</button>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span class="refused" id="J_cancel">取消并返回</span>

                </div>
                
            </div>

           <?php $this->load->view('refund/diary');?>
        </div>
    </div>
    <div class="g-sd">
        <?php $this->load->view('refund/side');?>
    </div>
</div>

<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>user/js/refundGoods2.js" charset="utf-8"></script>
<?php $this->load->view('footer');?>