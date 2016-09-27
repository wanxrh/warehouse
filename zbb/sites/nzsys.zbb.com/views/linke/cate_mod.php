<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>无标题文档</title>
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
                    <li><a href="/linkecate?type=1">文字推送</a></li>
            </ul>
        </div>
        <div class="g-mnr">
            <div class="formbody">
                <div class="formtitle"><span>基本信息</span></div>
                <ul class="forminfo">
                    <form method="post" action="/linkecate/cate_mod" >
                        <li><label>标题</label><input name="name" value="<?php echo $cate_info['name'];?>"  maxLength="15" type="text" class="dfinput" />
                        <i>标题不能超过15个字符</i></li>
                        <li><label>&nbsp;</label><input name="" type="submit" class="u-btn" value="确认保存"/><input  name="id" value="<?php echo $cate_info['id'];?>" type="hidden"/><input  name="type" value="<?php echo $_GET['type'];?>" type="hidden"/></li>
                     </form> 
                </ul>
            </div>
            <script type="text/javascript">
                $('.imgtable tbody tr:odd').addClass('odd');
            </script>
    </body>
</html>
