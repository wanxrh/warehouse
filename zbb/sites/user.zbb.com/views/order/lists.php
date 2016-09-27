<?php $this->load->view('header');?>

    <div class="g-wrap clearfix">
        <div class="g-mn">
            <div class="g-mnc">
                <!--  正文  -->
                <div class="m-tt">
                    <span>已卖出宝贝<em></em></span>
                </div>
                <div class="m-opbox">
                    <form action="/orders/lists" method="get" id="form">
                        <div class="lst">
                            <span> 宝贝名称</span> <input type="text" name="goods_name" value="<?php echo isset($goods_name)?$goods_name:''; ?>" class="txt l-txt">
                            <span> 成交时间</span> <input type="text" name="add_time_from" value="<?php echo !empty($add_time_from)?date('Y-m-d',$add_time_from):''; ?>" class="txt" id="add_time_from">-<input type="text" name="add_time_to" value="<?php echo !empty($add_time_to)?date('Y-m-d',$add_time_to):''; ?>" class="txt" id="add_time_to">
                            <?php if($status==''){?>
                            <span> 订单状态</span> <select name="status" id="">
                                <option value="">请选择</option>
                                <?php $order_status_name=order_status_name(); ?>
                                <?php foreach ($order_status_name as $key=>$m){?>
                                    <option value="<?php echo $key;?>" <?php echo $status==$key?'selected':''; ?>><?php echo $m;?></option>
                                <?php } ?>
                            <?php }?>
                            </select>
                        </div> 
                        <div class="lst">
                            <span> 买家名称</span> <input type="text" name="buyer_name" value="<?php echo isset($buyer_name)?$buyer_name:''; ?>" class="txt l-txt">
                            <span> 订单编号</span> <input type="text" name="order_sn" value="<?php echo isset($order_sn)?$order_sn:''; ?>" class="txt l-txt">

                        </div>
                        <div class="lst">
                            <input type="submit" class="submit" value="搜索" >
                            <!--<button class="btn-gray">重置</button>-->
                            <input type="button" class="btn-gray" data-url="/orders/exportxls" value="导出"/>
                        </div>
 
                    </form>
                </div>
                <div class="m-tab-tt">
                    <ul>
                        <li <?php if($status==''){?> class="z-crt"<?php }?>><a href="/orders/lists">全部订单</a></li>
                        <li <?php if($status==ORDER_UNPAY){?> class="z-crt"<?php }?>><a href="/orders/lists?status=<?php echo ORDER_UNPAY;?>">等待买家付款</a></li>
                        <li <?php if($status==ORDER_PAID){?> class="z-crt"<?php }?>><a href="/orders/lists?status=<?php echo ORDER_PAID;?>">等待发货</a></li>
                        <li <?php if($status==ORDER_SHIPPED){?> class="z-crt"<?php }?>><a href="/orders/lists?status=<?php echo ORDER_SHIPPED;?>">买家待收货</a></li>
                        <li><a href="/service/lists">退款退货</a></li>
                        <li <?php if($status==ORDER_FINISHED){?> class="z-crt"<?php }?>><a href="/orders/lists?status=<?php echo ORDER_FINISHED;?>">交易完成</a></li>
                        <li <?php if($status==ORDER_CANCELED){?> class="z-crt"<?php }?>><a href="/orders/lists?status=<?php echo ORDER_CANCELED;?>">已关闭 </a></li>
                    </ul>
                </div>
                <div class="m-opbox">
                    <!--    <input id="all" class="checkall" type="checkbox"> 全选
                        <button class="btn">批量发货</button>
                        <button class="btn">批量标记</button>-->
                </div>
                <table class="u-table">
                    <thead>
                    <tr>
                        <th class="shop"> 宝贝名称</th>
                        <th class="other">价格</th>
                        <th class="other">售后</th>
                        <th class="other">数量</th>
                        <th>买家</th>
                        <th>交易状态</th>
                        <th>实际收款（元）</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <?php
                    $order_status_name=order_status_name();
                    $order_goods_status_name=order_goods_status_name();
                    ?>
                    <?php if($list):?>
                    <?php foreach ($list as $value):?>
                        <tbody>
                        <tr>
                            <th colspan="8"><!-- <input class="checkitem" type="checkbox" value=""> --> <span class="o-tt">订单号:</span><?php echo $value['order_sn'];?><span class="o-tt">成交时间:</span><?php echo date('Y-m-d',$value['add_time']);?></th>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <?php foreach ($order_goods as $item):?>
                                    <?php if($item['order_id']==$value['order_id']):?>
                                        <div class="m-list">
                                            <div class="shop f-fl">
                                                <a href="<?php echo goods_url($item['goods_id']);?>" target="_blank">
                                                    <img src="<?php echo img_url($item['goods_image']);?>" alt="" class="pic" onerror="this.onerror=null,this.src='http://src.zbb0.com/user/img/default.gif' ">
                                                </a>
                                                <div class="shopInfo">
                                                    <?php echo $item['goods_name'];?>
                                                    <p><?php echo $item['specification'];?></p>
                                                </div>
                                            </div>
                                            <div class="f-fl other">
                                                <span class="s-fc-red"><?php echo $item['price'];?></span>
                                            </div>
                                            <div class="f-fl other">
                                                &nbsp;
                                                <?php
                                                $temp=$order_goods_status_name[$item['order_goods_status']];
                                                switch ($item['order_goods_status']){
                                                    case 50:
                                                    case 51:
                                                        echo "<a href='/refund/money?rec_id=".$item['rec_id']."'>".$temp."</a>";
                                                        break;
                                                    case 60:
                                                    case 61:
                                                        echo "<a href='/refund/goods?rec_id=".$item['rec_id']."'>".$temp."</a>";
                                                        break;
                                                }?>
                                            </div>
                                            <div class="f-fl other">
                                                <?php echo $item['quantity'];?>
                                            </div>
                                        </div>
                                    <?php endif;?>
                                <?php endforeach;?>
                            </td>
                            <td class="f-vam"><?php echo $value['buyer_name'];?></td>
                            <td class="f-vam">
                                <span class="s-fc-yellow"><?php echo $order_status_name[$value['order_status']];?></span>
                            </td>
                            <td class="f-vam">
                                <span class="s-fc-red"><?php echo $value['order_amount'];?></span>
                            </td>
                            <td class="f-vam">
                                <?php if($value['order_status']==ORDER_PAID){?>
                                <a href="/express/send?order_id=<?php echo $value['order_id'];?>">发货</a>
                                <?php }?>
                                <?php if($value['order_status']==ORDER_UNPAY){?>
                                <a href="/orders/cancel?order_id=<?php echo $value['order_id'];?>">取消</a>
                                <?php }?>
                                <a href="/orders/view?order_id=<?php echo $value['order_id'];?>">详情</a>
                            </td>
                        </tr>
                        </tbody>
                    <?php endforeach;?>
                    <?php endif;?>
                    <!-- <tfoot>
                        <td colspan="9">
                            <input id="all" class="checkall" type="checkbox"> 全选
                            <button class="btn">批量报名</button>
                        </td>
                    </tfoot> -->
                </table>
                <?php echo $page;?>
                <div class="clearfix">
                    <!-- 分布控件 -->
                </div>
                <!--  正文 END -->
            </div>
        </div>
        <div class="g-sd">
            <?php $this->load->view('menu');?>
        </div>
    </div>
    <script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>user/js/orderManage.js" charset="utf-8"></script>


<?php $this->load->view('footer');?>