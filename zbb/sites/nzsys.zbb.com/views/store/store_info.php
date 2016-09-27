<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>修改店铺</title>
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
                <li>店铺管理</li>
                <li><a href="/store">店铺列表</a></li>
                <li><a href="/store/edit?id=<?php echo $row['store_id']?>">编辑</a></li>
                <li>执照证件审核</li>
            </ul>
        </div>      

        <div id="tab1" class="tabson">
            <form action="" method="post" enctype="multipart/form-data">
                <ul class="forminfo">
                    <li><label>营业执照<b>*</b></label><img src="<?php echo $this->config->item('domain_img'); ?><?php echo $row['image_1'] ?>"/></li>
                    <li><label>身份证正面<b>*</b></label><img src="<?php echo $this->config->item('domain_img'); ?><?php echo $row['image_2'] ?>"/></li>
                    <li><label>身份证反面<b>*</b></label><img src="<?php echo $this->config->item('domain_img'); ?><?php echo $row['image_3'] ?>"/></li>
                    <li><label>审核<b>*</b></label>
                        <input name="store_license" type="radio" <?php if ($row['store_license'] == 1): ?>checked="checked"<?php endif; ?> value="1"/>通过审核
                        <input name="store_license" type="radio" <?php if ($row['store_license'] == 0): ?>checked="checked"<?php endif; ?> value="0"/>待审核
                        <input name="store_license" type="radio" <?php if ($row['store_license'] == 2): ?>checked="checked"<?php endif; ?> value="2"/>审核失败
                    </li> 
                    <li><label>&nbsp;</label><input name="" type="submit" class="u-btn" value="返回修改"/></li>
                    <li style="height: 100px;"></li>
                </ul>
            </form>
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
            $('.imgtable tbody tr:odd').addClass('odd');
        </script>

    </body>

</html>
