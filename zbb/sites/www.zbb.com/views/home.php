<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>众宝贝  一个只卖折扣商品的平台, 100%保证正品！</title>
    <meta name="description" content="众宝贝  一个只卖折扣商品的平台, 100%保证正品！!">
    <meta name="keywords" content="众宝贝,商品特卖,品牌特卖">
    <link href="<?php echo $this->config->item('domain_static'); ?>web/css/index.css" rel="stylesheet"/>
    <link href="<?php echo $this->config->item('domain_static'); ?>web/css/reg.css" rel="stylesheet"/>

    <!-- <link rel="shortcut icon" type="image/ico" href="<?php echo $this->config->item('domain_static'); ?>common/img/favicon.ico" /> -->
</head>
<body>
    <div class="m-hd">
        <div class="g-wrap clearfix">
            <a href="<?php echo $this->config->item('domain_www'); ?>" target="_blank" ><h1 class="m-logo"></h1></a>
            <div class="m-nav">
                <ul class="clearfix">
                    <li class="z-crt"><a href="#">众宝贝APP下载</a> <span></span></li>
                    <li><a href="#">微信公众号</a></li>
                    <li><a href="/zdm.html">众宝贝商场</a></li>
                    <li><a href="/zs.html">我要开店</a></li>
                    <li><a href="#" id="J_dld">商家登录</a></li>
                </ul>
            </div>
        </div>
    </div>

    <div class="m-bd">
        <div class="bg">
            <div class="g-wrap">
                <div class="m-ct">
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
        <div class="g-wrap">
            <div class="m-mn clearfix">
                <ul class="s-icoT">
                    <li class="ico-n">每日上新</li>
                    <li class="ico-p">专业买手团砍价</li>
                    <li class="ico-b">担保交易</li>
                    <li class="ico-q">7天无理由退货</li>
                </ul>
            </div>
        </div>
        <div class="m-phone"></div>
    </div>

    <div class="m-ft">
        <div class="g-wrap">
            <div class="QQ">
                <a href="tencent://message/?uin=2729811264&Site=zhongbaobei.com&Menu=yes"></a>
            </div>
            <div class="m-cprt">
                <a href="#">一站集团</a>
                <a href="#">试客联盟</a>
                <a href="#">众划算</a>
                <a href="#">互联支付</a> 
                <a>|</a>            
                <a href="#">关于我们</a>
                <a href="#">用户协议</a>
                <a href="#">商家入驻</a>
                <a href="#">帮助中心</a>
                <a href="#">法律声明</a>
                <p>Copyright © 2016  zhongbaobei.com 南宁一站网网络技术有限公司  地址：广西南宁市西乡塘区高新大道62号光辉大厦6楼</p>  
                <p>桂ICP备07009935号</p>
            </div>   
        </div>    
        <div class="g-wrap verify-ico">
        <a class="miibeian" href="http://www.miibeian.gov.cn/" title="经营性网站备案信息"></a>
        <a  class="safeguard" href="http://weiquan.zhongbaobei.com/" title="消费权益维护网站"></a>
        </div> 
    </div>

    <div class="g-remake" id="J_make">
    </div>
    <div class="g-pop" id="J_pop">
        <span class="colse">X</span>
        <div class="m-tt">
            <ul class="clearfix" id="J_tab">
                <li class="z-crt">登录</li>
                <li>商家注册</li>
            </ul>
        </div>
        <div class="s-gray m-dld" id="J_tab_ct">
            <ul>
                <li class="m-tips" id="J_tips">用户名不正常</li>
                <li><input type="text" class="m-txt" placeholder="输入用户名" id="d_un"></li>
                <li><input type="password" class="m-txt i-pws" placeholder="输入密码" id="d_pw"></li>
                <li class="f-tar"><a href="#">忘记密码？</a></li>
                <li><button class="btn" id="J_log">登 录</button></li>
            </ul>

            <ul style="display:none">
                <li id="J_reg_tips" class="m-tips">用户名不正常</li>
                <li><input type="text" class="m-txt " placeholder="输入用户名" id="un"></li>
                <li><input type="password" class="m-txt i-pws" placeholder="输入密码" id="pws"></li>
                <li class="rst">建议英文和数字组合</li>
                <li><input type="password" class="m-txt i-pws" placeholder="输入密码" id="rpws"></li>
                <li class="rst">两次密码必须一致</li>
                <li><input type="text" class="m-txt m-ipt" id="vcode"> <img src="<?php echo $this->config->item('domain_www'); ?>reg/vcode" alt="验证码" class="code" onclick="this.src='<?php echo $this->config->item('domain_www'); ?>reg/vcode?d='+Math.random();"></li>
                <li class="rst">请输入验证码，不区分大小写！</li>
                <li><input type="text" class="m-txt i-phone" placeholder="输入手机号码" id="phone"></li>
                <li class="rst">输入11位有效手机号</li>
                <li><input type="text" class="m-txt m-ipt" id="pcode"> <button class="p_btn btn-Disable">获取短信验证码</button></li>
                <li><button class="btn btn-Disable" disabled="disabled" id="J_reg">商家注册</button></li>
            </ul>
        </div>
    </div>


    <script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>common/js/seajs/sea.js" charset="utf-8"></script>
    <script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>web/js/reg.js" charset="utf-8"></script>
</body>
</html>                        