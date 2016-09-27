<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>添加权限</title>
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
                <li><a href="/level/level_list">权限列表</a></li>
                <li><a href="/level/level_add">添加权限</a></li>
            </ul>
        </div>

        <div class="g-mnr">
            <table class="tablelist">
                <tbody>
                    <form id="article_form" enctype="multipart/form-data" method="post">
                        <ul class="forminfo">
                            <li><label>权限名称<b>*</b></label>
                                <input name="level_name" type="text" class="dfinput" value=""  style="width:300px;" maxLength="100" onkeyup="value=value.replace(/[\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[\d]/g,''))"/>
                            </li>    
                                <li><label>上级权限<b>*</b></label>
                                    <select id="cate_id" class="querySelect" name="parent_id">
                                        <option value="">请选择...</option>
                                        <option value="0">顶级</option>
                                        <?php foreach ($level as $item): ?>
                                            <option value="<?php echo $item['level_id'] ?>"><?php echo $item['level_name'] ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </li>

                            <li><label>&nbsp;</label><input name="" type="submit" class="u-btn" value="提交"/></li>
                        </ul>
                    </form>
                </tbody>
            </table>
        </div>    
        <script type="text/javascript">
            $('.imgtable tbody tr:odd').addClass('odd');
        </script>

    </body>

</html>
