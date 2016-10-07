<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/mobile/shop.js"></script>

<style type="text/css">
    *{margin:0;padding:0;list-style-type:none;}
    a,img{border:0;text-decoration:none;}
    .top{text-indent: 30px;}
    body{font:12px/180% Arial, Helvetica, sans-serif, "新宋体";background-color: #FFFFFF}

    .container{width:100%;border:solid 1px #e5e3da;margin:100px auto;}
    .subNav{border-bottom:solid 1px #e5e3da;cursor:pointer;font-weight:bold;font-size:14px;color:#999;line-height:28px;padding-left:10px;background:url(/static/images/jiantou1.jpg) no-repeat;background-position:95% 50%}
    .subNav:hover{color:#277fc2;}
    .currentDd{color:#277fc2}
    .currentDt{background-image:url(/static/images/jiantou.jpg);}
    .navContent{display: none;border-bottom:solid 1px #e5e3da;}
    .navContent li a{display:block;heighr:28px;text-align:center;font-size:14px;line-height:28px;color:#333}
    .navContent li a:hover{color:#fff;background-color:#277fc2}
</style>
<script type="text/javascript" src="js/jquery-1.3.2.js"></script>
<script type="text/javascript">
    $(function(){
        $(".subNav").click(function(){
            $(this).toggleClass("currentDd").siblings(".subNav").removeClass("currentDd");
            $(this).toggleClass("currentDt").siblings(".subNav").removeClass("currentDt");
            $(this).next(".navContent").slideToggle(300).siblings(".navContent").slideUp(500);
        })
    })
</script>

</head>

<body class="withFoot">

<div class="">

    <div class="subNav currentDd currentDt">种苗及来源:</div>
    <ul class="navContent " style="display:block">
        <li>
            <p class="top">
               <?php echo $list['product_cource'];?></span>
            </p>
        </li>
    </ul>

    <div class="subNav">产品特点:</div>
    <ul class="navContent">
        <li>
            <p class="top">
                <?php echo $list['product_trait'];?></span>
            </p>
        </li>
    </ul>

    <div class="subNav">养殖场介绍:</div>
    <ul class="navContent">
        <li>
            <p class="top">
                <?php echo $list['farm'];?></span>
            </p>
        </li>
    </ul>

    <div class="subNav">用药防疫记录:</div>
    <ul class="navContent">
        <li>
            <p class="top">
                <?php echo $list['record'];?></span>
            </p>
        </li>
    </ul>
    <div class="subNav">关键节点:</div>
    <ul class="navContent">
        <li>
            <p class="top">
                <?php echo $list['node'];?></span>
            </p>
        </li>
    </ul>
    <div class="subNav">重要事件:</div>
    <ul class="navContent">
        <li>
            <p class="top">
                <?php echo $list['importance'];?></span>
            </p>
        </li>
    </ul>
    <div class="subNav">小视频:</div>
    <ul class="navContent">
        <li>
            <video width="340" height="380" controls="controls" style="">
                <source src="<?php echo '/'.$list['farmer_movie'];?>" type="video/mp4">
                Your browser does not support the video tag.
            </video>
        </li>
    </ul>
    <div class="subNav">照片:</div>
    <ul class="navContent">
        <li>
            <p class="top">
                <img src="<?php echo imgUrl($list['farmer_picture']) ;?>">
            </p>
        </li>
    </ul>
    <div class="subNav">农夫文字信息:</div>
    <ul class="navContent">
        <li>
            <p class="top">
                <?php echo $list['farmer_info'];?>
            </p>
        </li>
    </ul>
    <div class="subNav">报告扫描件:</div>
    <ul class="navContent">
        <li>
            <p class="top">
                <img src="<?php echo '/'.$list['report'] ;?>">
            </p>
        </li>
    </ul>
    <p class="property">
        <span class="colorless">  二维码：</span>
    </p>
    <img src="http://pan.baidu.com/share/qrcode?url=<?php echo base_url().'product/index/'.$list['id'];?>" height="100">
</div>

</body>
</html>