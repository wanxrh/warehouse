<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <title>退货退款详情页</title>
    <link href="<?php echo $this->
    config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
    <link href="<?php echo $this->
    config->item('domain_static'); ?>system/css/common.css" rel="stylesheet" type="text/css" />
    <link href="<?php echo $this->
    config->item('domain_static'); ?>system/css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="u-bd-tt">
    <span>位置：</span>
    <ul >
        <li>申诉管理</li>
        <li>
            <a href="/appeal/lists">未处理申诉</a>
        </li>
        <li>详情</li>
    </ul>
</div>
<div class="g-mnr">
    <div class="g-mn">
        <div class="g-mnc">
            <?php if($appeal_info['status']==0){ ?>
            <div class="u-time" id="colockbox">
                <p>剩余时间:</p>
                <input id="time" type="hidden" value="<?php echo time();?>">
                <div class="j-timer time" data-time="<?php echo $refund_info['countdown'];?>">-</div>
            </div>
            <?php }?>
            <div class="m-hd">
                <h2>操作日记</h2>
            </div>
            <div class="m-ct">

                <div class="m-box">
                    <?php if(isset($log_arr)){?>
                    <?php foreach ($log_arr as $v){?>
                    <dl>
                        <dt><?php echo $v['node_time'];?></dt>
                        <dd><?php echo isset($v['node'])?$v['node']:'';?></dd>
                        <?php if(isset($v['content'])){?>
                        <?php foreach ($v['content'] as $m){?>
                        <dd><label><?php echo $m;?></label></dd>
                            <?php }}?>
                        <?php if(isset($v['proof'])){?>
                        <dd>凭证:</dd>
                        <dd>
                            <?php foreach ($v['proof'] as $m){?>
                                <img src="<?php echo img_url($m);?>" alt="" id="imgShow" onerror="this.onerror=null,this.src='http://src.zbb0.com/user/img/default.gif' " width="60" height="60">
                            <?php }?>
                        </dd>
                        <?php }?>
                    </dl>
                        <?php }?>
                    <?php }?>
                </div>

            </div>
            <div class="m-btn">
                <?php if($appeal_info['status']==0){ ?>

                    <?php if($refund_info['type']==1){ ?>
                    <button class="u-btn2" id="J_close" data-rid="<?php echo $appeal_info['appeal_id'];?>">关闭退款申请</button>
                    <button class="u-btn2" id="J_refund" data-rid="<?php echo $appeal_info['appeal_id'];?>">退款给买家</button>
                    <?php }?>
                    <?php if($refund_info['type']==2){ ?>
                        <?php if($is_return){?>
                <!-- <button class="u-btn2" id="J_refund_seller" data-rid="<?php echo $appeal_info['appeal_id'];?>">货款给卖家</button>-->
                            <button class="u-btn2" id="J_refund" data-rid="<?php echo $appeal_info['appeal_id'];?>">退款给买家</button>
                        <?php }else{?>
                            <button class="u-btn2" id="J_close" data-rid="<?php echo $appeal_info['appeal_id'];?>">关闭退款申请</button>
                            <button class="u-btn2" id="J_agree" data-rid="<?php echo $appeal_info['appeal_id'];?>">同意退货</button>
                        <?php }?>
                    <?php }?>
                <?php }?>
            </div>
        </div>

    </div>
    <div class="g-sd">
        <div class="m-list">
            <h2>退款退货申请</h2>
            <dl>
                <dt>
                    <img src="<?php echo img_url($refund_info['goods_image']);?>" alt="<?php echo $refund_info['goods_name'];?>" id="imgShow" onerror="this.onerror=null,this.src='http://src.zbb0.com/user/img/default.gif' " width="60" height="60"></dt>
                <dd>
                    <p><?php echo $refund_info['goods_name'];?></p>
                </dd>
                <dd>
                    <?php echo $refund_info['specification'];?>
                </dd>
            </dl>
            <ul>
                <li>
                    <span>订单编号:</span>
                    <label><?php echo $refund_info['order_sn'];?></label>
                </li>
                <li>
                    <span>商品价格:</span>
                    <label><?php echo $refund_info['price'];?>*<?php echo $refund_info['quantity'];?></label>
                </li>
                <li class="li-btn">
                    <a href="/order/info?id=<?php echo $refund_info['order_id'];?>" class="u-btn2">查看订单详情</a>
                </li>
            </ul>
        </div>
        <div class="m-list sdc">
            <ul>

                <li>
                    <span>退款金额:</span>
                    <label><?php echo $refund_info['money'];?>元</label>
                </li>
                <li>
                    <span>原&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;因:</span>
                    <label><?php echo $reason_name['reason'];?></label>
                </li>
                <li>
                    <span>要&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;求:</span>
                    <label><?php echo $refund_info['type']==2?'退货退款':'退款';?></label>
                </li>
                <li>
                    <span>货物状态:</span>
                    <label><?php echo order_status_name()[$refund_info['order_status']];?></label>
                </li>
                <li>
                    <span>说&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;明:</span>
                    <label><?php echo $refund_info['supplement'];?></label>
                </li>
            </ul>
        </div>

    </div>
</div>
<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>common/js/seajs/sea.js"></script>
<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>system/js/detail.js"></script>

</body>
</html>