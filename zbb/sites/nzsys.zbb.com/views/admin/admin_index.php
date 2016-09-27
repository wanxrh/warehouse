<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>管理员列表</title>
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
                <li><a href="/admin">管理员列表</a></li>
            </ul>
        </div>

        <div class="g-mnr">
            <div class="tools">

                <ul class="toolbar">
                    <li><a href="/admin/add">添加<span><img src="<?php echo $this->config->item('domain_static'); ?>system/images/t01.png" /></span></a></li>
                </ul>

            </div>


            <table class="tablelist">
                <thead>
                    <tr align="center">
                        <th><input name="" type="checkbox" value="" checked="checked"/></th>
                        <th>编号</th>
                        <th>用户名 | 真实姓名</th>
                        <th>电子邮件</th>
                        <th>上次登录</th>
                        <th>登录次数</th>
                        <th>操作</th>
                    </tr>
                </thead>

                <tbody>

                    <?php foreach ($list as $item): ?>
                        <tr align="center">
                            <td><input type="checkbox" class="checkitem" value="<?php echo $item['user_id'] ?>" /></td>
                            <td><?php echo $item['user_id'] ?></td>
                            <td><?php echo $item['user_name'] ?>|<?php echo $item['im_iww'] ?></td>
                            <td><?php echo $item['email'] ?></td>
                            <td><?php echo date('Y-m-d',$item['last_login']); ?><br /><?php echo $item['last_ip'] ?></td>
                            <td><?php echo $item['logins'] ?></td>
                            <td>
                                <a href="/admin/delete/id/<?php echo $item['user_id'] ?>" onclick="if(confirm('确定取消管理员资格?')==false)return false;">取消管理员资格</a> | 
                                <?php if($item['super_admin'] == 0): ?>
                                <a href="/admin/super_admin/id/<?php echo $item['user_id'] ?>">设为超管</a>
                                <?php else: ?>
                                已为超管
                                <?php endif; ?>
                            </td>
                        </tr>
                    <?php endforeach; ?> 


                </tbody>
            </table>


            <div class="pagin">
                <?php echo $page; ?>
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




        </div>

        <script type="text/javascript">
            $('.tablelist tbody tr:odd').addClass('odd');
        </script>

    </body>

</html>
