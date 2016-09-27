<?php $this->load->view('help/header');?>

<div class="g-bd">
	<div class="g-wrap">
		<div class="g-mn">
			<div class="m-bd">
                <?php $this->load->view('help/cont');?>
                <ul class="ui-tab">
                    <li class="active">帮助列表</li>
                </ul>
				<div class="g-bd-index">
				
				</div>
			</div> 
		</div>
		<div class="g-side">
            <?php $this->load->view('help/menu');?>
        </div>
	</div> 
</div>
<?php $this->load->view('help/footer');?>
