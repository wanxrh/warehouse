<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>会员修改</title>
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
                <li>会员管理</li>
                <li><a href="/user">会员列表</a></li>
                <li>编辑</li>
            </ul>
        </div>

        <div class="g-mnr">


        </div>


        <table class="tablelist">
            <tbody>
                <form method="post" enctype="multipart/form-data" id="user_form" action="">
                    <ul class="forminfo">
                        <li><label>会员名<b>*</b></label>
                            <input maxLength="50" name="user_name" type="text" class="dfinput" value="<?php echo $row['user_name'] ?>"  style="width:300px;"/>
                        </li>       
                        <li><label>电子邮箱<b>*</b></label>
                            <input maxLength="20" name="email" type="text" class="dfinput" value="<?php echo $row['email'] ?>"  style="width:300px;"/>
                        </li>
                        <li><label>真实姓名<b>*</b></label>
                            <input maxLength="20" name="real_name" type="text" class="dfinput" value="<?php echo $row['real_name'] ?>"  style="width:300px;"/>
                        </li>

                        <li><label>性别<b>*</b></label>
                            <label>
                                <input name="gender" type="radio" value="0" <?php if ($row['gender'] == 0): ?>checked="checked"<?php endif; ?> />
                                保密</label>
                            <label>
                                <input type="radio" name="gender" value="1" <?php if ($row['gender'] == 1): ?>checked="checked"<?php endif; ?> />
                                男</label>
                            <label>
                                <input type="radio" name="gender" value="2" <?php if ($row['gender'] == 2): ?>checked="checked"<?php endif; ?> />
                                女</label>
                        </li>

                        <li><label>QQ<b>*</b></label>
                            <input maxLength="15" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" name="im_qq" type="text" class="dfinput" value="<?php echo $row['im_qq'] ?>"  style="width:300px;"/>
                        </li>

                        <li><label>MSN<b>*</b></label>
                            <input name="im_msn" type="text" class="dfinput" value="<?php echo $row['im_msn'] ?>"  style="width:300px;"/>
                        </li>

                        <li><label>头像<b>*</b></label>
                            <img width="120" height="120" src="<?php echo $this->config->item('domain_img'); ?><?php echo $row['portrait'] ?>"/>
                        </li>


                        <li><label>&nbsp;</label><input name="" type="submit" class="u-btn" value="提交"/></li>
                    </ul>
                </form>
            </tbody>
        </table>





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
