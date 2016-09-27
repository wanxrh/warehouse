<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>文章分类修改</title>
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
                <li>修改</li>
            </ul>
        </div>

        <div class="g-mnr">
            <table class="tablelist">
                <tbody>
                    <form id="article_form" enctype="multipart/form-data" method="post">
                        <ul class="forminfo">
                            <li><label>分类名称<b>*</b></label>
                                <input name="cate_name" type="text" maxLength="15" class="dfinput" value="<?php echo $row['cate_name'] ?>"  style="width:300px;"/>
                                <i>名称不能超过15个字符</i>
                            </li>

                            <li><label>上级分类<b>*</b></label>
                                <select id="cate_id" class="querySelect" name="parent_id">
                                    <option value="0">请选择...</option>
                                    <option value="0">顶级</option>
                                    <?php foreach ($acategory as $item): ?>
                                        <option value="<?php echo $item['cate_id'] ?>" <?php if ($row['parent_id'] == $item['cate_id']): ?>selected="selected"<?php endif; ?>><?php echo $item['cate_name'] ?></option>
                                    <?php endforeach; ?>
                                </select>
                            </li>



                            <li><label>排序<b>*</b></label>
                                <input maxLength="3" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" name="sort_order" type="text" class="dfinput" value="<?php echo $row['sort_order'] ?>"  style="width:300px;"/>
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
