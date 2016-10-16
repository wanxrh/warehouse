<?php $this->load->view('admin/header'); ?>
<style>
.input-span{
    width: 552px;
    height: 34px;
    position: relative;
    display: table;
    border-collapse: separate;
}
.uneditable-span{
    float: left;
    display: inline-block;
    margin-bottom: 0;
    vertical-align: middle;
    cursor: text;
    padding: 6px 12px;
    min-width: 206px;
    font-size: 14px;
    font-weight: normal;
    height: 20px;
    color: #333333;
    background-color: #ffffff;
    border: 1px solid #e5e5e5;
    border-radius: 0;
    -webkit-box-shadow: none;
    box-shadow: none;
}
.default{
    float: left;
    display: block;
    background-color: #e5e5e5;
    width: 55px;
    height: 34px;
    cursor: pointer;
}
.fileupload-new{
    line-height: 34px;
}
.fileupload-exists{
	margin-left: 5px;
	line-height: 34px;
    display: none;
}
.btn-file {
  position: relative;
  overflow: hidden;
  vertical-align: middle;
}
.btn-file > input {
  position: absolute;
  top: 0;
  right: 0;
  margin: 0;
  font-size: 23px;
  cursor: pointer;
  opacity: 0;
  filter: alpha(opacity=0);
  transform: translate(-300px, 0) scale(4);
  direction: ltr;
}

</style>
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/kindeditor/kindeditor.js"></script>
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/kindeditor/lang/zh_CN.js"></script>
	<link href="<?php echo $this->config->base_url(); ?>static/webuploader/style.css" rel="stylesheet"/>
	<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/webuploader/webuploader.js"></script>
	<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/js/ajaxfileupload.js"></script>
	<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/webuploader/upload.js"></script>
	<div class="main_body">

	<div class="span9 page_message">
		<section id="contents">
			<ul class="tab-nav nav">

			</ul>
			<div class="tab-content">
				<!-- 表单 -->
				<form id="form" action="/admin/addbreeding" method="post" class="form-horizontal form-center">
					<div class="form-item cf toggle-title">
						<label class="item-label">
							<span class="need_flag">*</span>
							商品
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
                            <select style="width: 500px;" name="goods_id">
                                <?php foreach($goods as $item):?>
                                    <option value="<?php echo $item['id'];?>"><?php echo $item['title'];?></option>
                                <?php endforeach;?>
                            </select>
							<!--<input type="text" class="text input-large" name="goods_id" value="">-->
						</div>
					</div>
					<div class="form-item cf toggle-title">
						<label class="item-label">
							<span class="need_flag">*</span>
							倒计时
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<input type="text" class="sang_Calender" name="outtime"/>
						</div>
					</div>
					<div class="form-item cf toggle-imgs">
						<label class="item-label">
							照片
							<span class="check-tips"> （可以上传多个图片） </span>
						</label>
						<div id="uploader">
							<div class="queueList">
								<div id="dndArea" class="">
									<img id="big_goods_image" src="" width="200" height="200" alt="" />
									<!-- <div id="filePicker"></div> -->
								</div>
								<div id="filePicker" ></div>
							</div>
							<div class="statusBar">

								<div class="uploadBtn">开始上传</div>

							</div>
						</div>
						<input id="uploadimg" type="hidden" value="" name="picture">
					</div>
					<div class="form-item cf toggle-title">
						<label class="item-label">
							视频
							<span class="check-tips"> </span>
						</label>
						<div class="input-span fileupload">
                                <span class="uneditable-span">

                                </span>
							<span class="default btn-file">
                                    <span class="fileupload-new">
                                        &nbsp;&nbsp;&nbsp;浏览
                                    </span>
                                    <span class="fileupload-exists">
                                        &nbsp;&nbsp;&nbsp;更换
                                    </span>
                                    <input type="file" class="default" id="p_farmer_movie" name="p_farmer_movie" onchange="return ajaxFileUpload(this)" />
                                </span>
							<input type="hidden" value="" name="video" class="hidden_value form-control" />
							<a href="javascript:;" class="btn red fileupload-exists" data-dismiss="fileupload">
								<i class="icon icon-trash"></i> 删除
							</a>
						</div>
					</div>
					<div class="form-item cf toggle-title">
						<label class="item-label">
							<span class="need_flag">*</span>
							文字说明
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<label class="textarea">
								<textarea name="instructions" class="" style="width: 405px; height: 70px;"></textarea>
							</label>
						</div>
					</div>

<script>
   KindEditor.ready(function(K) {
        var editor1 = K.create('.description', {
            allowImageUpload: true,
            uploadJson: "/admin/editorupload", //图片上传后的处理地址
			afterBlur: function(){this.sync();},
			items: [
        'source', '|', 'undo', 'redo', '|',
        'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
        'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
        'superscript', '|', 'clearhtml', 'quickformat', 'selectall', 'fullscreen' ,
        'formatblock',  'fontsize','bold',
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
	<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/js/datetime.js"></script>
	<script type="text/javascript">
	//上传附件
    function ajaxFileUpload(obj) {
        var fileName = $(obj).attr('id');
        var uploadInfo = $(obj).parent();
        var file = $(obj).val();
        var fileType = file.substring(file.lastIndexOf(".")+1);
        fileType = fileType.toLowerCase();
        var allows = ['png','jpg','jpeg','bmp','pdf','avi','flv','swf','mp4'];
        if($.inArray(fileType,allows)==-1){
            alert('上传格式不允许','');
            return;
        }
        var fileInput = $("#"+fileName)[0];
        if (fileInput.files && fileInput.files[0]) {
            var size = fileInput.files[0].fileSize;
            if(size>1024*1024*2 || size<6*1024){
                alert('File size is required between 5K-2M.','');
                return false;
            }
        }
        $.ajaxFileUpload
        (
            {
                url: '/admin/upload2',
                secureuri: false,
                fileElementId: fileName,
                dataType: 'json',
                data: {
                    'file_name': fileName,
                    'type':'bmp,jpeg,jpg,png,pdf,avi,mp4,swf',
                    'minsize':5
                },
                success: function (data, status) {
                    if (typeof(data.error) != 'undefined' && data.error != '') {
                        alert(data.error);
                    } else {
                        alert(data.success);
                        /***给隐藏域赋值***/
                        uploadInfo.siblings('.hidden_value').val(data.path);

                        /***输入框显示文件名***/
                        //uploadInfo.siblings('.uneditable-span').find('.icon-file').removeClass('fileupload-exists');
                        uploadInfo.siblings('.uneditable-span').html(data.name);
                        /****remove change 替换***/
                        uploadInfo.find('.fileupload-new').hide();
                        uploadInfo.find('.fileupload-exists').show();
                        uploadInfo.siblings('.fileupload-exists').show();

                    }
                },
                error: function (data, status, e) {
                    alert('上传失败，请稍后重试','');
                }
            }
        );
        return false;
    }
    //附件删除
    $('.fileupload').on('click','.red',function(e){
        $(this).siblings('.hidden_value').val('');
        $(this).siblings('.btn-file').find('.fileupload-new').show();
        $(this).siblings('.btn-file').find('.fileupload-exists').hide();
        $(this).siblings('.uneditable-span').html('');
        $(this).hide();
    });
</script>
<?php $this->load->view('admin/footer'); ?>