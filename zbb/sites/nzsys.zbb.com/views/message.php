<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>无标题文档</title>
        <script charset="utf-8" src="<?php echo $this->config->item('domain_static'); ?>common/kindeditor/kindeditor.js"></script>
        <script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>system/js/jquery.js"></script>
        <script charset="utf-8" src="<?php echo $this->config->item('domain_static'); ?>common/kindeditor/lang/zh_CN.js"></script>
        <script>
            KindEditor.ready(function (K) {
                var editor1 = K.create('textarea[name="content"]', {
                    allowImageUpload: true,
                    uploadJson: "/message/upload", //图片上传后的处理地址
                    afterBlur: function () {
                        this.sync();
                    }
                });
            });
        </script>
        <link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
<link href="<?php echo $this->config->item('domain_static'); ?>system/css/common.css" rel="stylesheet" type="text/css" />
        <link href="<?php echo $this->config->item('domain_static'); ?>system/css/style.css" rel="stylesheet" type="text/css" />
    </head>

    <body>

        <div class="u-bd-tt">
            <span>位置：</span>
            <ul >
                <li>会员管理</li>
                <li><a href="/message">消息群发</a></li>
            </ul>
        </div>

        <div class="formbody">

            <div class="formtitle"><span>基本信息</span></div>
            <form method="post" action="/message/send">
                <ul class="forminfo">
                    <li><label>发送类型</label><cite><input name="to_type" checked="checked" type="radio" value="1" />会员&nbsp;&nbsp;&nbsp;&nbsp;<input name="to_type" type="radio" value="2" />商家</cite></li>
                    <li><label>会员名称</label><input name="username" type="text" class="dfinput" /><i>多个关键字用英文,隔开</i></li>
                    <li><label>文章标题</label><input maxLength="50" name="title" type="text" class="dfinput" /></li> 
                    <li><label>有效天数</label><input maxLength="3" onkeyup="this.value = this.value.replace(/\D/g, '')" onafterpaste="this.value=this.value.replace(/\D/g,'')" name="days" type="text" class="dfinput" onkeyup="this.value = this.value.replace(/\D/g, '')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>天</li>
                    <li><label>消息内容</label><textarea name="content" id="description" style="width: 80%; height: 400px;"></textarea></li>
                    <li><label>&nbsp;</label><input name="" type="submit" class="u-btn" value="发送消息"/></li>
                </ul>
            </form>

        </div>

    </body>

</html>
