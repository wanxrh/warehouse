<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>修改店铺</title>
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
            <li>店铺管理</li>
            <li><a href="/store">店铺列表</a></li>
            <li>编辑</li>
        </ul>
    </div>      

    <div id="tab1" class="tabson">
        <form action="/store/edit?id=<?php echo $row['store_id'] ?>&type=<?php echo $type; ?>" method="post" enctype="multipart/form-data">
            <ul class="forminfo">
                <li><label>店主姓名<b>*</b></label><input class="dfinput" type="text" name="owner_name" value="<?php echo $row['owner_name'] ?>" /></li>
                <li><label>店主身份证号<!-- <b>*</b> --></label><input id="owner_card" name="owner_card" type="text" class="dfinput" value="<?php echo $row['owner_card'] ?>" maxLength="18"  onkeyup="value=value.replace(/[^\w\.\/]/ig,'')" style="width:518px;"/></li>
                <li><label>店铺名称<b>*</b></label><input name="store_name" type="text" class="dfinput" value="<?php echo $row['store_name'] ?>" maxLength="70"  style="width:518px;"/></li>
                <li><label>详细地址<b>*</b></label><input name="address" type="text" class="dfinput" value="<?php echo $row['address'] ?>" maxLength="70"  style="width:518px;"/></li>
                <li><label>邮政编码<b>*</b></label><input name="zipcode" type="text" class="dfinput" value="<?php echo $row['zipcode'] ?>"maxLength="6"  onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" style="width:518px;"/></li>
                <li><label>联系电话<b>*</b></label><input name="tel" type="text" class="dfinput" value="<?php echo $row['tel'] ?>" maxLength="11"  onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" style="width:518px;"/></li>
                <li><label>所属等级<b>*</b></label><input name="sgrade" type="text" class="dfinput" value="<?php echo $row['sgrade'] ?>" maxLength="10"  style="width:518px;"/></li>
                <li><label>有效期至<!-- <b>*</b> --></label><input id="end_time" name="end_time" type="text" class="dfinput" value="<?php echo $row['end_time'] ?>" maxLength="10" onkeyup="this.value=this.value.replace(/\D\-/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" style="width:518px;"/><span style="display:inline;margin-left:10px;color:#666;">格式为2015-01-01</span></li>
                <li><label>状态<b>*</b></label>
                    <input type="radio" name="state" value="0" <?php if ($row['state'] == 0): ?>checked="checked"<?php endif; ?>/>关闭
                    <input type="radio" name="state" value="1" <?php if ($row['state'] == 1): ?>checked="checked"<?php endif; ?>/>开启
                </li>
                <li><label>执照证件审核<b>*</b></label>
                    <a href="/store/info?store_id=<?php echo $row['store_id'] ?>">点击查看</a>
                </li>

                <li><label>是否推荐<b>*</b></label>
                    <libel>否</libel><input type="radio" name="recommended" value="0" <?php if ($row['recommended'] == 0): ?>checked="checked"<?php endif; ?>/>
                    <libel>是</libel><input type="radio" name="recommended" value="1" <?php if ($row['recommended'] == 1): ?>checked="checked"<?php endif; ?>/>
                </li>
                <li><label>排序<b>*</b></label><input name="sort_order" type="text" class="dfinput" value="<?php echo $row['sort_order'] ?>" maxLength="3" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"  style="width:518px;"/></li>
                <li><label>&nbsp;</label><input name="submit" type="submit" class="u-btn" value="提交"/></li>
            </ul>
        </form>
    </div>



    <div class="tip">
        <div class="tiptop"><span>提示信息</span><a></a></div>

        <div class="tipinfo">
            <span><img src="images/ticon.png" /></span>
            <div class="tipright">
                <p>是否确认对信息的修改 ？</p>
                <cite>如果是请点击确定按钮 ，否则请点取消。</cite>
            </div>
        </div>

        <div class="tipbtn">
            <input name="" type="button"  class="sure" value="确定" />&nbsp;
            <input name="" type="button"  class="cancel" value="取消" />
        </div>

    </div>

<script type="text/javascript">
$(function(){

/*   //暂时不限制身份证和日期的格式
  var regcard = /(^[1-9]\d{14}$)|(^[1-9]\d{17}$)|(^[1-9]\d{16}(\d|X|x)$)/;
    var regend=/^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$/;
     
      $("input[name='submit']").click(function(){
  
      var strcard=$("#owner_card").val();
      var strend=$("#end_time").val();
         if(!regcard.test(strcard)){
           alert("身份证号码输入不合法!");  
           $("#owner_card").focus();
           return false;  
         }
        if(!regend.test(strend)){
           alert("日期格式不正确!");  
           $("#end_time").focus();
           return false;  
         }
         else{
            $("form").submit();
         }
      });   */     

   $('.imgtable tbody tr:odd').addClass('odd'); 

});
</script>

</body>

</html>
