<?php $this->load->view('header');?>

    <div class="g-wrap clearfix">
        <div class="g-mn">
            <div class="g-mnc">
                <!--  正文  -->
                <div class="m-tt">
                    <span>宝贝分类管理<em></em></span>
                </div>
                <div class="m-opbox">
                    <button class="f-fr btn J_add"> 新增商品分类</button>
                </div>

                <table class="u-table">
                    <thead>
                    <tr>
                        <th>分类名称</th>
                        <th>排序</th>
                        <th>显示</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                <?php foreach($cate as $value):?>
                    <?php if($value['parent_id']==0):?>
                    <tbody>
                    <tr>
                        <td><?php echo $value['cate_name'];?></td>
                        <td><?php echo $value['sort_order'];?></td>
                        <td><?php if($value['if_show']==1){?>是<?php }else{?>否<?php }?></td>
                        <td>
                            <button class="btn J_add" data-id="<?php echo $value['cate_id'];?>">新增下级</button>
                            <button class="btn J_edit" data-lv="1"  data-show="<?php echo $value['if_show'];?>" data-tt="<?php echo $value['cate_name'];?>" data-sort="<?php echo $value['sort_order'];?>" data-id="<?php echo $value['cate_id'];?>">编辑</button>
                            <button class="btn J_del" data-id="<?php echo $value['cate_id'];?>">删除</button>
                        </td>
                    </tr>
                        <?php foreach($all as $v):?>
                            <?php if($v['parent_id']==$value['cate_id']):?>
                                <tr>
                                    <td><?php echo $v['cate_name'];?></td>
                                    <td><?php echo $v['sort_order'];?></td>
                                    <td><?php if($v['if_show']==1){?>是<?php }else{?>否<?php }?></td>
                                    <td>
                                        <button class="btn J_edit" data-tt="<?php echo $v['cate_name'];?>" data-pid="<?php echo $value['cate_id'];?>" data-sort="<?php echo $v['sort_order'];?>" data-show="<?php echo $v['if_show'];?>" data-lv="2" data-id="<?php echo $v['cate_id'];?>">编辑</button>
                                        <button class="btn J_del" data-lv="2" data-id="<?php echo $v['cate_id'];?>" >删除</button>
                                    </td>
                                </tr>
                            <?php endif;?>
                        <?php endforeach;?>
                    </tbody>
                    <?php endif;?>
                <?php endforeach;?>
                </table>
                <?php echo $page;?>
            </div>
        </div>
        <div class="g-sd">
            <?php $this->load->view('menu');?>
        </div>
    </div>
<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>user/js/typeList.js" charset="utf-8"></script>

<?php $this->load->view('footer');?>