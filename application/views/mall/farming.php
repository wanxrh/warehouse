<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/mobile/shop.js"></script>
<style>
    .list-far{background-color: #FFFFFF}
    .list-far ul{width: 80%;margin: auto;}
    .start{position: absolute;margin-top: 60%;float: left;}
    .end{margin-top: 60%;float: right;}
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
            <div class="start"><a href="/mall/farming/<?php echo $start;?>"><img src="/static/images/bg17.png"></a> </div>
            <div class="end"><a href="/mall/farming/<?php echo $end;?>"><img src="/static/images/bg18.png"></a> </div>
            <ul id="productContainer" class="navContent">
                <?php foreach ($list as $v){ ?>
                    <li class="">
                        <img src="<?php echo imgUrl($v['picture']) ?>"/>
                    </li>
                    <br/>
                    <li class="">
                        <?php echo $v['instructions']; ?>
                    </li>
                    <br/>
                    <li>
                        <video width="340" height="380" controls="controls">
                            <source src="<?php echo '/'.$v['video'];?>" type="video/mp4">
                        </video>
                    </li>
                    <a class="buy_now" href="javascript:;">我要领养</a>
                <?php }; ?>
            </ul>
         </div>
        <?php }; ?>
         
        
    </div>
    <!-- 底部导航 -->
    <?php $this->load->view('mall/_footer'); ?>
</body>
</html>