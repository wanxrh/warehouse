<?php $this->load->view('header');?>

<div class="g-wrap clearfix">
    <div class="g-mn">
        <div class="g-mnc">
            <!--  正文  -->
            <div class="m-tt">
                <span>运费模板列表<em></em></span>
            </div>
            <div class="m-opbox">
                    <div class="f-tar">
                        <button class="btn">新增商品分类</button>
                    </div>
            </div>
           
            <table class="u-table">
                <thead>
                    <tr>
                        <th>模板名称</th>
                        <th>首件邮费（元）</th>
                        <th>是否启用模板</th>
                        <th>备注</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>顺风</td>
                        <td><span class="s-fc-red">￥10.00</span></td>
                        <td>是</td>
                        <td>偏远地区专用</td>
                        <td>
                           <button class="btn">编辑</button>
                           <button class="btn">删除</button>
                        </td>
                    </tr>
                     <tr>
                        <td>顺风</td>
                        <td><span class="s-fc-red">￥10.00</span></td>
                        <td>是</td>
                        <td>偏远地区专用</td>
                        <td>
                           <button class="btn">编辑</button>
                           <button class="btn">删除</button>
                        </td>
                    </tr>
                </tbody>
               
            </table>
           
             <!--  正文 END -->
        </div>
    </div>
    <div class="g-sd">
        <?php $this->load->view('menu');?>
    </div>
</div>


<?php $this->load->view('footer');?>