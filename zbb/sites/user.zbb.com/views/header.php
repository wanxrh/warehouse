<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>用户中心</title>
     <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <link href="<?php echo $this->config->item('domain_static'); ?>user/css/main.css" rel="stylesheet"/>
    <script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>common/js/seajs/sea.js" charset="utf-8"></script>
</head>
<body>
    
<div class="g-hd">
    <div class="m-nav">
        <div class="g-wrap">
            <a href="<?php echo $this->config->item('domain_www'); ?>" target="_blank" class="f-fr"><i class="I-ico">&#xe607;</i>众宝贝首页</a>
            您好,<span class="uname"><a href="<?php echo $this->config->item('domain_user'); ?>"><?php echo get_user()['name'];?></a></span> <a href="<?php echo $this->config->item('domain_www'); ?>login/out" class="exit">[退出]</a>
            <a class="msg" href="/message/lists">
                <i id="msgNun">0</i>
                消息
            </a>
        </div>
    </div>
    <div class="m-mn">
        <div class="g-wrap">
            <h1></h1>
        </div>
    </div>
</div>
<script type="text/javascript" >
    //消息条数
    seajs.use('jquery',function($){$.ajax({type: "POST", url: '/message/get_unread', dataType: 'json', success: function(data) {if (data.success) {
        $('#msgNun').text(data.data>99?"99+":data.data); } } }); }); </script>