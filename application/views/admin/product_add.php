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
				<form id="form" action="/admin/addProduct" method="post" class="form-horizontal form-center">
					<div class="form-item cf toggle-title">
						<label class="item-label">
							<span class="need_flag">*</span>
							标题
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<input type="text" class="text input-large" name="title" value="">
						</div>
					</div>
					<div class="form-item cf toggle-category_id">
						<label class="item-label">
							分类
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<select name="type">
								<option value="">请选择</option>
								<option value="产品介绍">产品介绍</option>
								<option value="生长过程">生长过程</option>
								<option value="农人感言">农人感言</option>
								<option value="检测报告">检测报告</option>
								<option value="图文混编推荐吃法">图文混编推荐吃法</option>

							</select>
						</div>
					</div>
					<div class="form-item cf toggle-sort">
						<label class="item-label">
							排序号
							<span class="check-tips"> （数值越小越靠前） </span>
						</label>
						<div class="controls">
							<input type="number" class="text" name="sort" value="0">
						</div>
					</div>
					<div class="form-item cf toggle-content">
						<label class="item-label">
							内容
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<label class="textarea">
								<textarea name="content" id="description" style="width: 405px; height: 200px;"></textarea>
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