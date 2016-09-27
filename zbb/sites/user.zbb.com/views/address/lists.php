<?php $this->load->view('header');?>

<div class="g-wrap clearfix">
    <div class="g-mn">
        <div class="g-mnc">
            <!--  正文  -->
            <div class="m-tt">
                <span>退货地址<em></em></span>
            </div>
            <div class="m-opbox">
                <button class="btn f-fr J_add">新增地址</button>
                已经保存了<em class="s-fc-red"><?php echo $limit ?></em>条地址，还能保存<em class="s-fc-red"><?php echo 20-$limit ?></em>条地址  
            </div>
           
            <table class="u-table">
                <thead>
                    <tr>
                        <th>收货人姓名</th>
                        <th>所在地区</th>
                        <th>详细地址</th>
                        <th>邮政编码</th>
                        <th>手机</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                <?php foreach($arr as $v){?>
                    <tr>
                        <td><?php echo $v['consignee'];?></td>
                        <td><?php echo $v['region_name'];?></td>
                        <td><?php echo $v['address'];?></td>
                        <td><?php echo $v['zipcode'];?></td>
                        <td><?php echo $v['mobile'];?></td>
                        <td>
                            <button class="btn J_edit" data-c="<?php echo $v['consignee'];?>" data-r="<?php echo $v['region_name'];?>" data-zip="<?php echo $v['zipcode'];?>" data-m="<?php echo $v['mobile'];?>" data-addr="<?php echo $v['address'];?>" data-id="<?php echo $v['addr_id']?>">编辑</button>
                           <button class="btn J_del" data-id="<?php echo $v['addr_id']?>">删除</button>
                           <button class="btn J_def <?php if($v['is_default']){?> btn-def<?php }?>" data-id="<?php echo $v['addr_id']?>">设为默认</button>
                        </td>
                    </tr>
				<?php }?>
                </tbody>
            </table>
            <?php echo $page; ?>
           
             <!--  正文 END -->
        </div>
    </div>
    <div class="g-sd">
        <?php $this->load->view('menu');?>
    </div>
</div>

    <script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>user/js/refundAddr.js" charset="utf-8"></script>
<?php $this->load->view('footer');?>