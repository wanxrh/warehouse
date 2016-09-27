<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>无标题文档</title>
        <link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
<link href="<?php echo $this->config->item('domain_static'); ?>system/css/common.css" rel="stylesheet" type="text/css" />
        <link href="<?php echo $this->config->item('domain_static'); ?>system/css/style.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>system/js/jquery.js"></script>
        <style>
          .text_ct,.text_sel{padding: 5px 10px;border:solid 1px #ccc;background-color: #fff;display: inline;margin-top: 5px;}
          .text-pos{padding-top:10px; }
        </style>
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
                <li>商品管理</li>

                <li>编辑</li>
            </ul>
        </div>

        <div class="g-mnr">
            <h1 style="padding:10px 0 20px 23px;font-size:14px;">商品编辑</h1>
            <table class="tablelist">
                <tbody>
                    <form id="article_form"  action="edit_add" method="post">
                        <input type="hidden"name="goods_id" value="<?php echo $goods['goods_id']?>">
                        <ul class="forminfo">
                            <li><label>商品名称:</label>
                                <input name="goods_name" class="text_ct" type="text" value="<?php echo $goods['goods_name'] ?>"></input>
                            </li>
                            <li><label>店铺名称:</label>
                                <span class="shop-name"><?php echo $goods['store_name'] ?></span>
                            </li>
                            <li><label>状态：</label>
                                <span class="text-pos">
                                <input type="radio" name="if_show" class="cate-type" value="1" <?php if ($goods['if_show'] == 1) {echo 'checked="checked"';}?> />上架
                                <input type="radio" name="if_show" class="cate-type" value="0" <?php if ($goods['if_show'] == 0) {echo 'checked="checked"';}?> />下架
                                <input type="radio" name="if_show" class="cate-type" value="2" <?php if ($goods['closed'] == 1) {echo 'checked="checked"';}?> />禁售
                                </span>
                            </li>

                            <li><label>&nbsp;</label><input name="" type="submit" class="u-btn" value="提交"/></li>
                        </ul>
                    </form>
                </tbody>
            </table>


    </body>

</html>
