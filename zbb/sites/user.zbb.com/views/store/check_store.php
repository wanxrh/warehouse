<?php $this->load->view('header');?>

<div class="g-wrap clearfix">
    <div class="m-step">
        <span class="dot">1
            <h3>入驻店铺信息</h3>
        </span>
        <span class="dot act-2">2
            <h3>企业信息填写</h3>
        </span>
        <span class="dot-s act-3">3
            <h3>　审核中　　</h3>
        </span>
        <span class="dot-s act-4">4
            <h3>开店结果公布</h3>
        </span>
        <div class="line">
            <div class="move-2"></div>
        </div>
    </div>

    <div class="m-store">
        <div class="m-tt">
            <span>认证淘宝店铺<em></em></span>
        </div>

        <div class="cont">
            <div class="info"> 在店铺任意一件商品标题后面添加验证码，确认发布后将该商品的链接填写到下面进行认证，完成认证后再删除标题后的验证码。修改商品标题的路径为：卖家中心-宝贝管理-出售中的宝贝-编辑宝贝-宝贝标题
            </div>
            <div class="info"> 
                <h4>注意事项：</h4>
            <p>1、该验证码是添加在“商品标题”后面，并不是“商品链接”后面。</p>
            <p>2、修改完商品标题后应等待半小时再提交认证，否则可能会认证失败。</p>
            </div>
            <form  action="/store/check_store" method="post" id="myForm">
                <div class="info">
                    <h4>添加验证码示意图:</h4>
                    <p>
                        <img src="<?php echo $this->config->item('domain_static'); ?>user/img/check_bg.png" alt="">
                    </p>
                    <p>验证码：zbb8Nb88</p>
                    <p>商品链接：<input type="text" class="txt max-txt" name="check_url"></p>
                </div>
                <div class="f-tac">
                    <input class="btn-g" type="button" data-url="/store/apply" id="J_pre" value="返回上一步 ">
                    <button class="btn" id="J_next">下一步</button>
                </div>
            </form>
        </div>

<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>user/js/checkStore.js" charset="utf-8"></script>
    </div>
</div>


<?php $this->load->view('footer');?>