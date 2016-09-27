<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>文章分类列表</title>
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
                <li>文章管理</li>
                <li><a href="/acategory">文章分类列表</a></li>

            </ul>
        </div>

        <div class="g-mnr">
            <div class="tools">
                <ul class="toolbar">
                    <li><a href="/acategory/add">添加<span><img src="<?php echo $this->config->item('domain_static'); ?>system/images/t01.png" /></span></a></li>
                </ul>
                
            </div>


            <table class="tablelist">

                <thead>
                    <tr>
                        <th><input name="" type="checkbox" value="" checked="checked"/></th>
                        <th>编号</th>
                        <th>分类名称</th>
                        <th>排序</th>
                        <th>操作</th>
                    </tr>
                </thead>

                <tbody>
                    <?php foreach ($list as $item): ?>
                        <tr>
                            <td><input type="checkbox" class="checkitem" value="<?php echo $item['cate_id'] ?>" /></td>
                            <td><?php echo $item['cate_id'] ?></td>
                            <td><?php echo $item['cate_name'] ?></td>
                            <td><?php echo $item['sort_order'] ?></td>
                            <td><a href="/acategory/edit/id/<?php echo $item['cate_id'] ?>">编辑</a> | 
                                <a href="/acategory/delete/id/<?php echo $item['cate_id'] ?>" onclick="if(confirm('确定删除?')==false)return false;">删除</a>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>

            </table>

        </div>

            <script type="text/javascript">
                $('.imgtable tbody tr:odd').addClass('odd');
            </script>

    </body>

</html>
