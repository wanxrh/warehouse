<?php $this->load->view('header');?>
<div class="g-wrap">
    <div class="m-order-ct">
        <div class="m-tt">
            <span>订单详情<em></em></span>
        </div>
        <div class="nmc">
            收货地址:<?php echo $order_extm['region_name']?> <?php echo $order_extm['address']?>,<?php echo $order_extm['zipcode']?>,<?php echo $order_extm['consignee']?>,<?php echo $order_extm['mobile']?>,<?php echo $order_extm['tel']?>
        </div>
        <div class="tt">
            订单信息
        </div>
        <div class="nmc">
            <ul class="state">
                <?php $temp_arr=order_status_name();?>
                <li><span>订单状态：</span><?php echo $temp_arr[$order_info['order_status']];?></li>
                <li><span>订单号 ：</span><?php echo $order_info['order_sn'];?></li>
                <li><span>下单时间 ：</span><?php echo date('Y-m-d H:i:s',$order_info['add_time']);?></li>
                <li><span>付款时间：</span><?php echo !empty($order_info['pay_time'])?date('Y-m-d H:i:s',$order_info['pay_time']):'';?></li>
                <li><span>发货时间：</span><?php echo !empty($order_info['ship_time'])?date('Y-m-d H:i:s',$order_info['ship_time']):'';?></li>
                <li><span>完成时间 ：</span><?php echo !empty($order_info['finished_time'])?date('Y-m-d H:i:s',$order_info['finished_time']):'';?></li>
                <li><span>留言：</span><?php echo $order_info['postscript'];?></li>
            </ul>

        </div>
        <?php if($order_info['order_status']>=ORDER_SHIPPED):?>
        <div class="tt">物流信息</div>
        <div class="nmc">
            <ul class="logistic">
                <li>  
                    <div id="logistics" style="display: block;">
                        物流公司&nbsp;:&nbsp;<?php echo $order_info['express_name'];?>&nbsp;&nbsp;&nbsp;&nbsp;
                        物流单号&nbsp;:&nbsp;<?php echo $order_info['invoice_no'];?>&nbsp;&nbsp;&nbsp;&nbsp;
                        <span id="EditBtn" class="EditOrder">修改</span>
                    </div>

                    <div id="editInfo" style="display: none;">
                        <p class="msg-error"><i class="I-ico">&#xb607;</i> 请仔细检查，并输入正确运单号！</p>
                        物流公司&nbsp;:&nbsp;<select id="select" name="shipping_name">
                                      <option value="0">请选择</option>
                                          <option value="1">顺丰速递</option>
                                          <option value="2">申通速递</option>
                                          <option value="3">圆通速递</option>
                                          <option value="4">天天快递</option>
                                          <option value="5">韵达快递</option>
                                          <option value="6">百世汇通</option>
                                          <option value="7">中通快递</option>
                                          <option value="8">EMS速递</option>
                                          <option value="9">宅急送</option>
                                          <option value="10">全峰快递</option>
                                          <option value="11">城市100</option>
                                          <option value="12">快捷快递</option>
                                          <option value="13">优速快递</option>
                                          <option value="14">国通快递</option>
                                      </select>&nbsp;&nbsp;&nbsp;&nbsp;
                        物流单号&nbsp;:&nbsp;<input type="text" name="invoice_no" class="txt">&nbsp;&nbsp;&nbsp;&nbsp;
                        <button id="cancelBtn" class="btn-cancel">取 消</button>&nbsp;&nbsp;
                        <button id="surelBtn" class="btn-sure">确 定</button>
                    </div>
                </li>
                <li>
                    <a class="look" id="checkExp" data-val="<?php echo $order_info['order_id'];?>" href="javascript:" data-show="0" >点击查看物流</a>
                    <div id="show"></div>
                </li>
            </ul>
        </div>
        <?php endif;?>
        <div class="nmc">
            <table class="u-table">
                <thead>
                    <tr>
                        <th class="shop">商品</th>
                        <th>商品信息</th>
                        <th>价格<span class="s-fc-red">（元）</span></th>
                        <th>数量</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($order_goods as $v){?>
                    <tr>
                        <td>
                            <a href="<?php echo goods_url($v['goods_id']);?>" target="_blank">
                                <img src="<?php echo img_url($v['goods_image']);?>" alt="<?php echo $v['goods_name'];?>" class="pic">
                            </a>
                            <div class="shopInfo">
                                <?php echo $v['goods_name'];?>
                            </div>
                        </td>
                        <td>
                            <?php echo $v['specification'];?><br/>
                        </td>
                        <td><?php echo $v['price'];?></td>
                        <td><?php echo $v['quantity'];?></td>
                    </tr>
                    <?php }?>
                </tbody>
            </table>
            <div class="total">
                合计：<span><?php echo $order_info['discount'];?></span>元
            </div>
        </div>
    </div>
</div>
  

<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>user/js/view.js" charset="utf-8"></script>
<?php $this->load->view('footer');?>
