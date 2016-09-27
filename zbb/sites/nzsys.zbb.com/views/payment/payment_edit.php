<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>添加支付</title>
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
                <li>其他管理</li>
                <li><a href="/payment">支付列表</a></li>
                <li><a href="/payment/edit_payment">新增</a></li>
            </ul>
        </div>

        <div class="g-mnr">
            <table class="tablelist">
                <tbody>
                    <form action="/payment/edit_payment" enctype="multipart/form-data" method="post">
                    	<input type="hidden" name="payment_id" value="<?php echo $payment_id ?>" />
                        <ul class="forminfo">
                            <li><label>支付方式码<b>*</b></label>
                                <input name="payment_code" type="text" value="<?php echo $payment_code ?>" />
                            </li>    
                            <li><label>支付名称<b>*</b></label>
                                <input name="payment_name" type="text" value="<?php echo $payment_name ?>" />
                            </li>   
                            <li><label>支付方式详情</label>
                                <textarea name="payment_desc" ><?php echo $payment_desc ?></textarea>
                            </li>   
                            <li><label>上传图标</label>
                                <input type="file" name="icon" size="60" />
                            </li>
                            <li><img src="<?php echo img_url($icon);?>" alt="" class="pic"></li>   
							<li><label>是否开启<b>*</b></label>
                                <input type="radio" name="enabled" value="1" <?php $enabled==1? $checked="checked='checked'":$checked=''; echo $checked; ?> /> 是
                        		<input type="radio" name="enabled" value="0" <?php $enabled==0? $checked="checked='checked'":$checked=''; echo $checked; ?> /> 否
                            </li>
							<li><label>排序<b>*</b></label>
                                <input name="sort_order" type="text" value="<?php echo $sort_order ?>" />
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
