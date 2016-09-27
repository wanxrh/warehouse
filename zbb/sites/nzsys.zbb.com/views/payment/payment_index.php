<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>支付列表</title>
        <link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
<link href="<?php echo $this->config->item('domain_static'); ?>system/css/common.css" rel="stylesheet" type="text/css" />
        <link href="<?php echo $this->config->item('domain_static'); ?>system/css/style.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>system/js/jquery.js"></script>

        <script type="text/javascript">
            $(document).ready(function () {
                $(".click").click(function () {
                    $(".tip").fadeIn(200);
                });

                $(".tiptop a").click(function () {
                    $(".tip").fadeOut(200);
                });

                $(".sure").click(function () {
                    $(".tip").fadeOut(100);
                });

                $(".cancel").click(function () {
                    $(".tip").fadeOut(100);
                });

            });
        </script>


    </head>


    <body>

        <div class="u-bd-tt">
            <span>位置：</span>
            <ul >
                <li>其他管理</li>
                <li><a href="/payment">支付列表</a></li>

            </ul>
        </div>

        <div class="g-mnr">
            <div class="tools">
                <ul class="toolbar">
                    <li><a href="/payment/add_payment">添加<span><img src="<?php echo $this->config->item('domain_static'); ?>system/images/t01.png" /></span></a></li>
                </ul>
            </div>


            <table class="tablelist">

                <thead>
                    <tr align="center">
                        <th>支付方式码</th>
                        <th>支付名称</th>
                        <th>支付方式详情</th>
                        <th>图标</th>
                        <th>是否开启</th>
                        <th>排序</th>
                        <th>操作</th>
                    </tr>
                </thead>

                <tbody>
                    <?php foreach ($list as $item): ?>
                        <tr align="center">
                            <td><?php echo $item['payment_code'] ?></td>
                            <td><?php echo $item['payment_name'] ?></td>
                            <td><?php echo $item['payment_desc'] ?></td>
                            <td>
                            	<img src="<?php echo img_url($item['icon']);?>" alt="" class="pic">
                            </td>
                            <td><?php echo $item['enabled'] ?></td>
                            <td><?php echo $item['sort_order'] ?></td>
                            <td>
                                <a href="/payment/edit_payment?payment_id=<?php echo $item['payment_id'] ?>">编辑</a> | 
                                <a href="/payment/del_payment?payment_id=<?php echo $item['payment_id'] ?>" onclick="if(confirm('确定删除？')==false)return false;">删除</a> 
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>

            </table>



            <script type="text/javascript">
                $('.imgtable tbody tr:odd').addClass('odd');
            </script>

    </body>

</html>
