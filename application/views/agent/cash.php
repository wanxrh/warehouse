<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<link href="<?php echo $this->config->base_url(); ?>static/css/mall/public/shop.css" rel="stylesheet" type="text/css">
<body>

<div class="container">
    <a href="/agent" class="back_icon">&nbsp;</a>
    <div class="center_nav">
        <a href="javascript:;">余额：<span style="color:red;font-size:20px;"><?php echo $balance; ?></span>元&nbsp(提现周期为3-5个工作日)</a>
    </div>
    <form action="" method="post" onSubmit="return tgSubmit()">
        <input name="id" type="hidden" value="<?php echo $id; ?>">
        <div class="address_form">
            <div class="addressItem tb">
                <label for="alipay" class="flex_1">支付宝：</label>
                <div class="right flex_1">
                    <input type="text" name="alipay" id="alipay" value=""/>
                </div>
            </div>
            <div class="addressItem tb">
                <label for="money" class="flex_1">提现金额：</label>
                <div class="right flex_1">
                    <input type="number" min="0" step="1" max="<?php echo floor($balance); ?>" name="money" id="money" value=""/>
                </div>
            </div>
            <?php if($balance > 0){ ?>
            <div class="m_15" style="position:static">
                <button class="btn" type="submit">确定</button>
            </div>
            <?php }; ?>
        </div>
    </form>
</div>
<script type="text/javascript">
    function tgSubmit() {
        if($('#alipay').attr('max') == 0){
            return false;
        }
        var alipay = $('#alipay').val();
        if ($.trim(alipay) == "") {
            $.Dialog.fail('支付宝账号不能为空');
            return false;
        }
        var money = $('#money').val();
        if ($.trim(money) == "" || money<=0 || money > $('#alipay').attr('max')) {
            $.Dialog.fail('提现金额最大为'+$('#money').attr('max'));
            return false;
        }
        return true;
    }
</script>
</body>
</html>