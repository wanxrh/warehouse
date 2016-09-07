<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/mobile/shop.js"></script>

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
</body>
</html>