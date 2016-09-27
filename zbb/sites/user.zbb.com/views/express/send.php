<?php $this->load->view('header');?>

<div class="g-wrap clearfix">
    <div class="g-mn">
        <div class="g-mnc">
            <!--  正文  -->
            <div class="m-tt">
                <span>发货<em></em></span>
            </div>
            <div class="m-opbox">
                确认收货信息并填写运单号
            </div>

            <div class="m-opbox">
                <div class="s-bg-gray m-add">
                    <div class="lst" id="oldAddr">收货信息：<?php echo $order_extm['region_name']?> <?php echo $order_extm['address']?>,<?php echo $order_extm['zipcode']?>,<?php echo $order_extm['consignee']?>,<?php echo $order_extm['mobile']?>,<?php echo $order_extm['tel']?>
                    <input type="hidden" id="region_id" value=""/><input type="hidden" id="region_name" value=""/>
                    </div>
                    <div class="lst">
                        <a href="javascript:void(0);" class="s-fc-blue" id="J_edit_addr">修改收货信息</a>
                    </div>
                    <div class="lst" id="J_addr" style="display:none">
                        <ul class="m-addr">
                            <li>
                                <span class="tt">收货人姓</span>
                                <span class="info"><input type="text" name="consignee" id="consignee" class="txt"  value="<?php echo $order_extm['consignee']; ?>" /><em class="tips">请填写真实姓名</em></span>
                            </li>
                            <li>
                                <span class="tt">所在地区</span>
                                <span class="info" id="region" >
                                    <select id="provice">
                                        <?php foreach ($province as $p){?>
                                            <option name="province_id" id="provice" value="<?php echo $p['region_id'];?>"<?php if($p['region_id']==$order_extm['province_id']){?> selected<?php }?>><?php echo $p['region_name'];?></option>
                                        <?php }?>
                                    </select>
                                    <select id="city" >
                                        <?php foreach ($city as $c){?>
                                            <option name="city_id" id="city" value="<?php echo $c['region_id'];?>"<?php if($c['region_id']==$order_extm['city_id']){?> selected<?php }?>><?php echo $c['region_name'];?></option>
                                        <?php }?>
                                    </select>
                                    <select id="country" >
                                        <?php foreach ($country as $v){?>
                                        <option name="country_id" id="country" value="<?php echo $v['region_id'];?>"<?php if($v['region_id']==$order_extm['country_id']){?> selected<?php }?>><?php echo $v['region_name'];?></option>
                                        <?php }?>
                                    </select>
                                    <input type="hidden" name="region_id" id="region_id" value="<?php echo $order_extm['country_id'];?>"/>
                                    <input type="hidden" name="region_name" id="region_name" value="<?php echo $order_extm['region_name'];?>"/>
                                </span>

                            </li>
                            <li>
                                <span class="tt">详细地址</span>                                
                                <span class="info"><input type="text" name="address" id="address" class="txt" value="<?php echo $order_extm['address']; ?>" /><em class="tips">请填写真实地址，不需要重复填写所在地区</em></span>
                            </li>
                            <li>
                                <span class="tt">邮政编码</span>                                
                                <span class="info"><input type="text" name="zipcode" id="zipcode" class="txt" value="<?php echo $order_extm['zipcode']; ?>" /><em class="tips">邮政编码</em></span>
                            </li>
                            <li>
                                <span class="tt">电话号码</span>                                
                                <span class="info"><input type="text" name="tel" id="tel" class="txt"  value="<?php echo $order_extm['tel']; ?>"  /><em class="tips">固定电话和手机至少填一项</em></span>
                            </li>
                            <li>
                                <span class="tt">手机号码</span>                                
                                <span class="info"><input type="text" id="mobile" name="mobile" class="txt"  value="<?php echo $order_extm['mobile']; ?>" /><em class="tips">手机和固定电话至少填一项</em></span>
                            </li>
                            <li class="f-tar">
                                <button  class="btn-gray" id="J-set0">取消</button>
                                <button  class="btn" data-oid="<?php echo $order_extm['order_id']; ?>" id="J-set1">确定</button>
                            </li>
                        </ul>
                    </div>
                </div>  
            </div>

            <div class="m-order-tt">
                订单编号：<?php echo $order_info['order_sn'];?>         买家：<?php echo $order_info['buyer_name'];?>
            </div>
            <?php foreach ($order_goods as $v){?>
                <?php if(!in_array($v['order_goods_status'],array(ORDER_GOODS_DRAWBACK,ORDER_GOODS_DRAWBACKED))){?>
            <div class="m-order-lst">
                <div class="sd"><a href="<?php echo goods_url($v['goods_id']);?>" target="_blank"><img class="pic" src="<?php echo img_url($v['goods_image']);?>" alt="<?php echo $v['goods_name'];?>"></a></div>
                <div class="extra"><span class="s-fc-red"><?php echo $v['discounted_price'];?></span> X <?php echo $v['quantity'];?></div>
                <div class="nmc">
                    <div class="info"><a href="<?php echo goods_url($v['goods_id']);?>" target="_blank"><?php echo $v['goods_name'];?></a></div>
                    <div class="op">
                        <span class="bute"><?php echo $v['specification'];?></span>
                    </div>
                </div>
            </div>           
           <?php }}?>
            <div class="m-send-info">
                <div class="info">
                    <ul>
                        <li><span>买家留言：</span><?php echo $order_info['postscript'];?></li>
                        <li><span>物流公司：</span>
                            <select name="invoice_no" id="express_name">
                            <option value="0">-- 请选择物流 --</option>
                                <?php $temp=get_ship();?>
                              <?php foreach($temp as $key=>$v){?>
                                <option value="<?php echo $key;?>"><?php echo $key;?></option>
                              <?php } ?>
                            </select></li>
                        <li><span>运单号码：</span><input type="text" class="txt" id="invoice_no"> </li>
                    </ul>
                </div>
                <div class="msg">
                    <span>我的备注：</span>
                    <textarea id="comment">

                    </textarea>
                </div>
                <div class="f-tar clearfix mt">
                    <button class="btn" data-oid="<?php echo $order_extm['order_id']; ?>" id="J_send" data-type=<?php echo $address;?>>发货</button>
                </div>
            </div>

             <!--  正文 END -->
        </div>
    </div>
    <div class="g-sd">
        <?php $this->load->view('menu');?>
    </div>
</div>
<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>user/js/sendGoods.js" charset="utf-8"></script>

<?php $this->load->view('footer');?>