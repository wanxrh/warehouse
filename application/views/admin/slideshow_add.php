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
				<form id="form" action="/admin/addslideshow" method="post" class="form-horizontal form-center">
					<div class="form-item cf toggle-title">
						<label class="item-label">
							标题
							<span class="check-tips"> （可为空） </span>
						</label>
						<div class="controls">
							<input type="text" class="text input-large" name="title" value="">
						</div>
					</div>
					<div class="form-item cf toggle-img">
						<label class="item-label">
							<span class="need_flag">*</span>
							图片
							<span class="check-tips"> </span>
						</label>
						<!-- <div class="controls">
							<div class="controls uploadrow2" title="点击修改图片" rel="img">
								<input type="file" id="upload_picture_img">
								<input type="hidden" name="img" id="cover_id_img" />
								<div class="upload-img-box"></div>
							</div>
						</div> -->
						<div id="uploader">
			                <div class="queueList">
			                    <div id="dndArea" class="placeholder">
			                        <!-- <div id="filePicker"></div> -->
			                    </div>
			                     <div id="filePicker"></div>
			                </div>
			                <div class="statusBar">
			                  
			                        <div class="uploadBtn">开始上传</div>
			                 
			                </div>
			                <input id="uploadimg" type="hidden" value="" name="img">
	            		</div>
					</div>
					<div class="form-item cf toggle-url">
						<label class="item-label">
							链接地址
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<input type="text" class="text input-large" name="url" value="">
						</div>
					</div>
					<div class="form-item cf toggle-is_show">
						<label class="item-label">
							是否显示
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<div class="check-item">
								<!--[if !IE]><!-->
								<input type="radio" class="regular-radio toggle-data" value="0"
									id="is_show_0" name="is_show" toggle-data="" />
								<label for="is_show_0"></label>
								不显示
								<!--<![endif]-->
								<!--[if IE]>
							       <input type="radio" value="0" 
								   id="is_show_0" name="is_show" class="toggle-data" toggle-data=""
								   />
								  <label for="is_show_0"></label>不显示							   <![endif]-->
							</div>
							<div class="check-item">
								<!--[if !IE]><!-->
								<input type="radio" class="regular-radio toggle-data" value="1"
									id="is_show_1" name="is_show" toggle-data="" checked />
								<label for="is_show_1"></label>
								显示
								<!--<![endif]-->
								<!--[if IE]>
							       <input type="radio" value="1" 
								   id="is_show_1" name="is_show" class="toggle-data" toggle-data=""
								  checked="checked" />
								  <label for="is_show_1"></label>显示							   <![endif]-->
							</div>
						</div>
					</div>
					<div class="form-item cf toggle-sort">
						<label class="item-label">
							排序
							<span class="check-tips"> （值越小越靠前） </span>
						</label>
						<div class="controls">
							<input type="number" class="text" name="sort" value="0">
						</div>
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