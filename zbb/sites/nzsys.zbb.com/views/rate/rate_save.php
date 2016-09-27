<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>商品分类管理</title>
    <link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
    <link href="<?php echo $this->config->item('domain_static'); ?>system/css/common.css" rel="stylesheet"
          type="text/css"/>
    <link href="<?php echo $this->config->item('domain_static'); ?>system/css/style.css" rel="stylesheet"
          type="text/css"/>

    <script type="text/javascript"
            src="<?php echo $this->config->item('domain_static'); ?>common/js/jquery-1.11.0.min.js"
            charset="utf-8"></script>
    <script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>system/js/cate.js"></script>
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
    <ul>
        <li>资金管理</li>
        <li><a href="/rate">服务费资费标准</a></li>
        <li>新增</li>
    </ul>
</div>

<div class="g-mnr">
    <table class="tablelist">
        <tbody>
        <form id="article_form" enctype="multipart/form-data" method="post">
            <input type="hidden" name="cate_id" value="<?php echo $cate_id ?>" />
            <ul class="forminfo">
                <li><label>分类:</label>
                    <label><?php echo $cate_name ?></label>
                </li>


                <li><label>资费标准<b>*</b></label>
                    <input  name="rate" type="text" class="dfinput" value="<?php $rate1 = $rate?$rate:0.05; echo $rate1 ?>" style="width:300px;"/>
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
