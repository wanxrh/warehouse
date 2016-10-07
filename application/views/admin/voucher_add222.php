<?php $this->load->view('admin/header'); ?>
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/js/city.min.js"></script>
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/js/jquery.cityselect.js"></script>
<style>
   #city_4 select{width: 100px;}
</style>
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
							省份
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
                           <div id="city_4">
                            <select class="prov" name="provinces"></select>
                            <select class="city" disabled="disabled" name="city"></select>
                            <select class="dist" disabled="disabled" name="county"></select>
                        </div>

						</div>
					</div>
					<div class="form-item cf toggle-title">
						<label class="item-label">
							<span class="need_flag">*</span>
							详细地址：
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<label class="textarea">
								<input type="text" name="address"></input>
							</label>
						</div>
					</div>
					<div class="form-item cf toggle-title">
						<label class="item-label">
							<span class="need_flag">*</span>
							代理人：
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<label class="textarea">
								<select>
								    <option>1</option>
                                </select>
							</label>
						</div>
					</div>
					<div class="form-item cf toggle-title">
						<label class="item-label">
							<span class="need_flag">*</span>
							商品id：
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<label class="textarea">
								<select>
								    <option>1</option>
                                </select>
							数量：<input type="text" name="number">  添加
							</label>
						</div>
					</div>
					<div class="form-item cf toggle-title">
						<label class="item-label">
							<span class="need_flag">*</span>
							商品id：
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<label class="textarea">
								<select>
								    <option>1</option>
                                </select>
							数量：<input type="text" name="number">
							</label>
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
            $(function() {
               $("#city_4").citySelect({
                    prov: "广西",
                    city: "南宁",
                    dist: "西乡塘区",
                    nodata: "none"
                });
            });
        </script>
<?php $this->load->view('admin/footer'); ?>