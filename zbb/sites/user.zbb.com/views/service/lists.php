<?php $this->load->view('header');?>

    <div class="g-wrap clearfix">
        <div class="g-mn">
            <div class="g-mnc">
                <!--  正文  -->
                <div class="m-tt">
                    <span>退款管理<em></em></span>
                </div>
                <div class="m-opbox">
                    <form action="/service/lists" method="get" id="form">
                        <div class="lst">
                            <span> 订单编号</span> <input type="text" name="order_sn" value="<?php echo isset($order_sn)?$order_sn:''; ?>" class="txt">
                            <span> 退款编号</span> <input type="text" name="refund_sn" value="<?php echo isset($refund_sn)?$refund_sn:''; ?>" class="txt">
                            <span> 买家名称</span> <input type="text" name="buyer_name" value="<?php echo isset($buyer_name)?$buyer_name:''; ?>" class="txt">
                            <span> 退款状态</span> <select name="status" id="">
                                <option value="">全部</option>
                                <?php $temp_arr=get_aftermarket_status();?>
                                <?php foreach ($temp_arr as $key=>$m){?>
                                <option value="<?php echo $key+1;?>" <?php echo $status-1==$key?'selected':''; ?>><?php echo $m;?></option>
                                <?php } ?>
                            </select>
                        </div>
                        <div class="lst">
                            <input type="submit" class="submit" value="搜索" >
                            <input type="button" class="btn-gray" data-url="/service/exportxls" value="导出"/>
                        </div>
                    </form>
                </div>
                <table class="u-table">
                    <thead>
                    <tr>
                        <th> 退款编号</th>
                        <th>订单编号/宝贝名称</th>
                        <th>买家</th>
                        <th>交易金额</th>
                        <th>退款金额</th>
                        <th>申请时间</th>
                        <th>退款状态</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                        <tbody>

                        <?php foreach ($list as $v){?>
                        <tr>
                            <td><?php echo $v['refund_sn'];?></td>
                            <td>编号:<?php echo $v['order_sn'];?>
                                <p class="goods_name"><?php echo $v['goods_name'];?></p>
                            </td>
                            <td><?php echo $v['buyer_name'];?></td>
                            <td><span class="s-fc-red"><?php echo $v['discounted_price'];?></span></td>
                            <td><span class="s-fc-red"><?php echo $v['money'];?></span></td>
                            <td><?php echo date('Y-m-d H:i',$v['apply_time']);?></td>
                            <td><span class="s-fc-yellow"><?php echo $temp_arr[$v['status']];?></span></td>
                            <td>
                                <?php if($v['type']==1){?>
                                    <a href="/refund/money?rec_id=<?php echo $v['rec_id']?>">查看</a>
                                <?php }else{?>
                                    <a href="/refund/goods?rec_id=<?php echo $v['rec_id']?>">查看</a>
                                <?php }?>
                            </td>
                        </tr>
                        <?php }?>
                        </tbody>
                </table>

                <div class="clearfix">
                    <?php echo $page;?>
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