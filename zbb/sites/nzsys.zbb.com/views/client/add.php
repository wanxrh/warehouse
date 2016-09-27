<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>上传文件</title>
        <script charset="utf-8" src="<?php echo $this->config->item('domain_static'); ?>common/kindeditor/kindeditor.js"></script>
        <script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>system/js/jquery.js"></script>
        <script charset="utf-8" src="<?php echo $this->config->item('domain_static'); ?>common/kindeditor/lang/zh_CN.js"></script>
        <link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
<link href="<?php echo $this->config->item('domain_static'); ?>system/css/common.css" rel="stylesheet" type="text/css" />
        <link href="<?php echo $this->config->item('domain_static'); ?>system/css/style.css" rel="stylesheet" type="text/css" />
    </head>

    <body>

        <div class="u-bd-tt">
            <span>位置：</span>
            <ul >
                <li>客户端软件管理</li>
                <li>文件上传</li>
            </ul>
        </div>

        <div class="formbody">

            <div class="formtitle"><span>文件上传</span></div>
            <form method="post" action="/client/upload" enctype="multipart/form-data">
                <ul class="forminfo">
                    <li><label>文件路径</label><input type="file" name="client_name" />
                    </li>
						 <li><label>版本</label><input name="version" value=""  maxLength="15" type="text" class="dfinput" /></li>
                        <li><label>描述</label><input name="content" type="text" class="dfinput" value="" /></li>
                </ul>
                    <li><input type="submit" class="u-btn" value="提交"/>
                    </li>
            </form>

        </div>

    </body>

</html>
