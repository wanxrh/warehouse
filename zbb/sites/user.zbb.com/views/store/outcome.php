<?php $this->load->view('header');?>

<div class="g-wrap clearfix">
    <div class="m-step">
        <span class="dot">1
            <h3>入驻店铺信息</h3>
        </span>
        <span class="dot act-2">2
            <h3>企业信息填写</h3>
        </span>
        <span class="dot act-3">3
            <h3>　审核中　　</h3>
        </span>
        <span class="dot act-4">4
            <h3>开店结果公布</h3>
        </span>
        <div class="line">
            <div class="move-4"></div>
        </div>
    </div>

    <div class="m-store">
        <div class="lose">
            <span class="ico">
            </span>
            <p>审核失败！</p>
            <p class="info"><span>失败原因:</span><?php echo $info['comment'];?></p>
            <p class="f-tac">
                <a href="/store/company" class="link">立即修改</a>
            </p>
        </div>
    </div>
</div>


<?php $this->load->view('footer');?>