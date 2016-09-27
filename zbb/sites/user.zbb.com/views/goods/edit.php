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
                           <?php foreach ($site_cate as $v){?>
                           <?php if($v['cate_id']==$store_info['cate_id']){?>
                            <option value="<?php echo $v['cate_id'];?>" <?php if($v['is_checked']){?>selected<?php }?>><?php echo $v['cate_name'];?></option>
                           <?php }}?>
                        </select>
                        <select name="cate_id[]"  id="J_A2_type">
                            <?php foreach ($site_cate_2 as $v){?>
                                <option value="<?php echo $v['cate_id'];?>" <?php if($v['is_checked']){?>selected<?php }?>><?php echo $v['cate_name'];?></option>
                            <?php }?>
                        </select>
                    </div>
                    <div class="lst">
                        <h3 class="tt">本店分类</h3>
                       <select name="store_cate_id[]"  id="J_B_type">
                           <?php foreach ($shop_cate as $m){?>
                               <option value="<?php echo $m['cate_id'];?>" <?php if($v['is_checked']){?>selected<?php }?>><?php echo $m['cate_name'];?></option>
                           <?php }?>
                        </select>
                        <select name="store_cate_id[]" id="J_B2_type" >
                            <?php foreach ($shop_cate_2 as $m){?>
                                <option value="<?php echo $m['cate_id'];?>" <?php if($v['is_checked']){?>selected<?php }?>><?php echo $m['cate_name'];?></option>
                            <?php }?>
                        </select>
                    </div>
            </div>
            <div class="m-add-shop clearfix">
                <div id="uploader">
                    <div class="queueList">
                        <div id="dndArea" class="placeholder">
                            <img id="big_goods_image" src="<?php echo img_url($goods_info['default_image']);?>" width="300" height="300" alt="" />
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
                <input type="hidden" name="uploadimg" id="uploadimg" value="<?php echo implode(',',array_column($goods_img,'image_url'));?>">
                <div class="products">
                    <ul>
                        <li>
                            <span class="txt">商品名称: </span>
                            <input title="" type="text" name="goods_name" value="<?php echo $goods_info['goods_name'];?>" class="inpt-gray max-inpt"> <span class="s-fc-red">*</span>
                        </li>

                       <?php if($goods_info['enable_sku']==1){?>
                        <li>
                            <span class="txt">规格: </span>
                            <div class="arrange">
                                <div class="box_arr" >
                                    <p class="pos_btn"><a id="J_add" href="javascript:;" class="add_btn" data-type="1">查看(编辑)规格</a></p>
                                    <p class="pos_txt">您可以添加商品规格（如：颜色，尺码）</p>
                                    <div id="J_copy" class="copy">
                                        <div class="cont">
                                            <div class="t-tt clearfix">
                                                <div class="pro">
                                                    <ul>
                                                        <?php foreach ($attr_name as $v){?>
                                                        <li>
                                                            <input type="text" value="<?php echo $v['attr_name'];?>" name="spec_n[]" class="m-txt" readonly="readonly">
                                                        </li>
                                                        <?php }?>
                                                    </ul>
                                                </div>
                                                <div class="rigid">
                                                    <ul>
                                                        <li>原价</li>
                                                        <li>售价</li>
                                                        <li>库存</li>
                                                        <li class="num-width">货号</li>
                                                        <li>操作</li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <div class="mn">
                                            <?php foreach ($goods_sku as $v){?>
                                                <div class="list clearfix">
                                                    <input type="hidden" name="sku_id[]" class="J_sku" value="<?php echo $v['sku_id'];?>">
                                                    <div class="pro readonly">
                                                        <ul>
                                                            <?php foreach ($v['list'] as $key=>$m){?>
                                                            <li>
                                                                <input type="text" name="spec_v_<?php echo $key;?>[]" value="<?php echo $m;?>" class="m-txt J-txt" readonly="readonly">
                                                            </li>
                                                            <?php }?>
                                                        </ul>
                                                    </div>
                                                    <div class="rigid">
                                                        <ul>
                                                            <li>
                                                                <input type="text" value="<?php echo $v['cost_price'];?>" name="cost_price[]" class="m-txt J-txt J-money">
                                                            </li>
                                                            <li>
                                                                <input type="text" value="<?php echo $v['price'];?>" name="price[]" class="m-txt J-txt J-money">
                                                            </li>
                                                            <li>
                                                                <input type="text" value="<?php echo $v['stock'];?>" name="stock[]" class="m-txt J-txt J-num" >
                                                            </li>
                                                            <li class="num-width">
                                                                <input type="text" value="<?php echo $v['out_sku'];?>" name="sku[]" class="m-txt num-width J-txt">
                                                            </li>
                                                            <li><span class="op">x</span></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                                <?php }?>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--显示规格-->
                            </div>
                        </li>
                        <li>
                       <?php }?>

                       <?php if($goods_info['enable_sku']==0){?>
                         <li>
                        <span class="txt">现价: </span>
                        <input title="" type="text" name="price" value="<?php echo $price;?>" class="inpt-gray max-inpt"> <span class="s-fc-red">*</span>
                        </li>
                        <span class="txt">原价: </span>
                        <input title="" type="text" name="cost_price" value="<?php echo $cost_price;?>" class="inpt-gray max-inpt">
                        <li>
                            <span class="txt">库存: </span>
                            <input title="" type="text" name="stock" value="<?php echo $stock;?>" class="inpt-gray max-inpt"> <span class="s-fc-red">*</span>
                        </li>
                        <li>
                            <span class="txt">sku: </span>
                            <input title="" type="text" name="out_sku" value="<?php echo $sku;?>" class="inpt-gray max-inpt">
                        </li>
                       <?php }?>

                            <span class="txt">推荐: </span>
                                <span class="distance">
                                    <label><input name="recommended" value="1" <?php if($goods_info['is_recom']){?>checked="checked"<?php }?> type="radio"> 是</label>
                                    <label><input name="recommended" value="0" <?php if(!$goods_info['is_recom']){?>checked="checked"<?php }?> type="radio"> 否</label>
                                </span>
                                <span class="gray">被推荐的商品会显示在店铺首页</span>
                            </p>
                        </li>
                        <li>
                            <span class="txt">参数: </span>
                            <textarea title="" cols="60" rows="12"  name="attributes" value="" ><?php echo $goods_extm['attributes'];?></textarea>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="editor">
                <h3 class="tt">宝贝描述</h3>
                <div>
                    <textarea name="detail" id="detail" style="width: 100%; height: 400px;"><?php echo $goods_extm['detail'];?></textarea>
                </div>
                <div class="f-tac"><input type="button" class="btn" data-sku="<?php echo $goods_info['enable_sku'];?>" value="提交" id="appbtn"><input type="hidden" name="goods_id" value="<?php echo $goods_info['goods_id'];?>"></div>
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