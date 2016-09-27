<?php $this->load->view('header');?>

<div class="g-wrap clearfix">
    <div class="m-step">
        <span class="dot">1
            <h3>企业信息填写</h3>
        </span>
        <span class="dot-s act-2">2
            <h3>入驻店铺信息</h3>
        </span>
        <span class="dot-s act-3">3
            <h3>　审核中　　</h3>
        </span>
        <span class="dot-s act-4">4
            <h3>开店结果公布</h3>
        </span>
        <div class="line">
            <div class="move-1"></div>
        </div>
    </div>

    <div class="m-store">
        <div class="m-tt">
            <span>企业信息填写<em></em></span>
        </div>
        <form action="/store/apply" method="post" id="J_form" enctype="multipart/form-data">
        <div class="cont">
            <h3 class="f-tac">申请人信息</h3>
            <ul>
                <li><span class="tt">* 申请人姓名：</span><input type="text" name="uname" class="txt max-txt"></li>
                <li><span class="tt">* 申请人邮箱：</span><input type="text" name="email" class="txt max-txt"></li>
                <li><span class="tt">* 申请人手机：</span><input type="text" name="mobile" class="txt max-txt"></li>
            </ul>
            <h3 class="f-tac">企业法人基本信息</h3>
            <ul>
                <li><span class="tt">* 法人（店主）身份证姓名:</span><input type="text" name="corporation" class="txt max-txt"></li>
                <li><span class="tt">* 法人身份证号码： </span><input type="text" name="id_card" class="txt max-txt"></li>
                <li><span class="tt">* 法人身份证正面：</span>
                    <div class="fileBox">
                        <input id="image1" class="file-text" placeholder="法人身份证正面" name="card_img_1"><label class="file-button" type="button">选择文件</label>
                        <input id="file_name1" class="file" type="file" accept="image/*" onchange="document.getElementById('image1').value=this.value;" name="card_img_1">
                    </div>
                </li>
                <li><span class="tt">* 法人身份证背面：</span>
                    <div class="fileBox">
                        <input id="image2" class="file-text" placeholder="法人身份证背面" name="card_img_1"><label class="file-button" type="button">选择文件</label>
                        <input id="file_name2" class="file" type="file" accept="image/*" onchange="document.getElementById('image2').value=this.value;" name="card_img_2">
                    </div>

                    <div class="tipBox">
                        <span class="triA"></span>
                        <span class="triB"></span>
                        <img src="<?php echo $this->config->item('domain_static'); ?>user/img/forexample.jpg" alt="">
                        <div class="tipTxt">
                            <p>图片要求：</p>
                            <p>1、身份证信息清晰，无遮挡，文字可辨</p>
                            <p>2、支持jpgjpegpnggif格式，大小不超过1M</p>
                        </div>
                    </div>
                </li>
            </ul>
            <div class="f-tac">
                <button class="btn" id="J_next">下一步</button><input type="hidden" name="act" value="add">
            </div>
        </div>
        </form>
    </div>
</div>

<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>user/js/storeCompany.js" charset="utf-8"></script>
<?php $this->load->view('footer');?>