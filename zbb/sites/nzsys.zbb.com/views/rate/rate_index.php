<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>服务费资费标准</title>
    <link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
    <link href="<?php echo $this->config->item('domain_static'); ?>system/css/common.css" rel="stylesheet"
          type="text/css"/>
    <link href="<?php echo $this->config->item('domain_static'); ?>system/css/style.css" rel="stylesheet"
          type="text/css"/>
    <script type="text/javascript"
            src="<?php echo $this->config->item('domain_static'); ?>system/js/jquery.js"></script>
    <script type="text/javascript"
            src="<?php echo $this->config->item('domain_static'); ?>common/js/My97DatePicker/WdatePicker.js"
            charset="utf-8"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var log_id;
            $(".btn_service").click(function () {
                log_id = $(this).attr('locat');//logId
                $("#logId").val(log_id);
                $(".tip").fadeIn(200);
            });

            $(".tiptop a").click(function () {
                $(".tip").fadeOut(200);
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
        <li>资金管理</li>
        <li><a href="/service">服务费资费标准</a></li>
    </ul>
</div>

<div class="g-mnr">
    <!--
    <div class="tools">
        <ul class="toolbar">
            <li><a href="/rate/rate_add">添加<span><img
                            src="<?php echo $this->config->item('domain_static'); ?>system/images/t01.png"/></span></a>
            </li>
        </ul>
    </div>
    -->
    <table class="tablelist">
        <thead>
        <tr>
            <th>编号</th>
            <th>分类名</th>
            <th>服务费资费标准</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <?php foreach ($list as $item): ?>
            <tr>
                <td><?php echo $item['cate_id'] ?></td>
                <td>
                    <?php echo str_repeat('-', 4 * $item['level']) . $item['cate_name']; ?>
                </td>
                <td><?php $rate = $item['rate']?$item['rate']:0.05; echo $rate ?></td>
                <td>
                        <a href="/rate/rate_save/id/<?php echo $item['cate_id'] ?>">编辑</a>
                        <!--
                        |<a href="/rate/rate_del/id/<?php echo $item['cate_id'] ?>"onclick="if(confirm('确定删除?')==false)return false;">删除</a>
                        -->
                </td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</div>

<script type="text/javascript">
    $('.tablelist tbody tr:odd').addClass('odd');
</script>

</body>

</html>

<script type="text/javascript">


    $(function () {

        $('#add_time_from').focus(function () {
            WdatePicker({
                skin: 'whyGreen',
                dateFmt: 'yyyy-MM-dd',
                maxDate: '#F{$dp.$D(\'add_time_to\');}'
            });
        });
        $('#add_time_to').focus(function () {
            WdatePicker({
                skin: 'whyGreen',
                dateFmt: 'yyyy-MM-dd',
                minDate: '#F{$dp.$D(\'add_time_from\');}'
            });
        });
    });
    $("#click_xls").click(function () {
        $("#form").attr("action", "/service/export_xls");
        $("#form").submit();
        $("#form").attr("action", "/service/index");
    });


</script>