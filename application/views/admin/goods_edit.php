<?php $this->load->view('admin/header'); ?>
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/kindeditor/kindeditor.js"></script>
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/kindeditor/lang/zh_CN.js"></script>

<link href="<?php echo $this->config->base_url(); ?>static/webuploader/webuploader.css" rel="stylesheet"/>
<link href="<?php echo $this->config->base_url(); ?>static/webuploader/style.css" rel="stylesheet"/>
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/webuploader/webuploader.js"></script>
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/webuploader/upload.js"></script>
<div class="main_body">

	<div class="span9 page_message">
		<section id="contents">
			<ul class="tab-nav nav">

			</ul>
			<div class="tab-content">
				<!-- 表单 -->
				<form id="form" action="/admin/editgoods" method="post" class="form-horizontal form-center">
					<div class="form-item cf toggle-title">
						<input type="hidden" name="id" value="<?php echo $info['id']; ?>"/>
						<label class="item-label">
							<span class="need_flag">*</span>
							商品名称
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<input type="text" class="text input-large" name="title" value="<?php echo $info['title']; ?>">
						</div>
					</div>
					<div class="form-item cf toggle-imgs">
						<label class="item-label">
							商品图片
							<span class="check-tips"> （可以上传多个图片） </span>
						</label>
						<div id="uploader">
			                <div class="queueList">
			                    <div id="dndArea" class="placeholder">
			                    	<img id="big_goods_image" src="" width="300" height="300" alt="" />
			                        <!-- <div id="filePicker"></div> -->
			                    </div>
			                     <div id="filePicker"></div>
			                     <ul class="filelist">
                                    <?php foreach (explode(',', $info['imgs']) as $v) { ?>
                                    <li  data-img="<?php echo $v; ?>">
                                    <p class="imgWrap">
                                    <img src="<?php echo imgUrl($v); ?>">
                                    </p>
                                    <div class="file-panel" style="height: 30px;"><span class="cancel J-del">删除</span></div></li>
                                     <?php } ?>
                                 </ul>
			                </div>
			                <div class="statusBar">
			                  
			                        <div class="uploadBtn">开始上传</div>
			                 
			                </div>
	            		</div>
	            		<input id="uploadimg" type="hidden" value="<?php echo $info['imgs']; ?>" name="imgs">
            		</div>
					<div class="form-item cf toggle-category_id">
						<label class="item-label">
							商品分类
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<select name="category_id">
								<option value="0">请选择</option>
								<?php foreach ($category as $v){ ?>
								<option <?php if($info['category_id'] == $v['id'] ){ echo 'selected = "selected"'; } ?> value="<?php echo $v['id']; ?>" class="toggle-data" toggle-data=""><?php echo $v['title']; ?></option>
								<?php }; ?>
							</select>
						</div>
					</div>
					<div class="form-item cf toggle-price">
						<label class="item-label">
							价格
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<input type="number" class="text" name="price" value="<?php echo $info['price']; ?>">
						</div>
					</div>
					<div class="form-item cf toggle-price">
						<label class="item-label">
							代理佣金
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<input type="number" oninput="if(value.length>2)value=value.slice(0,2)" class="text" name="commission" value="<?php echo $info['commission']; ?>"> * 0.01
						</div>
					</div>
					<div class="form-item cf toggle-is_recommend">
						<label class="item-label">
							是否推荐
							<span class="check-tips"> （推荐后首页的推荐商品里显示） </span>
						</label>
						<div class="controls">
							<div class="check-item">
								<!--[if !IE]><!-->
								<input type="radio"  <?php if($info['is_recommend'] ==0){ echo 'checked'; } ?> class="regular-radio toggle-data" value="0"
									id="is_recommend_0" name="is_recommend" toggle-data=""  />
								<label for="is_recommend_0"></label>
								否
								<!--<![endif]-->
								<!--[if IE]>
							       <input  <?php if($info['is_recommend'] ==0){ echo 'checked="true"'; } ?>  type="radio" value="0" id="is_recommend_0" name="is_recommend" class="toggle-data" toggle-data="" checked="checked" />
								  <label for="is_recommend_0"></label>否							   
								<![endif]-->
							</div>
							<div class="check-item">
								<!--[if !IE]><!-->
								<input  <?php if($info['is_recommend'] ==1){ echo 'checked'; } ?>  type="radio" class="regular-radio toggle-data" value="1"
									id="is_recommend_1" name="is_recommend" toggle-data="" />
								<label for="is_recommend_1"></label>
								是
								<!--<![endif]-->
								<!--[if IE]>
							       <input  <?php if($info['is_recommend'] ==1){ echo 'checked="true"'; } ?>  type="radio" value="1" 
								   id="is_recommend_1" name="is_recommend" class="toggle-data" toggle-data=""
								   />
								  <label for="is_recommend_1"></label>是							   <![endif]-->
							</div>
						</div>
					</div>
					<div class="form-item cf toggle-content">
						<label class="item-label">
							商品介绍
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<label class="textarea">
								<textarea name="content" id="description" style="width: 405px; height: 200px;"><?php echo $info['content']; ?></textarea>
							</label>
						</div>
					</div>
<script>
   KindEditor.ready(function(K) {
        var editor1 = K.create('#description', {
            allowImageUpload: true,
            uploadJson: "/admin/editorupload", //图片上传后的处理地址
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
					<div class="form-item cf toggle-inventory">
						<label class="item-label">
							库存数量
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<input type="number" class="text" name="inventory" value="<?php echo $info['inventory']; ?>">
						</div>
					</div>
					<div class="form-item cf toggle-is_show">
						<label class="item-label">
							是否上架
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<div class="check-item">
								<!--[if !IE]><!-->
								<input   <?php if($info['is_show'] ==0){ echo 'checked'; } ?>   type="radio" class="regular-radio toggle-data" value="0"
									id="is_show_0" name="is_show" toggle-data=""  />
								<label for="is_show_0"></label>
								否
								<!--<![endif]-->
								<!--[if IE]>
							       <input    <?php if($info['is_show'] ==0){ echo 'checked="true"'; } ?>    type="radio" value="0" 
								   id="is_show_0" name="is_show" class="toggle-data" toggle-data="" />
								  <label for="is_show_0"></label>否							   <![endif]-->
							</div>
							<div class="check-item">
								<!--[if !IE]><!-->
								<input    <?php if($info['is_show'] ==1){ echo 'checked'; } ?>    type="radio" class="regular-radio toggle-data" value="1"
									id="is_show_1" name="is_show" toggle-data="" />
								<label for="is_show_1"></label>
								是
								<!--<![endif]-->
								<!--[if IE]>
							       <input    <?php if($info['is_show'] ==1){ echo 'checked="true"'; } ?>    type="radio" value="1" 
								   id="is_show_1" name="is_show" class="toggle-data" toggle-data=""
								   />
								  <label for="is_show_1"></label>是							   <![endif]-->
							</div>
						</div>
					</div>
					<div class="form-item cf toggle-old_price">
						<label class="item-label">
							原价
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<input type="number" class="text" name="old_price" value="<?php echo $info['old_price']; ?>">
						</div>			
				</div>
				<div class="form-item cf toggle-sort">
						<label class="item-label">
							排序号
							<span class="check-tips"> （数值越小越靠前） </span>
						</label>
						<div class="controls">
							<input type="number" class="text" name="sort" value="<?php echo $info['sort']; ?>">
						</div>
					</div>
					<div class="form-item cf toggle-sort">
						<label class="item-label">
							宰杀价格
							<span class="check-tips"> （0为此商品不支持宰杀） </span>
						</label>
						<div class="controls">
							<input type="number" class="text" name="kill" value="<?php echo $info['kill']; ?>">
						</div>
					</div>
			<div class="form-item form_bh">
				<button class="btn submit-btn ajax-post" id="submit" type="submit"
					target-form="form-horizontal">确 定</button>
			</div>
			</form>
	
	</div>


	</section>
</div>

</div>
</div>
<?php $this->load->view('admin/footer'); ?>