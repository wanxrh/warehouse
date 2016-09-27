<?php $this->
load->view('header');?>
<div class="g-wrap clearfix">
    <div class="g-mn">
        <div class="g-mnc">
            <!--  正文  -->
            <div class="m-tt">
                <span>
                    全部宝贝管理 <em></em>
                </span>
            </div>
            <div class="m-opbox">
                <form method="get" action="/goods/index">
                    <input type="submit" class="f-fr submit" value="搜索" >
                    <select name="cate_id" id="">
                        <option value="">请选择</option>
                        <?php foreach($cate as $item):?>
                        <option value="<?php echo $item['cate_id'];?>
                            "
                            <?php echo $cate_id== $item['cate_id'] ? 'selected' : ''; ?>
                            >
                            <?php echo $item['cate_name'];?></option>
                        <?php endforeach;?></select>
                    <select name="if_show" id="">
                        <option value="0">请选择</option>
                        <option value="2" <?php echo $if_show==2?'selected':''; ?>>上架</option>
                        <option value="1" <?php echo $if_show==1?'selected':''; ?>>下架</option>
                    </select>
                    <select name="closed" id="">
                        <option value="1" <?php echo $closed==1?'selected':''; ?>>正常</option>
                        <option value="2" <?php echo $closed==2?'selected':''; ?>>禁售</option>

                    </select>
                    <input type="text" class="txt" name="keyword" placeholder="输入关键字" value="<?php echo isset($keyword)?$keyword:''; ?>" ></form>
            </div>
            <table class="u-table">
                <thead>
                    <tr>
                        <th width="50">
                            <input id="all" class="checkall" type="checkbox">
                            <label for="all">全选</label>
                        </th>
                        <th class="shop">宝贝名称</th>
                        <th width="70">分类</th>
                        <th width="60">价格</th>
                        <th width="50">库存</th>
                        <th width="120">状态</th>
                        <th width="130">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($list as $item):?>
                    <tr>
                        <td>
                            <input class="checkitem" type="checkbox" value="<?php echo $item['goods_id']?>" name="goods"></td>
                        <td>
                            <a href="<?php echo goods_url($item['goods_id']);?>" target="_blank">
                                <img src="<?php echo img_url($item['default_image']);?>" alt="" class="pic" onerror="this.onerror=null,this.src='http://src.zbb0.com/user/img/default.gif' "></a>
                            <div class="shopInfo">
                                <?php echo $item['goods_name'];?></div>
                        </td>
                        <td>
                            <?php echo $cate_name[$item['goods_id']];?></td>
                        <td>
                            <span class="s-fc-red">￥<?php echo $item['price'];?></span>
                        </td>
                        <td><?php echo $item['stock'];?></td>
                        <td data-id="<?php echo $item['goods_id']?>">
                            <div class="box_btn open <?php if($item['if_show']==0){?>close<?php }else{?> <?php }?>"  data-isshow="<?php if($item['if_show']==0){?> 1 <?php }else{?> 0 <?php } ?>" >
                                <span data-isshow="1" class="u-set btn-u">上架</span>
                                <span data-isshow="0" class="u-set btn-d">下架</span>
                            </div>
                        </td>
                        <td>
                            <a class="btn" href="/goods/edit?goods_id=<?php echo $item['goods_id'];?>">编辑</a>
                            <button class="btn J_del" data-id="<?php echo $item['goods_id']?>">删除</button>
                        </td>
                    </tr>
                    <?php endforeach; ?></tbody>
                <tfoot>
                    <td colspan="7">
                        <button data-isshow="1" class="btn J_btn">批量上架</button>
                        <button data-isshow="0" class="btn J_btn">批量下架</button>
                        <button class="btn J_del" >批量删除</button>
                    </td>
                </tfoot>
            </table>
            <?php echo $page;?>
            <div class="clearfix">
                <!-- 分布控件 --> </div>
            <!--  正文 END --> </div>
    </div>
    <div class="g-sd">
        <?php $this->load->view('menu');?></div>
</div>

<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>user/js/goodsList.js" charset="utf-8"></script>

<?php $this->
load->view('footer');?>