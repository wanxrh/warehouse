<?php $this->load->view('admin/header'); ?>
<div class="main_body">

	<div class="span9 page_message">
		<section id="contents">
			<ul class="tab-nav nav">

			</ul>
			<div class="tab-content">
				<!-- 表单 -->
				<form id="form" action="/admin/viewQrcode" method="post" class="form-horizontal form-center">
					<div class="form-item cf toggle-title">
						<input type="hidden" name="id" value="<?php echo $info['id']; ?>"/>
						<label class="item-label">
							代理微信ID
						</label>
						<div class="controls">
							<input readOnly="true"  type="text" class="text input-large" name="openid" value="<?php echo $info['openid']; ?>">
						</div>
					</div>
					<div class="form-item cf toggle-title">
						<label class="item-label">
							代理日期
						</label>
						<div class="controls">
							<input readOnly="true"  type="text" class="text input-large" name="agenttime" value="<?php echo $info['agenttime']?date('Y-m-d H:i:s',$info['agenttime']):''; ?>">
						</div>
					</div>
					<div class="form-item cf toggle-title">
						<label class="item-label">
							手机号码
						</label>
						<div class="controls">
							<input type="text" class="text input-large" name="mobile" value="<?php echo $info['mobile']?$info['mobile']:''; ?>">
						</div>
					</div>
					<div class="form-item cf toggle-title">
						<label class="item-label">
							备注
						</label>
						<div class="controls">
							<input type="text" class="text input-large" name="remark" value="<?php echo $info['remark']; ?>">
						</div>
					</div>
					<div class="form-item cf toggle-is_show">
						<label class="item-label">
							代售点
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<div class="check-item">
								<!--[if !IE]><!-->
								<input type="radio" class="regular-radio toggle-data" value="0"
									   id="super_0" name="super" toggle-data="" <?php if($info['super'] ==0){ echo 'checked'; } ?>/>
								<label for="super_0"></label>
								否
								<!--<![endif]-->
								<!--[if IE]>
								<input type="radio" value="0"
									   id="super_0" name="super" class="toggle-data" toggle-data=""
								<?php if($info['super'] ==0){ echo 'checked="true"'; } ?>/>
								<label for="super_0"></label>否                               <![endif]-->
							</div>
							<div class="check-item">
								<!--[if !IE]><!-->
								<input type="radio" class="regular-radio toggle-data" value="1"
									   id="super_1" name="super" toggle-data="" <?php if($info['super'] ==1){ echo 'checked'; } ?>/>
								<label for="super_1"></label>
								是
								<!--<![endif]-->
								<!--[if IE]>
								<input type="radio" value="1"
									   id="is_show_1" name="super" class="toggle-data" toggle-data=""
								<?php if($info['super'] ==1){ echo 'checked="true"'; } ?>
								/>
								<label for="super_1"></label>是                               <![endif]-->
							</div>
						</div>
					</div>
					<div class="form-item cf toggle-title">
						<label class="item-label">
							激活二维码
						</label>
						<img src="<?php echo $info['agent_url']; ?>">
					</div>
					<div class="form-item cf toggle-title">
						<label class="item-label">
							推广二维码
						</label>
						<img src="<?php echo $info['focus_url']; ?>">
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