<?php $this->load->view('help/header');?>
<div class="g-bd">
	<div class="g-wrap">
		<div class="g-mn">
			<div class="m-bd">
                <?php $this->load->view('help/cont');?>
                <ul class="ui-tab">
                    <li class="active">查询结果</li>
                </ul>
				<div class="g-bd-index">
					<ul>
                        <?php if($is_ok){?>
                            <?php foreach($article_list as $item){?>
                                <li>
                                    <a target="_blank" href="/help/article_info/<?php echo $item['cate_id'].'/'.$item['article_id']; ?>" class="list"><?php echo $item['title'];?></a>
                                </li>
                            <?php }?>
                        <?php }else{?>
                            <li>请输入关键字查询！</li>
                        <?php }?>
					</ul>  
				</div>
			</div> 
		</div>
		<div class="g-side">
             <?php $this->load->view('help/menu');?>
		</div>
	</div> 
</div>
<?php $this->load->view('help/footer');?>
