<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>推送修改</title>
        <link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
<link href="<?php echo $this->config->item('domain_static'); ?>system/css/common.css" rel="stylesheet" type="text/css" />
        <link href="<?php echo $this->config->item('domain_static'); ?>system/css/style.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>system/js/jquery.js"></script>
    </head>
    <body>

        <div class="u-bd-tt">
            <span>位置：</span>
            <ul >
                <li>推送管理</li>
                <li><a href="/recom">商品推送</a></li>
                <li>编辑</li>
            </ul>
        </div>

        <div class="g-mnr">
            <table class="tablelist">
                <tbody>
                    <form id="article_form" enctype="multipart/form-data" method="post">
                        <ul class="forminfo">
                            <li><label>商品名称<b>*</b></label>
                                <input name="title" type="text" class="dfinput" value="<?php echo $row['title'] ?>"  style="width:300px;"/>
                            </li>

                            <li><label>排序<b>*</b></label>
                                <input name="sort" type="text" class="dfinput" value="<?php echo $row['sort'] ?>"  style="width:300px;"/>
                            </li> 

<!--                            <li><label>天猫对比<b>*</b></label>-->
<!--                                <input name="option" type="radio" checked="checked" value="0" />否 <input name="option" type="radio" value="1" />是-->
<!--                            </li>-->

                            <li><label>天猫价格<b>*</b></label>
                                <input name="cost_price" type="text" class="dfinput" value="<?php echo $row['cost_price'] ?>"  style="width:100px;"/>
                            </li>   

                            <li><label>天猫url<b>*</b></label>
                                <input name="url" type="text" class="dfinput" value="<?php echo $row['url'] ?>"  style="width:500px;"/>
                            </li> 

                            <li><label>图片<b>*</b></label>
                                <input type="file" name="img" class="dfinput" value=""  style="width:300px;"/><?php if($cid==7){echo '图片必须为157*343'; };?>
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
