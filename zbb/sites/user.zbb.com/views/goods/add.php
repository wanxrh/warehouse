<?php $this->load->view('header');?>
<link href="<?php echo $this->config->item('domain_static'); ?>common/js/webuploader/webuploader.css" rel="stylesheet"/>
<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>common/js/jquery-1.11.0.min.js" charset="utf-8"></script>
<script charset="utf-8" src="<?php echo $this->config->item('domain_static'); ?>common/kindeditor/kindeditor.js"></script>
<script charset="utf-8" src="<?php echo $this->config->item('domain_static'); ?>common/kindeditor/lang/zh_CN.js"></script>
<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>common/js/webuploader/webuploader.js"></script>
<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>user/js/upload.js"></script>
<script>
   KindEditor.ready(function(K) {
        var editor1 = K.create('textarea[name="detail"]', {
            allowImageUpload: true,
            uploadJson: "/goods/upload", //图片上传后的处理地址
            afterBlur: function(){this.sync();},
            items: [
        'source', '|', 'undo', 'redo', '|', 'preview', 'code', 'cut', 'copy', 'paste',
        'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
        'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
        'superscript', '|', 'clearhtml', 'quickformat', 'selectall', 'fullscreen' ,
        'formatblock', 'fontname', 'fontsize', '|', '/',  'forecolor', 'hilitecolor', 'bold',
        'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image', 'table', 'hr', 'emoticons', 'pagebreak',
        'link', 'unlink' ]
        });
    });
</script>

<div class="g-wrap clearfix">
    <div class="g-mn">
        <div class="g-mnc">
            <!--  正文  -->
            <div class="m-tt">
                <span>发布宝贝<em></em></span>
            </div>
            <form action="" id="myForm" method="post">
            <div class="m-opbox">
                    <div class="lst">
                        <h3 class="tt">宝贝分类</h3>
                       <select name="cate_id[]" id="J_A_type">
                           <option value="">请选择分类</option>
                           <?php foreach ($site_cate as $v){?>
                               <?php if($v['cate_id']==$store_info['cate_id']){?>
                            <option value="<?php echo $v['cate_id'];?>"><?php echo $v['cate_name'];?></option>
                                   <?php }?>
                           <?php }?>
                        </select>
                        <select name="cate_id[]"  id="J_A2_type">
                            <option value="">宝贝二级分类</option>
                        </select>
                    </div>
                    <div class="lst">
                        <h3 class="tt">本店分类</h3>
                       <select name="store_cate_id[]"  id="J_B_type">
                            <option value="0">请选择分类</option>
                           <?php foreach ($shop_cate as $m){?>
                               <option value="<?php echo $m['cate_id'];?>"><?php echo $m['cate_name'];?></option>
                           <?php }?>
                        </select>
                        <select name="store_cate_id[]" id="J_B2_type" style="display:none" disabled>
                            <option value="0">本店二级分类</option>
                        </select>
                    </div>
            </div>
            <div class="m-add-shop clearfix">
                <div id="uploader">
                    <div class="queueList">
                        <div id="dndArea" class="placeholder">
                            <img id="big_goods_image" src="<?php echo $this->config->item('domain_static'); ?>user/img/default.gif" width="300" height="300" alt="" />
                            <!-- <div id="filePicker"></div> -->
                        </div>
                        <div id="filePicker"></div>
                        <p class="hint-text">支持jpg\jpeg\png格式，大小不超过400K</p>
                        <ul class="filelist"></ul>
                    </div>
                    <div class="statusBar">
                        <div class="uploadBtn">开始上传</div>
                    </div>
                </div>
                <input type="hidden" name="uploadimg" id="uploadimg" value="">
                <div class="products">
                    <ul>
                        <li>
                            <span class="txt">商品名称: </span>
                            <input title="" type="text" name="goods_name" value="" class="inpt-gray max-inpt"> <span class="s-fc-red">*</span>
                        </li>
                        <li>
                            <span class="txt">规格: </span>
                            <div class="arrange">
                                <div class="box_arr" >
                                    <p class="pos_btn"><a id="J_add" href="javascript:;" class="add_btn">查看(编辑)规格</a></p>
                                    <p class="pos_txt">您可以添加商品规格（如：颜色，尺码）</p>
                                    <div class="copy" id="J_copy">
                                            
                                    </div>
                                </div>
                                <!--显示规格-->
                            </div>
                        </li>
                        <li>
                            <span class="txt">推荐: </span>
                                <span class="distance">
                                    <label><input name="recommended" value="1" checked="checked" type="radio"> 是</label>
                                    <label><input name="recommended" value="0" type="radio"> 否</label>
                                </span>
                                <span class="gray">被推荐的商品会显示在店铺首页</span>
                            </p>
                        </li>
                        <li>
                            <span class="txt">参数: </span>
                            <textarea title="" cols="60" rows="12"  name="attributes" value="" ></textarea>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="editor">
                <h3 class="tt">宝贝描述</h3>
                <div>
                    <textarea name="detail" id="detail" style="width: 100%; height: 400px;"></textarea>
                </div>
                <div class="f-tac"><input type="button" class="btn" data-sku="1" value="提交" id="appbtn"></div>
            </div>
            </form>
            <!--  正文 END -->
        </div>
    </div>
    <div class="g-sd">
        <?php $this->load->view('menu');?>
    </div>
</div>

<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>user/js/goodsAdd.js" charset="utf-8"></script>

<?php $this->load->view('footer');?>