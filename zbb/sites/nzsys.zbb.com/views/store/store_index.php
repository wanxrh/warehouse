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
                <li><a href="/store">店铺列表</a></li>

            </ul>
        </div>

        <div class="g-mnr">

            <div class="tools">

                <ul class="toolbar">
                    <li><a href="/store?status=2">仅开启状态<span><img src="<?php echo $this->config->item('domain_static'); ?>system/images/t01.png" /></span></a></li>
                    <li><a href="/store?status=1">仅关闭状态<span><img src="<?php echo $this->config->item('domain_static'); ?>system/images/t03.png" /></span></a></li>
                </ul>

                <form method="get" action="/store/index">
                    <ul class="toolbar1">
                    店铺名称:
                    <input class="dfinput" style="width:150px;" type="text" name="store_name" placeholder="店铺名称"  value="" />
                        <input type="submit" class="u-btn" style="width:80px;" value="查询" />
                    </ul>
                </form>
            </div>

            <table class="tablelist">

                <thead>
                    <tr>
                        <th>编号</th>
                        <th>店铺名称</th>
                        <th>所在地</th>
                        <th>详细地址</th>
                        <th>手机</th>
                        <th>QQ</th>
                        <th>阿里旺旺</th>
                        <th>店铺操作</th>
                    </tr>
                </thead>

                <tbody>
                    <?php foreach ($list as $item): ?>
                        <tr>
                            <td><?php echo $item['store_id'] ?></td>
                            <td><?php echo $item['store_name'] ?></td>
							<td><?php echo $item['region_name']; ?></td>
                            <td><?php echo $item['address'] ?></td>
                            <td><?php echo $item['tel'] ?></td>
                            <td><?php echo $item['im_qq'] ?></td>
                            <td><?php echo $item['im_ww'] ?></td>
                            <td><?php if($item['status']==0){?><a href="store/update_store_status?id=<?php echo $item['store_id'] ?>&status=1">开启</a><?php }else{ ?><a href="store/update_store_status?id=<?php echo $item['store_id'] ?>&status=0">关闭</a><?php }?></td>
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
