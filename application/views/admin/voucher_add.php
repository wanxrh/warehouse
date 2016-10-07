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
								<input type="text" name="goods_id">
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
								<input type="text" name="number">
							</label>
						</div>
					    </div>

					    </div>

					</div>
			<div class="form-item form_bh">
				<button class="btn submit-btn ajax-post" id="submit" type="submit" target-form="form-horizontal">确 定</button>
			</div>
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