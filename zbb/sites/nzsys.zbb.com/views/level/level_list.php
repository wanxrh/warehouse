<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>权限列表</title>
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
                <li>权限管理</li>
                <li><a href="/level_list">权限列表</a></li>
            </ul>
        </div>

        <div class="g-mnr">
             <div class="tools">
            <ul class="toolbar">
                <li><a href="/level/level_add">新增权限<span><img src="<?php echo $this->config->item('domain_static'); ?>system/images/t01.png" /></span></a></li>
            </ul>
            </div>

            <table class="tablelist">

                <thead>
                    <tr align="center">
                        <th><input name="" type="checkbox" value="" checked="checked"/></th>
                        <th>编号</th>
                        <th>权限名称</th>
                        <th>操作</th>
                    </tr>
                </thead>

                <tbody>
                    <?php foreach ($list as $item): ?>
                        <tr align="center">
                            <td><input type="checkbox" class="checkitem" value="<?php echo $item['level_id'] ?>" /></td>
                            <td><?php echo $item['level_id'] ?></td>
                            <td><?php echo $item['level_name'] ?></td>   
                            <td><a href="/level/level_edit/id/<?php echo $item['level_id'] ?>">修改名称</a></td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>

            </table>

            <div class="pagin">  	
                <ul class="paginList"> 
                </ul>
            </div>


        </div>

        <div class="tip">
            <div class="tiptop"><span>提示信息</span><a></a></div>

            <div class="tipinfo">
                <span><img src="images/ticon.png" /></span>
                <div class="tipright">
                    <p>是否确认对信息的修改 ？</p>
                    <cite>如果是请点击确定按钮 ，否则请点取消。</cite>
                </div>
            </div>

            <div class="tipbtn">
                <input name="" type="button"  class="sure" value="确定" />&nbsp;
                <input name="" type="button"  class="cancel" value="取消" />
            </div>

        </div>

        <script type="text/javascript">
            $('.tablelist tbody tr:odd').addClass('odd');
        </script>

    </body>

</html>
<script type="text/javascript">







</script>