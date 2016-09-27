<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>会员列表</title>
        <link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
<link href="<?php echo $this->config->item('domain_static'); ?>system/css/common.css" rel="stylesheet" type="text/css" />
        <link href="<?php echo $this->config->item('domain_static'); ?>system/css/style.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>system/js/jquery.js"></script>
<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>common/js/My97DatePicker/WdatePicker.js" charset="utf-8"></script>
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
            <ul>
                <li>会员管理</li>
                <li><a href="/user">会员列表</a></li>
                <li><a href="/user/lock">会员冻结</a></li>
            </ul>
        </div>
        <div class="g-mnr">

            <form method="post" enctype="multipart/form-data" id="test_form">
                <table class="tablelist">
                    <tbody>
                        <ul class="forminfo">
                            <li><label>冻结原因<b>*</b></label>    
                                <TEXTAREA rows="10" cols="50" class="dfinput" name="content"></TEXTAREA>
        </li>


        <li><label>截止时间<b>*</b></label>      
        	<input type="text" name="lock_time" value="<?php echo $this->input->get('lock_time', TRUE); ?>" id="add_time_from" class="dfinput"/>时间格式1970-01-01
        </li>

      <li><label>&nbsp;</label><input name="" type="submit" class="u-btn" value="提交"/></li>
      </ul>
      </tbody>
    </table>
  </form>
</div>
</body>
<script type="text/javascript">

        $(function(){

        $('#add_time_from').focus(function() {
        WdatePicker({
        skin: 'whyGreen',
                dateFmt: 'yyyy-MM-dd'
        });
        });
    });
</script>