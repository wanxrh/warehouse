<div class="tt">操作日记</div>
<div class="cont">
    <?php if(isset($log_arr)){?>
    <?php foreach ($log_arr as $v){?>
        <div class="lst">
            <div class="info">
                <p class="name-tt">
                    <span><?php echo $v['node_time'];?></span>
                </p>
                <p class="instructions">
                    <span><?php echo isset($v['node'])?$v['node']:'';?></span>
                </p>
                <?php if(isset($v['content'])){?>
                <?php foreach ($v['content'] as $c){?>
                <p class="clearfix">
                    <span><?php echo $c;?></span>
                </p>
                <?php }}?>

                <?php if(isset($v['proof'])){?>
                <p class="goods-img">
                    <?php foreach ($v['proof'] as $m){?>
                        <img src="<?php echo $m;?>">
                    <?php }?>
                </p>
                <?php }?>
            </div>
        </div>
    <?php }?>
    <?php }?>
</div>