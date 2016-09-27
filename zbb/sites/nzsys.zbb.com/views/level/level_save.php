<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>修改权限名称</title>
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
                <li>修改</li>
            </ul>
        </div>

        <div class="g-mnr">
            <table class="tablelist">
                <tbody>
                    <form id="article_form"  method="post">
                        <ul class="forminfo">



                            <li style="line-height: 35px;"><label>名称<b>*</b></label>
                                <input name="level_name" type="text" class="dfinput" value="<?php echo $row['level_name']; ?>"  style="width:300px;" maxLength="100" onkeyup="value=value.replace(/[\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[\d]/g,''))"/>    
                            </li>


                            <li><label>&nbsp;</label><input name="" type="submit" class="u-btn" value="提交"/></li>
                    </form>
                </tbody>
            </table>
        </div>    
        <script type="text/javascript">
            $('.imgtable tbody tr:odd').addClass('odd');
        </script>

    </body>

</html>
<script type="text/javascript">
    $("#all_check").click(function () {
        $("#all_checkbox input").attr("checked", "checkbed");
    });

    $("#all_none").click(function () {
        $("#all_checkbox input").attr("checked", "");
    });

    $("#all_uncheck").click(function () {
        var len = $("#all_checkbox input").length;
        for (var i = 0; i < len; i++) {
            if ($("#all_checkbox input").eq(i).is(":checked")) {
                $("#all_checkbox input").eq(i).attr("checked", "");
            } else {
                $("#all_checkbox input").eq(i).attr("checked", "checked");
            }

        }
    });
</script>