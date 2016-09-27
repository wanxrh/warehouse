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
        <div class="g-mnr">
            <div class="u-bd-tt">
                <span>位置：</span>
                <ul >
                    <li><a href="#">apk版本</a></li>
                    <li><a href="#">更新版本</a></li>
                </ul>
            </div>

            <div class="formbody">

                <div class="formtitle"><span>基本信息</span></div>

                <ul class="forminfo">
                    <form method="post" action="/apk/renew" enctype="multipart/form-data" >
                        <li><label>版本</label><input name="version" value="<?php echo $apk_info['version'];?>"  maxLength="15" type="text" class="dfinput" /></li>
                        <li><label>描述</label><input name="content" type="text" class="dfinput" value="<?php echo $apk_info['content'];?>" /></li>
                        <li><label>上传apk</label><input class="infoTableFile2" id="brand_logo" name="apk" type="file" value="<?php echo $apk_info['url']?>"></li>
                        <li><label>强制</label><input name="is_open" type="radio" <?php if($apk_info['is_open']){?>checked<?php }?> value="1">是<input name="is_open" <?php if(!$apk_info['is_open']){?>checked<?php }?> type="radio" value="0">否</li>
                        <li><label>&nbsp;</label><input name="" type="submit" class="u-btn" value="确认保存"/></li>
                     </form> 
                </ul>
            </div>
    </body>
</html>
