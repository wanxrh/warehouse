<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/css/mall/public/shop.css"></script>
<body class="withFoot">
<div class="container">
    <div class="order_detail">

        <div class="order">

            <img src="<?php echo imgUrl($goods_datas['cover']); ?>"/>
            <p class="info">
                <?php echo $goods_datas['title']; ?>
                <br/>数量：<?php echo $coupon['number']; ?>
                <br/>价值: <?php echo $goods_datas['price']*$coupon['number']; ?>元
            </p>
            <br />

        </div>
        <div class="order_action">
            <?php if($coupon['status'] == 0){ ?>
                <?php if($super){ ?>
                    <form id="form" action="" method="post">
                        <input name="id" type="hidden" value="<?php echo $form['id'] ?>">
                        <input name="time" type="hidden" value="<?php echo $form['time'] ?>">
                        <input name="sign" type="hidden" value="<?php echo $form['sign'] ?>">
                    </form>
                    <a href="javascript:;" onclick="$('#form').submit();" class="btn">确认兑换券</a>
                <?php }else{ ?>
                    <h3 class="mb_10" style="color: red;">该纸质兑换券点击“确认”后，立即变成电子兑换券</h3>
                    <h3 class="mb_10" style="color: red;">（注意：变成电子券之后，纸质兑换券就会失效）</h3>
                    关注老山圈公众号，就可使用电子券~
                    <div class="m_15">
                        <img src="<?php echo imgUrl('public/lsqqr.jpg'); ?>"/>
                    </div>
                    <form id="form2" action="/coupon/online" method="post">
                        <input name="id" type="hidden" value="<?php echo $form['id'] ?>">
                        <input name="time" type="hidden" value="<?php echo $form['time'] ?>">
                        <input name="sign" type="hidden" value="<?php echo $form['sign'] ?>">
                    </form>
                    <a href="javascript:;" onclick="$('#form2').submit();" class="btn">确认</a>
                <?php }; ?>
            <?php }elseif ($coupon['status'] == 1){ ?>
                <?php if($super){ ?>
                    <form id="form" action="" method="post">
                        <input name="id" type="hidden" value="<?php echo $form['id'] ?>">
                        <input name="time" type="hidden" value="<?php echo $form['time'] ?>">
                        <input name="sign" type="hidden" value="<?php echo $form['sign'] ?>">
                    </form>
                    <a href="javascript:;" onclick="$('#form').submit();" class="btn">确认兑换券</a>
                <?php }else{ ?>
                    关注老山圈公众号，更多的原生态产品等着你哦~
                    <div class="m_15">
                        <img src="<?php echo imgUrl('public/lsqqr.jpg'); ?>"/>
                    </div>
                <?php }; ?>
            <?php }else{ ?>
                <h3 class="mb_10">兑换券已使用</h3>
                关注老山圈公众号，更多的原生态产品等着你哦~
                <div class="m_15">
                    <img src="<?php echo imgUrl('public/lsqqr.jpg'); ?>"/>
                </div>
            <?php }; ?>
        </div>

    </div>
</div>
<!-- 底部导航 -->
</block>
</body>
</html>