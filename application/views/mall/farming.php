<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/css/mall/public/shop.css" rel="stylesheet" type="text/css">
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/mobile/shop.js"></script>
<style>
    .list-far{width: 100%;background-color: #FFFFFF;}
    .list-far ul{width: 100%;margin: auto;}
    .container .start{position:fixed;top: 200px;left:1px;z-index: 99;}
    .container .end{float: right;position:fixed;top: 200px;right:1px;z-index: 99;}
    .buy_now{ display:block; margin:0 5px; text-align:center;background-color:#e4393c; color:#fff; border-radius:5px; height:40px; line-height:40px; -webkit-box-flex:1}

</style>
<body class="withFoot">
    <div class="container">
        <h1 style="text-align: center">养殖日志</h1>
        <?php if(!$list){ ?>
       		 <div class="empty_container"><p>暂无内容</p></div>
        <?php }else{ ?>

        <!-- 信息 -->
        <div class="list-far">

            <ul id="productContainer" class="navContent">
                <?php foreach ($list as $v){ ?>
                    <li>
                        <!-- 相册 -->
                        <section class="photoList">
                            <ul>
                                <?php foreach (explode(',',$v['picture']) as $t){ ?>
                                    <li>
                                        <img src="<?php echo imgUrl( $t ); ?>"/>
                                    </li>
                                <?php }; ?>
                            </ul>
                <span class="identify">
                <?php foreach (explode(',',$v['picture']) as $t){ ?>
                    <em></em>
                <?php }; ?>
                </span>
                        </section>
                    </li>
                    <br/>
                    <li style="text-indent: 30px;">
                        <?php echo $v['instructions']; ?>
                    </li>
                    <br/>
                    <?php if($v['video']):?>
                    <li>
                        <video width="340" height="380" controls="controls"  style="clear: both;display: block;margin:auto;">
                            <source src="<?php echo '/'.$v['video'];?>" type="video/mp4">
                        </video>
                    </li>
                    <?php endif;?>
                    <li>
                        <?php if(time()<$v['outtime']):?>
                        <script language="javascript" type="text/javascript"> var interval = 300;window.setInterval(function(){ShowCountDown(<?php echo date("Y",$v['outtime']);?>,<?php echo date("m",$v['outtime']);?>,<?php echo date("d",$v['outtime']);?>,'divdown1');}, interval);</script>
                        <label style="color: red;font-size: 18px;">倒计时:</label><div id="divdown1"></div>
                        <?php endif;?>
                        </li>
                    <br/>
                    <a class="buy_now" href="/mall/detail/<?php echo $v['goods_id'];?>">我要领养</a>
                <?php }; ?>
            </ul>


         </div>
        <div class="start"><a href="/mall/farming/<?php echo $start;?>"><img src="/static/images/bg17.png"></a> </div>
        <div class="end"><a href="/mall/farming/<?php echo $end;?>"><img src="/static/images/bg18.png"></a> </div>
        <?php }; ?>
         
        
    </div>
    <!-- 底部导航 -->
    <?php $this->load->view('mall/_footer'); ?>
</body>
<script language="javascript" type="text/javascript">

    function ShowCountDown(year,month,day,divname)
    {
        var now = new Date();
        var endDate = new Date(year, month-1, day);
        var leftTime=endDate.getTime()-now.getTime();
        var leftsecond = parseInt(leftTime/1000);
//var day1=parseInt(leftsecond/(24*60*60*6));
        var day1=Math.floor(leftsecond/(60*60*24));
        var hour=Math.floor((leftsecond-day1*24*60*60)/3600);
        var minute=Math.floor((leftsecond-day1*24*60*60-hour*3600)/60);
        var second=Math.floor(leftsecond-day1*24*60*60-hour*3600-minute*60);
        var cc = document.getElementById(divname);
        cc.innerHTML = day1+"天"+hour+"小时"+minute+"分"+second+"秒";
    }

    $(function(){
        $.WeiPHP.gallery('.photoList','.photoList ul');
        $('.sku_item').click(function(){
            $('#price').text($(this).data('price'));
            $(this).addClass('select').siblings().removeClass('select');
            $(this).find('input').prop("checked",true);
            $(this).siblings().find('input').prop("checked",false);
        })
        //图片预览
        var picList = [];
        $('.photoList li img').each(function(index, element) {
            var picUrl = $(this).attr("src");
            picList[index] = picUrl;
            $(this).click(function(){
                wx.previewImage({
                    current: picUrl, // 当前显示的图片链接
                    urls: picList // 需要预览的图片链接列表
                });
            })
        });

    })

</script>
</html>