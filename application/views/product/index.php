<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/mobile/shop.js"></script>

<<<<<<< HEAD
<body class="withFoot">
    <div class="container">

        <?php if(!$list){ ?>
       		 <div class="empty_container"><p>暂无内容</p></div>
        <?php }else{ ?>
        <!-- 产品追溯 -->
        <div class="order_list">
        	<ul>

                <li>
                	<a style="display:block" href="admin/product/<?php echo $list['id']; ?>">
                	<p class="top">
                    <span class="c"></span><a href="">种苗及来源:</a> <?php echo $list['product_cource'];?></span>
                    </p>

                    </a>
                    <p class="top">
                        <span class="c"></span><a href="">产品特点:</a> <?php echo $list['product_trait'];?></span>
                    </p>
                    <p class="top">
                        <span class="c"></span><a href="">养殖场介绍:</a> <?php echo $list['farm'];?></span>
                    </p>
                    <p class="top">
                        <span class="c"></span><a href="">用药防疫记录:</a> <?php echo $list['record'];?></span>
                    </p>
                    <p class="top">
                        <span class="c"></span><a href="">关键节点:</a> <?php echo $list['node'];?></span>
                    </p>
                    <p class="top">
                        <span class="c"></span><a href="">重要事件:</a> <?php echo $list['importance'];?></span>
                    </p>
                    <p class="top">
                        <span class="c"></span><a href="">小视频:</a>
                        <video width="340" height="380" controls="controls" style="">
                            <source src="<?php echo '/'.$list['farmer_movie'];?>" type="video/mp4">
                            Your browser does not support the video tag.
                        </video>
                        </span>
                    </p>
                    <p class="top">
                        <span class="c"></span><a href="">照片:</a> <img src="<?php echo imgUrl($list['farmer_picture']) ;?>"></span>
                    </p>
                    <p class="top">
                        <span class="c"></span><a href="">农夫文字信息:</a> <?php echo $list['farmer_info'];?></span>
                    </p>
                    <p class="top">
                        <span class="c"></span><a href="">报告扫描件:</a> <img src="<?php echo '/'.$list['report'] ;?>"></span>
                    </p>
                    <div class="goods_item">
                        <div class="info">

                        </div>
                    </div>
                    <p class="property">
                        <span class="colorless">二维码：</span>
                    </p>
                    <img src="http://pan.baidu.com/share/qrcode?url=<?php echo base_url().'product/index/'.$list['id'];?>" height="100">
                </li>

                
            </ul>
         </div>
        <?php }; ?>
         
        
    </div>	
    <!-- 底部导航 -->
=======
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

>>>>>>> 3012671f0751be5dba2079d67da388bdf860d5b5
</body>
</html>