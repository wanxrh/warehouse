<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<title>衣扮网-app下载页</title>
<link rel="stylesheet" href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css">
<link rel="stylesheet" href="<?php echo $this->config->item('domain_static'); ?>web/css/app.css">
<style>
.section { text-align: center; font: 50px "Microsoft Yahei"; color: #fff;}
.section2 p { position: relative; left: -120%;}
.section3 p { position: relative; bottom: -120%;}
.section4 p { display: none;}
</style>

<script src="<?php echo $this->config->item('domain_static'); ?>common/js/jquery-1.11.0.min.js"></script>
<script src="<?php echo $this->config->item('domain_static'); ?>web/js/jquery.fullPage.app.js"></script>
<script src="http://cdn.staticfile.org/jquery-easing/1.3/jquery.easing.min.js"></script>
<script>
$(function(){
    $('#dowebok').fullpage({
        sectionsColor:['#8bdbda', '#fde5e1', '#ffd569', '#f74f70'],
         anchors: ['page1', 'page2'],
        afterLoad: function(anchorLink, index){
            if(index == 2){
                $('.act2').find('.down-app-bd').delay(500).animate({
                    left: '0'
                }, 1500, 'easeOutExpo');
            }
            
        },
        onLeave: function(index, direction){
            if(index == '2'){
                $('.act2').find('.down-app-bd').delay(500).animate({
                    left: '-120%'
                }, 1500, 'easeOutExpo');
            }
        }
    });
});
</script>
</head>

<body>
<div id="top" class="g-hd">
        <div class="g-cont clearfix">
            <div class="logo">
                <a href="/" target="_blank"><img src="<?php echo $this->config->item('domain_static'); ?>web/img/app_logo.png" alt="衣扮网" /></a>
            </div>
            <a href="<?php echo $this->config->item('domain_www'); ?>" class="back-index" target="_blank">返回衣扮网首页>></a>
        </div>
</div>

<div class="g-wrap Appload">
        <h3 class="load-hd">
            下载手机客服端
        </h3>

        <div class="load-bd">
            <a target="_blank" href="<?php echo $this->config->item('domain_download'); ?>apk/YBAPP.apk" class="android-app down-btn"><span class="android-app-ico"></span><p>Android App 下载</p></a>
            <a href="javascript:;" target="_blank" class="iphApp down-btn"><span class="iphApp-icon"></span><p class="qidai">iPhone App 下载 <br>    
            敬请期待！</p></a>

            <div class="QR-code">
                <div class="QR-code-img">
                    <img alt="扫描二维码" src="<?php echo $this->config->item('domain_static'); ?>web/img/ewm_logo.png">
                </div>
                <p>手机扫描二维码下载</p>
            </div>
        </div>
</div>
<div id="dowebok">
    <div class="section act1">
        <!--[if lt IE 7]>
        <div class="kie-bar">
            您目前的浏览器版本过低，可能导致网站部分功能无法正常使用，建议尽快升级您的浏览器。点击
            <a href="http://www.microsoft.com/zh-cn/download/internet-explorer-7-details.aspx" target="_blank">免费升级</a>
            或下载使用
            <a href="http://rj.baidu.com/soft/detail/14744.html?ald" target="_blank" title="谷歌浏览器">谷歌浏览器</a>
        </div>
        <style>
            .kie-bar {
                height: 24px; line-height: 24px; font-weight: normal; text-align: center; border-bottom: 1px solid #fce4b5;
                background-color: #FFFF9B; color: #e27839; position: relative; font-size: 14px; text-shadow: 0 0 1px #efefef; padding: 5px 0;
                z-index:999;
            }
            .kie-bar a {color: #08c; text-decoration: none; margin: 0 7px;}
        </style>
        <![endif]-->
        <div class="g-cont clearfix">
           
               <div class="m-left-one">
                   <span class="stars"></span>
                   <span class="moblie-one"></span>

                   <!-- <span class="shadow-one">665666</span> -->
               </div>
               <div class="m-center-one">
                   <span class="text-one"></span>
                   <span class="figure-one"></span>
                   <span class="rhomb-one"></span>
               </div>
          
           
        </div>
        <div class="g-buttom"></div>
        <a href="#page2" class="arrow" id="arrow"></a>
    </div>

    <div class="section act2">
        <!--[if lt IE 7]>
        <div class="kie-bar">
            您目前的浏览器版本过低，可能导致网站部分功能无法正常使用，建议尽快升级您的浏览器。点击
            <a href="http://www.microsoft.com/zh-cn/download/internet-explorer-7-details.aspx" target="_blank">免费升级</a>
            或下载使用
            <a href="http://rj.baidu.com/soft/detail/14744.html?ald" target="_blank" title="谷歌浏览器">谷歌浏览器</a>
        </div>
        <![endif]-->    
        <div class="g-cont clearfix">
           
               <div class="m-left-two">
                   <span class="moblie-two"></span>
               </div>
               <div class="m-center-two">
                   <span class="circle"></span>
                   <span class="text-two"></span>
                   <span class="figure-two"></span>
                   <span class="rhomb-two"></span>
                   <span class="round-two"></span>
               </div>
        </div>
        <div class="g-buttom"></div>
        <a href="#page3" class="arrow" id="arrow"></a>
    </div>
</div>
</body>
</html>