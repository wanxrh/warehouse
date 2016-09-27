<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>添加文章</title>
        <link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
<link href="<?php echo $this->config->item('domain_static'); ?>system/css/common.css" rel="stylesheet" type="text/css" />
        <link href="<?php echo $this->config->item('domain_static'); ?>system/css/style.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>system/js/jquery.js"></script>

        <script charset="utf-8" src="<?php echo $this->config->item('domain_static'); ?>common/kindeditor/kindeditor.js"></script>
        <script charset="utf-8" src="<?php echo $this->config->item('domain_static'); ?>common/kindeditor/lang/zh_CN.js"></script>
        <script>
            KindEditor.ready(function (K) {
                var editor1 = K.create('textarea[name="content"]', {
                    allowImageUpload: true,
                    uploadJson: "/article/upload", //图片上传后的处理地址
                    afterBlur: function () {
                        this.sync();
                    }
                });
            });
        </script>

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
                <li><a href="/article">文章列表</a></li>
                <li><a href="/article/add">文章添加</a></li>
            </ul>
        </div>

        <div class="g-mnr">


            <table class="tablelist">
                <tbody>
                    <form id="article_form" enctype="multipart/form-data" method="post">
                        <ul class="forminfo">
                            <li><label>标题<b>*</b></label>
                                <input maxLength="40" id="title" class="dfinput" type="text" value="" name="title"></li>    

                            <li><label>所属分类<b>*</b></label>
                                <select id="cate_id" class="querySelect" name="cate_id">
                                    <option value="">请选择...</option>
                                    <?php foreach ($acategory as $item): ?>
                                        <option value="<?php echo $item['cate_id'] ?>"><?php echo $item['cate_name'] ?></option>
                                    <?php endforeach; ?>
                                </select>
                            </li>
									

                            <li><label>链接<b>*</b></label><input id="link" class="dfinput" type="text" value="" name="link" maxLength="100" >如：http://www.baidu.com</li>   

                            <li><label>显示<b>*</b></label>
                                <input id="yes" type="radio" checked="checked" value="1" name="if_show">
                                    是
                                    <input id="no" type="radio" value="0" name="if_show">
                                        否
                                        </li>

                                        <li><label>排序<b>*</b></label><input maxLength="3" onkeyup="this.value = this.value.replace(/\D/g, '')" onafterpaste="this.value=this.value.replace(/\D/g,'')" id="sort_order" class="dfinput" type="text" value="255" name="sort_order"></li>   

                                        <li><label>文章内容<b>*</b></label><textarea name="content" id="description" style="width: 80%; height: 400px;"></textarea></li>

                                        <li><label>&nbsp;</label><input  type="submit" class="u-btn" value="提交" id="submit"/></li>
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
