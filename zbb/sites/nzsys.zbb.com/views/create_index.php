<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>无标题文档</title>
        <link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
<link href="<?php echo $this->config->item('domain_static'); ?>system/css/common.css" rel="stylesheet" type="text/css" />
        <link href="<?php echo $this->config->item('domain_static'); ?>system/css/style.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>system/js/jquery.js"></script>

        <script type="text/javascript">
            $(document).ready(function() {
                $(".click").click(function() {
                    $(".tip").fadeIn(200);
                });
                $(".tiptop a").click(function() {
                    $(".tip").fadeOut(200);
                });
                $(".sure").click(function() {
                    $(".tip").fadeOut(100);
                });
                $(".cancel").click(function() {
                    $(".tip").fadeOut(100);
                });
            });</script>
        <style type="text/css">
            body,div,ul,li{
                margin:0 auto;
                padding:0;
            }
            ul{
                list-style:none;
            }
            .main{
                clear:both;
                padding:2px;
            }
            #tabs {
                min-height: 720px;
                width: 80%;
                margin: 0 auto;
                border: 1px solid #cbcbcb;
            }
            .bar {
                background: #CCC;
                height:30px;
            }
            .menu0{
                width: 200px;
                margin: 0 auto;
            }
            .menu0 li{
                display:block;
                float: left;
                padding: 4px 0;
                height:22px;
                width:100px;
                text-align: center;
                cursor:pointer;
                background: #CCC;
            }
            .menu0 li.hover{
                background: #FFF;
            }
            #main0 ul{
                display: none;
            }
            #main0 ul.block{
                display: block;
            }
            .block {
                margin: 0;
            }
        </style>

    </head>
    <body>
        <div id="tabs">
            <div class="main" id="main0">
                <ul class="block"><li>
                        <span style="width: 98%;height: 30px;float:left;text-align: center;">
                            <input type="button" name="" value="生成新版首页静态文件" onclick="put_new_cache();" style="width:150px;height:30px;">
                        </span>
                        <iframe name="newwindow" height="700px" width="98%" border="0" frameborder="no" noresize="noresize" src="<?php echo $this->config->item('domain_www'); ?>home"></iframe></li></ul>
            </div>
        </div>
        <script>
            function put_new_cache() {
                $.getJSON('<?php echo $this->config->item('domain_www'); ?>home/create_act?callback=?', function(data) {
                    alert(data.msg);
                });
            }
        </script>

    </body>
</html>

