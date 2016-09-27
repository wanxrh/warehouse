<?php $this->load->view('header');?>

<div class="g-wrap clearfix">
    <div class="m-step">
        <span class="dot">1
            <h3>企业信息填写</h3>
        </span>
        <span class="dot act-2">2
            <h3>入驻店铺信息</h3>
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
            <span>店铺信息<em></em></span>
        </div>

        <form action="/store/under_review" method="post" enctype="multipart/form-data" id="myForm">
        <div class="cont">
            <ul>
                <li><span class="tt">* 店铺名称：</span><input type="text" name="store_name" class="txt max-txt"></li>
                <li><span class="tt">* 主营类目：</span> 
                    <select name="cate_1" class="select">
                        <option selected="selected">-- 请选择商品分类 --</option>
                        <?php foreach ($cate as $v){?>
                        <option value="<?php echo $v['cate_id'];?>"><?php echo $v['cate_name'];?></option>
                        <?php }?>
                    </select> 
                    <select name="cate_2" class="select" style="display:none">
                        <option  value="0">第二类目</option>
                    </select>
                </li>
                <li><span class="tt">* 店铺类型：</span>
                    <select name="store_type" class="select">
                        <option value="1">旗舰店</option>
                        <option value="2">卖场(多个品牌)</option>
                        <option value="3">专卖店</option>
                        <option value="4">专营店</option>
                        <option value="5">C店</option>
                    </select>
                </li>
            </ul>
            <ul id="J_other">
                <li><span class="tt">* 公司名称：</span><input type="text" name="company_name" class="txt max-txt"></li>
                <li><span class="tt">* 营业执照注册号： </span><input type="text" name="license" class="txt max-txt"></li>
                <li><span class="tt">* 营业期限：</span><input type="text" name="start_time" class="txt" id="add_time_from"> 至 <input type="text" name="end_time" class="txt" id="add_time_to"> <input type="checkbox" name="start_end" value="1">无期限</li>
                <li><span class="tt">*上传企业相关证件图片：</span> <label><input type="radio"  name="typeA" value="1" checked="checked">三证</label>　<label><input type="radio" name="typeA" value="2">三证合一</label></li>
                <li id="J_three">
                    <ul>
                        <li><span class="tt">* 公司营业执照：</span>
                            <div class="fileBox">
                            <input id="image1" class="file-text" placeholder="上传公司营业执照" name="company_img_1"><label class="file-button" type="button">选择文件</label>
                            <input id="file_name1" class="file" type="file" accept="image/*" onchange="document.getElementById('image1').value=this.value;" name="image_1">
                            <p class="tip">证件信息清晰，无遮挡，文字可辨，大小不超过1M</p>
                            </div>
                        </li>
                        <li><span class="tt">* 公司组织机构代码证：</span>
                            <div class="fileBox">
                            <input id="image2" class="file-text" placeholder="上传公司营业执照" name="company_img_2"><label class="file-button" type="button">选择文件</label>
                            <input id="file_name2" class="file" type="file" accept="image/*" onchange="document.getElementById('image2').value=this.value;" name="image_2">
                            <p class="tip">证件信息清晰，无遮挡，文字可辨，大小不超过1M</p>
                            </div>
                        </li>
                        <li><span class="tt">* 税务登记证：</span>
                            <div class="fileBox">
                            <input id="image3" class="file-text" placeholder="上传公司营业执照" name="company_img_3"><label class="file-button" type="button">选择文件</label>
                            <input id="file_name3" class="file" type="file" accept="image/*" onchange="document.getElementById('image3').value=this.value;" name="image_3">
                            <p class="tip">证件信息清晰，无遮挡，文字可辨，大小不超过1M</p>
                            </div>
                        </li>
                    </ul>
                </li>
                <li id="J_all" style="display:none">
                    <ul>
                        <li><span class="tt">* 公司营业执照（三证合一）：</span>
                            <div class="fileBox">
                            <input id="image4" class="file-text"  disabled="true" placeholder="上传公司营业执照" name="company_img"><label class="file-button" type="button">选择文件</label>
                            <input id="file_name4" class="file" type="file" accept="image/*" onchange="document.getElementById('image4').value=this.value;" name="image_4" disabled="true">
                            <p class="tip">证件信息清晰，无遮挡，文字可辨，大小不超过1M</p>
                            </div>
                        </li>
                        <li><span class="tt">* 银行开户许可证：</span><input type="text" name="bank_sn" class="txt max-txt"  disabled="true"></li>
                    </ul>
                </li>
                
            </ul>
            <div class="f-tac">
                <input  type="button" class="btn-g" data-url="/store/company" id="J_pre" value="返回上一步 ">　
                <button class="btn" id="J_btn">下一步</button>
            </div>
        </div>
        </form>

    </div>
</div>
<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>user/js/apply.js" charset="utf-8"></script>


<?php $this->load->view('footer');?>
