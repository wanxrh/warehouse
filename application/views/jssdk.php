<html>
<head>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
</head>
<script>
wx.config({
    debug: false,
    appId: '<?php echo $appid; ?>',
    timestamp: '<?php echo $timestamp; ?>',
    nonceStr: '<?php echo $nonceStr; ?>',
    signature: '<?php echo $signature; ?>',
    jsApiList: [
		'checkJsApi',
		'onMenuShareTimeline',
		'getLocation',
    ]
});alert('12312');
wx.ready(function(){
	wx.checkJsApi({
        jsApiList: [
            'getNetworkType',
            'previewImage'
        ],
        success: function (res) {
        }
    });
	wx.getLocation({
	    type: 'wgs84', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
	    success: function (res) {
	        var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
	        var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
	        var speed = res.speed; // 速度，以米/每秒计
	        var accuracy = res.accuracy; // 位置精度
	        //alert(latitude+"-"+longitude);
	        window.location.href="/merchant/getlocation?latitude="+latitude+"&longitude="+longitude;
	    },
	    cancel: function (res) {
		    alert('被拒绝了！');
	    	 //window.location.href="index.php?m=Home&c=Index&a=index&cityid=210100";//拒绝
	    }
	});
});
</script>
<body>
近来
</body>
</html>