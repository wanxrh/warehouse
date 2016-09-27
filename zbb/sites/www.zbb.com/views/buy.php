<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>众宝贝-值得买</title>
    <meta name="description" content="众宝贝  一个只卖折扣商品的平台, 100%保证正品！!">
    <meta name="keywords" content="众宝贝,商品特卖,品牌特卖">
    <!-- <link rel="shortcut icon" type="image/ico" href="<?php echo $this->config->item('domain_static'); ?>common/img/favicon.ico" /> -->
    <link  type="text/css" href="<?php echo $this->config->item('domain_static'); ?>web/css/buy.css" rel="stylesheet"/>
</head>
<body>
    <div class="g-hd">
        <div class="g-wrap clearfix">
            <a href="<?php echo $this->config->item('domain_www'); ?>" target="_blank" ><h1 class="m-logo"></h1></a>
            <div class="m-ad">
                <ul class="s-icoT">
                    <li class="ico-n">每日上新</li>
                    <li class="ico-p">专业买手团砍价</li>
                    <li class="ico-b">担保交易</li>
                    <li class="ico-q">7天无理由退货</li>
                </ul>
            </div>
        </div>
    </div>

    <div class="g-nav">
        <div class="g-wrap">
            <ul class="clearfix">
                <li><a href="<?php echo $this->config->item('domain_www'); ?>">首页</a></li>
                <li><a href="/baoyou-3.html">9.9元包邮</a></li>
                <li><a href="/zdm.html" class="z-crt">值得买</a></li>                                 
                <li><a href="/gyh.html">手机更优惠</a></li>
            </ul>
        </div>
    </div>
    
    <div class="g-ad">
        <div class="ct">
            <img src="<?php echo $this->config->item('domain_static'); ?>web/img/ad.jpg" alt="">
        </div>
    </div>

    <div class="g-mod g-wrap j_ImgLoad">
        <div class="m-tt">
            <span class="ico"></span> <span class="s-color">新品热卖</span><span class="tip">今日更新<span class="s-color"><?php echo $new_total;?></span>款宝贝</span>
        </div>
        <div class="m-ct">
            <ul class="g-list">
              <?php foreach ($goods_list as $v) {?>
               <li>
                   <div class="pic"><a href="<?php echo $v['url'];?>" target="_blank"><img src="<?php echo $this->config->item('domain_static'); ?>common/img/default.jpg" data-url="<?php echo $v['img'];?>" alt="<?php echo $v['title'];?>"></a></div>
                   <div class="cont">
                       <h2 class="tt"><a href="<?php echo $v['url'];?>" target="_blank"><?php echo $v['title'];?></a></h2>
                       <div class="price">
                           <span class="crt"><em>&yen;</em><?php echo $v['price'];?></span>
                           <del><em>&yen;</em><?php echo $v['cost_price'];?></del>
                           <sapn class="agio"><?php echo $v['discount'];?>折</sapn>
                       </div>
                   </div>
               </li>
              <?php }?>

            </ul>   
        </div>
    </div>

    <div class="g-wrap">
        <div class="g-tip">
            <div class="m-tt">
                <spna class="txt">
                    <span class="m-l"></span>更多超值宝贝，请下载手机客户端
                    <span class="m-r"></span>
                </spna>
            </div>
            <div class="m-ct">
                <div class="m-tip">
                    <img src="<?php echo $this->config->item('domain_static'); ?>web/img/phone.png" alt="" class="phone">
                    <div class="txt">
                        <h3>众宝贝手机客户端</h3>
                        <p>海量小编验货宝贝</p>
                        <p class="other">客户端购买</p>
                        <p class="other">更方便、更快捷、更省钱！</p>
                    </div>
                </div>
                
                <div class="m-dld">
                    <div class="m-code">
                        <img src="<?php echo $this->config->item('domain_static'); ?>web/img/code.jpg" alt="">
                    </div>
                    <div class="m-lst">
                        <ul class="s-icoP">
                            <li><a href="#"><span></span>Android下载</a></li>
                            <li><a href="#"><span class="ios"></span>iPhone下载</a></li>
                        </ul>
                    </div>
                </div>
                
            </div>
        </div>       
    </div>

    <div class="g-ft">
        <div class="g-wrap">
            <a href="#">商家入驻</a>
            <a href="#">关于我们</a>
            <a href="#">用户协议</a>
            <a href="#">帮助中心</a>
            <a href="#">法律声明</a>
            <p class="m-cprt">
                © 2016  zhongbaobei.com 
            </p>
        </div>
    </div>

    <a href="tencent://message/?uin=2729811264&Site=zhongbaobei.com&Menu=yes" class="m-online"></a>
    <script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>common/js/seajs/sea.js" charset="utf-8"></script>
    <script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>web/js/main.js" charset="utf-8"></script>
</body>
</html>