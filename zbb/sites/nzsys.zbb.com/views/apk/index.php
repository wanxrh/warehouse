<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>文件夹列表</title>
        <link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
<link href="<?php echo $this->config->item('domain_static'); ?>system/css/common.css" rel="stylesheet" type="text/css" />
        <link href="<?php echo $this->config->item('domain_static'); ?>system/css/style.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>system/js/jquery.js"></script>
    </head>
    <body>

        <div class="u-bd-tt">
            <span>位置：</span>
            <ul >
                <li>apk版本管理</li>
                <li>apk版本信息</li>
            </ul>
        </div>

        <div class="g-mnr">
            <table class="tablelist">

                <thead>
                    <tr>
                        <th>版本号</th>
                        <th>更新描述</th>
                        <th>操作</th>
                    </tr>
                </thead>

                <tbody>
                        <tr>
                        	<td><?php echo $apk_info['version'];?></td>
                            <td><?php echo $apk_info['content'];?></td>
                            <td><a href="/apk/renew">更新</a></td>
                        </tr>
                </tbody>
            </table>
        </div>
    </body>
</html>