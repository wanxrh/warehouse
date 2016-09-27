<div class="g-ft">
   
   <div class="g-wrap">
        <div class="g-grid clearfix">
            <p class="qrcode">

            </p>
            <ul class="snav">
                <li>
                    <h3>购物指南</h3>
                    <p><a href="#">购物流程</a></p>
                    <p><a href="#">会员注册</a></p>
                    <p><a href="#">常见问题</a></p>
                </li>
                 <li>
                    <h3>支付方式</h3>
                    <p><a href="#">互联支付</a></p>
                    
                </li>
                 <li>
                    <h3>关于我们</h3>
                    <p><a href="#">关于我们</a></p>
                    <p><a href="#">联系我们</a></p>
                   
                </li>
                 <li>
                    <h3>使用协议</h3>
                    <p><a href="#">买家规则</a></p>
                    <p><a href="#">用户协议</a></p>
                    <p><a href="#">法律声明</a></p>
                </li>
                 <li>
                    <h3>友情链接</h3>
                    <p><a href="#">试客联盟</a></p>
                    <p><a href="#">众划算</a></p>
                    <p><a href="#">众夺宝</a></p>
                </li>


            </ul>

        </div>
        <div class="g-grid clearfix">
            <p class="copyRight">COPYRINGHT 2016 众宝贝 http://www.zhongbaobei.com/ 版权所有&nbsp;&nbsp;&nbsp;&nbsp; 桂B2-20110047号&nbsp;&nbsp;&nbsp;<a href="http://www.miibeian.gov.cn">桂ICP备07009935号-27</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a target="_blank" href="http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=45010702000157" class="f-record">桂公网安备45010702000157号</a></p>
        </div>        
    </div>

</div>

    <div class="g-remake" id="J_make"></div>
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

</body>
</html>