<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>无标题文档</title>
    <link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
<link href="<?php echo $this->config->item('domain_static'); ?>system/css/common.css" rel="stylesheet" type="text/css" />
    <link href="<?php echo $this->config->item('domain_static'); ?>system/css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>system/js/jquery.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="<?php echo $this->config->item('domain_static'); ?>system/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>system/js/jquery.js"></script>
<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>common/js/My97DatePicker/WdatePicker.js" charset="utf-8"></script>

</head>


<body>

	<div class="u-bd-tt">
        <span>位置：</span>
        <ul>
            <li><a href="#">首页</a></li>

        </ul>
    </div>
    

    <div class="g-mnr">

        <div class="tools">


        </div>
        <form method="get" action="/main/right">
         <label> 时间：</label><input id="add_time_from" class="dfinput" style="width:100px; height:30px;" type="text" name="start_time" value="<?php echo $this->input->get('start_time', TRUE); ?>">
         至:
         <input id="add_time_to" class="dfinput" style="width:100px; height:30px;" type="text" name="end_time" value="<?php echo $this->input->get('end_time', TRUE); ?>">
         <input type="submit" class="u-btn" style="width:80px;" value="查询">
     </form>
    <table class="tablelist">
    	<thead>
    	<tr> 
        <th>添加商品数量</th>
        <th>已支付总额</th>
        <th>注册会员</th>
        <th>登录会员数</th>
        <th>添加商铺数</th>

        </tr>
    </thead>
    <tbody>
        <tr>

            <td><?php echo $goods_total;?></td>
        <td><?php if(empty($pay_total)):?>0 <?php else: ?><?php echo $pay_total;?> <?php endif;?></td>
        <td><?php echo $yiban_reg_total;?></td>
        <td><?php echo $log_total;?></td>
        <td><?php echo $store_total;?></td>

        </tr>  
        <tr>
        </tbody>
    </table>

<script type="text/javascript">
	$('.tablelist tbody tr:odd').addClass('odd');
    $(function(){

        $('#add_time_from').focus(function() {
            WdatePicker({
                skin: 'whyGreen',
                dateFmt: 'yyyy-MM-dd',
                maxDate: '#F{$dp.$D(\'add_time_to\');}'
            });
        });
        $('#add_time_to').focus(function() {
            WdatePicker({
                skin: 'whyGreen',
                dateFmt: 'yyyy-MM-dd',
                minDate: '#F{$dp.$D(\'add_time_from\');}'
            });
        });
    });
</script>
</body>
</html>