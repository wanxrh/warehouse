<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/css/mall/public/shop.css"></script>
<body class="withFoot">
<div class="container">
    <div class="order_detail">

        <div class="order">
            <?php foreach ($goods_datas as $v){ ?>
                <img src="<?php echo imgUrl($v['cover']); ?>"/>
                <p class="info">
                    <?php echo $v['title']; ?>
                    <br/>购买数量：<?php echo $v['num']; ?>
                    <br/>价格:<?php echo $v['price']; ?>元
                </p>
                <br />
            <?php }; ?>
        </div>
        <div class="order_action">
            关注公众号，就可使用兑换券
            <div class="m_15">
                <img src="http://pan.baidu.com/share/qrcode?w=200&h=200&url=http://www.lao337.com/mall/confirmCoupon?id=1&time=1471358718&sign=dfae229e72e4e3207adefbbff88bfd29"/>
            </div>
            <?php if($coupon['owner_id'] != $user_id){ ?>
                <?php if($coupon['status'] == 0){ ?>
                    <h3 class="mb_10">兑换券未领取</h3>
                    <p class="wait_pay"></p>
                    <form id="form" action="" method="post">
                        <input name="id" type="hidden" value="<?php echo $form['coupon_id'] ?>">
                        <input name="time" type="hidden" value="<?php echo $form['time'] ?>">
                        <input name="sign" type="hidden" value="<?php echo $form['sign'] ?>">
                    </form>
                    <a href="javascript:;" onclick="$('#form').submit();" class="btn">领取</a>
                <?php }elseif ($coupon['status'] == 1){ ?>
                    <h3 class="mb_10">兑换券已经使用</h3>
                <?php }elseif ($coupon['status'] == 2){ ?>
                    <h3 class="mb_10">兑换券已被领取</h3>
                <?php }; ?>
            <?php }; ?>

        </div>

    </div>
</div>
<!-- 底部导航 -->
</block>
</body>
</html>