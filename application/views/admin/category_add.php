<?php $this->load->view('admin/header'); ?>
<div class="main_body">

	<div class="span9 page_message">
		<section id="contents">
			<ul class="tab-nav nav">

			</ul>
			<div class="tab-content">
				<!-- 表单 -->
				<form id="form" action="" method="post" class="form-horizontal form-center">
					<div class="form-item cf toggle-title">
						<label class="item-label">
							<span class="need_flag">*</span>
							分类标题
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<input type="text" class="text input-large" name="title" value="">
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
					<div class="form-item cf toggle-is_show">
						<label class="item-label">
							是否显示
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<div class="check-item">
								<!--[if !IE]><!-->
								<input type="radio" class="regular-radio toggle-data" value="0" id="is_show_0" name="is_show" toggle-data="" />
								<label for="is_show_0"></label>
								不显示
								<!--<![endif]-->
								<!--[if IE]>
							       <input type="radio" value="0"  id="is_show_0" name="is_show" class="toggle-data" toggle-data="" />
								  <label for="is_show_0"></label>不显示							   
								  <![endif]-->
							</div>
							<div class="check-item">
								<!--[if !IE]><!-->
								<input type="radio" class="regular-radio toggle-data" value="1" id="is_show_1" name="is_show" toggle-data="" checked />
								<label for="is_show_1"></label>
								显示
								<!--<![endif]-->
								<!--[if IE]>
							       <input type="radio" value="1" id="is_show_1" name="is_show" class="toggle-data" toggle-data=""  checked="checked" />
								  <label for="is_show_1"></label>显示							   <![endif]-->
							</div>
						</div>
					</div>
					<div class="form-item cf toggle-is_recommend">
						<label class="item-label">
							是否推荐
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<div class="check-item">
								<!--[if !IE]><!-->
								<input type="radio" class="regular-radio toggle-data" value="0" id="is_recommend_0" name="is_recommend" toggle-data="" checked />
								<label for="is_recommend_0"></label>
								否
								<!--<![endif]-->
								<!--[if IE]>
							       <input type="radio" value="0" 
								   id="is_recommend_0" name="is_recommend" class="toggle-data" toggle-data=""
								  checked="checked" />
								  <label for="is_recommend_0"></label>否							   <![endif]-->
							</div>
							<div class="check-item">
								<!--[if !IE]><!-->
								<input type="radio" class="regular-radio toggle-data" value="1" id="is_recommend_1" name="is_recommend" toggle-data="" />
								<label for="is_recommend_1"></label>
								是
								<!--<![endif]-->
								<!--[if IE]>
							       <input type="radio" value="1"  id="is_recommend_1" name="is_recommend" class="toggle-data" toggle-data="" />
								  <label for="is_recommend_1"></label>是							   
								  <![endif]-->
							</div>
						</div>
					</div>
			
			</div>
			<div class="form-item form_bh">
				<button class="btn submit-btn ajax-post" id="submit" type="submit" target-form="form-horizontal">确 定</button>
			</div>
			</form>
	
	</div>


	</section>
</div>

</div>
</div>

<?php $this->load->view('admin/footer'); ?>