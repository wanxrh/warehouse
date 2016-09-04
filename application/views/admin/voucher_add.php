<?php $this->load->view('admin/header'); ?>
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/js/laydate.js"></script>
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/js/laydate.dev.js"></script>
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
							商品ID
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<label class="textarea">
								<input type="text" name="goods_id"></input>
							</label>
						</div>

						</div>
						<div class="form-item cf toggle-title">
						<label class="item-label">
							<span class="need_flag">*</span>
							数量：
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<label class="textarea">
								<input type="text" name="number"></input>
							</label>
						</div>
					    </div>
					    <div class="form-item cf toggle-title">
						<label class="item-label">
							<span class="need_flag">*</span>
							电子券拥有者微信ID：
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<label class="textarea">
								<input type="text" name="owner_id"></input>
							</label>
						</div>
					    </div>
					     <div class="form-item cf toggle-title">
						<label class="item-label">
							<span class="need_flag">*</span>
							转电子券时间：
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<label class="textarea">
								<input type="text" style="cursor: pointer" name="get_time"  id="J-xl" readonly value=""></input>
							</label>
						</div>
					    </div>
                         <div class="form-item cf toggle-title">
						<label class="item-label">
							<span class="need_flag">*</span>
							使用时间：
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<label class="textarea">
								<input type="text" style="cursor: pointer" readonly name="use_time" id="J-x2"></input>
							</label>
						</div>
					    </div>
					    <div class="form-item cf toggle-title">
						<label class="item-label">
							<span class="need_flag">*</span>
							状态：
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<label class="textarea">
							    <select name="status">
							        <option value="0">未使用</option>
							        <option value="1">转电子卷</option>
							        <option value="2">已使用</option>
                                </select>
							</label>
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
<script type="text/javascript">
        laydate({
            elem: '#J-xl'
        });
        laydate({
            elem: '#J-x2'
        });

    </script>
<?php $this->load->view('admin/footer'); ?>