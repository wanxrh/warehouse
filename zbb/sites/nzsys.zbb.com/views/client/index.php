<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>文件夹列表</title>
        <link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
<link href="<?php echo $this->config->item('domain_static'); ?>system/css/common.css" rel="stylesheet" type="text/css" />
        <link href="<?php echo $this->config->item('domain_static'); ?>system/css/style.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>system/js/jquery.js"></script>

        <script type="text/javascript">
            $(document).ready(function () {
                $(".del-confirm").click(function () {
                    $(".tip").fadeIn(200);
                });

                $(".tiptop a").click(function () {
                    $(".tip").fadeOut(200);
                });

                $(".sure").click(function () {
                    $(".tip").fadeOut(100);
					window.location = $(".del-confirm").attr('locaturl');
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
                <li>客户端软件管理</li>
                <li>文件列表</li>

            </ul>
        </div>

        <div class="g-mnr">
			<div class="tools">

                <ul class="toolbar">
                    <li><a href="/client/upload">上传新软件<span><img src="<?php echo $this->config->item('domain_static'); ?>system/images/t01.png" /></span></a></li>
                </ul>
            </div>
            <table class="tablelist">

                <thead>
                    <tr>
                        <th>编号</th>
                        <th>文件名称</th>
                        <th>操作</th>
                       
                    </tr>
                </thead>

                <tbody>
                <?php if(!empty($files)): ?>
              		<?php foreach($files as $key=>$file): ?>
                        <tr>
                        	<td><?php echo $key+1; ?></td>
                            <td><?php echo $file; ?></td>
                            <td><a class="del-confirm" href="Javascript:void(0)" locaturl="/client/delete?name=<?php echo $file; ?>">删除</a>&nbsp;<a href="<?php echo $this->config->item('domain_download').'client/'.$file; ?>">下载</a></td>
                        </tr>
                    <?php endforeach; ?>
            	<?php else: ?>
                		<tr><td colspan="3">暂无数据</td></tr>
                <?php endif; ?>
                </tbody>

            </table>

            <div class="pagin">  	
                <ul class="paginList">
                   
                </ul>
            </div>


        </div>

        <div class="tip">
            <div class="tiptop"><span>提示信息</span><a></a></div>

            <div class="tipinfo">
                <span><img src="<?php echo $this->config->item('domain_static'); ?>system/images/ticon.png" /></span>
                <div class="tipright">
                    <p>是否确认删除该文件 ？</p>
                    <cite>如果是请点击确定按钮 ，否则请点取消。</cite>
                </div>
            </div>

            <div class="tipbtn">
                <input name="" type="button"  class="sure" value="确定" />&nbsp;
                <input name="" type="button"  class="cancel" value="取消" />
            </div>

        </div>

    </body>

</html>
