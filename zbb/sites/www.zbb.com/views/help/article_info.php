<?php $this->load->view('help/header');?>

<div class="g-bd">
	<div class="g-wrap">
		<div class="g-mn">
			<div class="m-bd">
    			<ul class="ui-tab">
                    <li class="active">快速搜索</li>
                    <li class="normal">
                        <div class="form-box">
                            <form action="/help/search" method="GET">
                                <input type="text" class="u-sch-text" name="keyword" placeholder="请输入产品搜索关键词" >                
                                <input type="submit" value="" class="u-sch-btn" hidefocus="true"></form>
                        </div>
                    </li>
                </ul>
				<ul class="ui-tab ui-tab_1">
					<li class="active">文章内容 ><span> 文章详情 </span></li>
				</ul>
				<div class="g-bd-index">
					<?php if($info):?>
					<h1><?php echo $info['title']?></h1>
					<div class="article_info"><?php echo $info['content']?></div>
					<?php endif;?>
				</div>
			</div>
		</div>
		<div class="g-side">
            <?php $this->load->view('help/menu');?>
		</div>
	</div>
</div>
<?php $this->load->view('help/footer');?>