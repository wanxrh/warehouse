<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/css/mall/public/shop.css"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
    wx.config({
        debug: false,
        appId: '<?php echo $signPackage["appId"];?>',
        timestamp: <?php echo $signPackage["timestamp"];?>,
        nonceStr: '<?php echo $signPackage["nonceStr"];?>',
        signature: '<?php echo $signPackage["signature"];?>',
        jsApiList: [
            // 所有要调用的 API 都要加到这个列表中
            'checkJsApi',
            'openLocation',
            'getLocation',
            //'onMenuShareTimeline',
            'onMenuShareAppMessage'
        ]
    });

    wx.onMenuShareAppMessage({
        title: '<?php echo $news['Title'];?>',
        desc: '<?php echo $news['Description'];?>',
        link: '<?php echo $news['Url'];?>',
        imgUrl: '<?php echo $news['PicUrl'];?>',
        trigger: function (res) {
            // 不要尝试在trigger中使用ajax异步请求修改本次分享的内容，因为客户端分享操作是一个同步操作，这时候使用ajax的回包会还没有返回
            // alert('用户点击发送给朋友');
        },
        success: function (res) {
            // alert('已分享');
        },
        cancel: function (res) {
            // alert('已取消');
        },
        fail: function (res) {
            // alert(JSON.stringify(res));
        }
    });
</script>
<!--<style>
    #shareit {
        -webkit-user-select: none;
        position: absolute;
        width: 100%;
        height: 100%;
        background: rgba(0,0,0,0.85);
        text-align: center;
        top: 0;
        left: 0;
        z-index: 105;
    }
    #shareit img {
        max-width: 100%;
    }
    .arrow {
        position: absolute;
        right: 10%;
        top: 5%;
    }
</style>-->
<body class="withFoot">
<!--<div id="shareit" >-->
<!--    <img class="arrow" src="http://dev.vxtong.com/cases/nuannan/imgs/share-it.png">-->
<!--</div>-->

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
            关注公众号，就可使用兑换券!
            <div class="m_15">
                <img src="<?php echo imgUrl('public/lsqqr.jpg'); ?>"/>
            </div>
        </div>

    </div>
</div>
<!-- 底部导航 -->
</block>
</body>
</html>