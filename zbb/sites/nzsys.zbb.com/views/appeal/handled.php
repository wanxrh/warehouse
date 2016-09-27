<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>店铺列表</title>
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
        <li><a href="/appeal/lists">申诉列表</a></li>

    </ul>
</div>

<div class="g-mnr">

    <div class="tools">
        <form method="get" action="/appeal/handled">
            <ul >
                <select class="querySelect" name="sgrade">
                    <option value="">选择订单条件</option>
                    <option value="1">订单编号</option>
                    <option value="2">退款编号</option>
                    <option value="3">商品标题</option>
                    <option value="4">买家名称</option>
                    <option value="5">卖家名称</option>
                </select>
                <input class="dfinput" style="width:150px;" type="text" name="user_name" value="" />
                <select class="querySelect" name="order_status">
                    <option value="">全部</option>
                    <?php $temp_arr=get_aftermarket_status();?>
                    <?php foreach ($temp_arr as $key=>$m){?>
                        <option value="<?php echo $key+1;?>" <?php echo $order_status-1==$key?'selected':''; ?>><?php echo $m;?></option>
                    <?php } ?>
                </select>
                <input type="submit" class="u-btn" style="width:80px;" value="查询" />
            </ul>
        </form>
    </div>

    <table class="tablelist">

        <thead>
        <tr>
            <th>退款编号</th>
            <th>商品标题/订单编号</th>
            <th>商家</th>
            <th>买家</th>
            <th>订单金额</th>
            <th>退款金额</th>
            <th>申请时间</th>
            <th>申请事项</th>
            <th>处理状态</th>
            <th>操作</th>
        </tr>
        </thead>

        <tbody>
        <?php $temp_arr=get_aftermarket_status();?>
        <?php foreach ($list as $item): ?>
            <tr>
                <td><?php echo $item['refund_sn'] ?></td>
                <td>订单编号:<?php echo $item['order_sn'];?>
                    <p class="goods_name"><?php echo $item['goods_name'];?></p>
                </td>
                <td><?php echo $item['seller_name']; ?></td>
                <td><?php echo $item['buyer_name'] ?></td>
                <td><?php echo $item['discounted_price'] ?></td>
                <td><?php echo $item['money'] ?></td>
                <td><?php echo date('Y-m-d H:i',$item['add_time']); ?></td>
                <td><?php if($item['type']==1){ ?>退款<?php }else{?>退货退款<?php }?></td>
                <td><?php echo $temp_arr[$item['status']]; ?></td>
                <td><a href="/appeal/detail?rec_id=<?php echo $item['rec_id']?>">查看详情</a></td>
            </tr>
        <?php endforeach; ?>
        </tbody>

    </table>

    <div class="pagin">
        <ul class="paginList">
            <?php echo $page; ?>
        </ul>
    </div>

</div>

<script type="text/javascript">
    $('.tablelist tbody tr:odd').addClass('odd');
</script>

</body>

</html>
