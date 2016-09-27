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
                    <ul>
                        <?php foreach($article_list as $item){?>
                            <li>
                                <a target="_blank" href="/help/article_info/<?php echo $item['cate_id'].'/'.$item['article_id']; ?>" class="list"><?php echo $item['title'];?></a>
                            </li>
                        <?php }?>
                    </ul>
                    <?php echo $page;?>
				</div>
			</div> 
		</div>
		<div class="g-side">
            <?php $this->load->view('help/menu');?>
		</div>
	</div> 
</div>
<?php $this->load->view('help/footer');?>
