<div class="menu" id="J_sideMenu">
    <h1>帮助中心</h1>
    <?php foreach ($cate_list as $v){ ?>            
    <div class="subtt">
        <?php if($v['parent_id']==0){ ?>            
        <h2 class="tt-bgc">
            <?php echo $v['cate_name']; ?></h2>
        <ul >
            <?php foreach($cate_list as $m){ ?>            
            <?php if($v['cate_id'] == $m['parent_id']){ ?>            
            <li>
                <a  href="/help/article/<?php echo $m['cate_id']?>
                    ">
                    <?php echo $m['cate_name']; ?></a>
            </li>
            <?php }?>            
            <?php } ?>
        </ul>
        <?php } ?>
    </div>
    <?php } ?>            
    <div class="menu contact">
        <h1>联系我们</h1>
        <p class="mail">
            售后邮箱:
            <span>2584566640@qq.com</span>
        </p>
        <p>
            客服QQ:
            <span>2584566640@qq.com</span>
        </p>
        <p>人工服务时间</p>
        <p>
            <span>周一至周五</span>
        </p>
        <p>
            <span>早上9:00-12:00</span>
            <span>下午13:30-18:00</span>
        </p>
        <p>( 周六、周日全天休息，请在工作时间联系我们，谢谢合作！)</p>

    </div>
</div>