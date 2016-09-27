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
                    <li><a href="/store/apply?status=3">待审核<span><img src="<?php echo $this->config->item('domain_static'); ?>system/images/t02.png" /></span></a></li>
                    <li><a href="/store/apply?status=2">审核失败<span><img src="<?php echo $this->config->item('domain_static'); ?>system/images/t03.png" /></span></a></li>
                </ul>

                <form method="get" action="/store/index">
                    <ul class="toolbar1">
                    用户名:
                    <input class="dfinput" style="width:150px;" type="text" name="user_name" value="" />
                    店铺名称/id:
                    <input class="dfinput" style="width:150px;" type="text" name="store_name" placeholder="名称/id"  value="" />

                        <input type="submit" class="u-btn" style="width:80px;" value="查询" />
                    </ul>
                </form>
            </div>

            <table class="tablelist">

                <thead>
                    <tr>
                        <th>编号</th>
                        <th>店主姓名</th>
                        <th>店铺名称</th>
                        <th>电话</th>
                        <th>公司名称</th>
                        <th>申请时间</th>
                        <th>操作</th>
                        <th>状态</th>
                        <th>查看</th>
                    </tr>
                </thead>
                <?php $arr=array('待审核','审核通过','审核失败');?>
                <?php foreach($list as $item): ?>
                    <tr>
                        <td><?php echo $item['apply_id']; ?></td>
                        <td><?php echo $item['uname']; ?></td>
                        <td><?php echo $item['store_name']; ?></td>
                        <td><?php echo $item['mobile']; ?></td>
                        <td><?php echo $item['company_name']; ?></td>
                        <td><?php echo date('Y-m-d H:i:s',$item['dateline']); ?></td>
                        <td><?php if($item['status']==0):?><a onclick="if(confirm('确认操作?')==false)return false;" href="/store/store_status?id=<?php echo $item['apply_id'] ?>&status=1">审核通过</a>|<a class="click" data-id="<?php echo $item['apply_id'] ?>" href="">审核失败</a><?php endif; ?></td>
                        <td><?php echo $arr[$item['status']];?></td>
                        <td><a href="/store/store_look?id=<?php echo $item['apply_id'] ?>">查看</a></td>
                    </tr>
                <?php endforeach;?>
                <tbody>

                </tbody>

            </table>

            <div class="pagin">  	
                <ul class="paginList">

                </ul>
            </div>

        </div>

        <form action="/store/comment_update/" method="post">

            <input type="hidden" name="box_id" id="box_id" value="">
            <div class="tip">
                <div class="tiptop"><span>原因</span><a></a></div>

                <div class="tipinfo">
                    <!-- <span><img src="images/ticon.png" /></span>
                    <div class="tipright">
                        <p>是否确认对信息的修改 ？</p>
                        <cite>如果是请点击确定按钮 ，否则请点取消。</cite>
                    </div> -->
                    <textarea cols="60" rows="5" name="comment" id="mark">

				</textarea>
                </div>

                <div class="tipbtn">
                    <input name="" type="submit"  class="sure" value="确定" />&nbsp;
                    <input name="" type="button"  class="cancel" value="取消" />
                </div>

            </div>
        </form>

        <script type="text/javascript">
            $('.tablelist tbody tr:odd').addClass('odd');
        </script>

    </body>

</html>
<script type="text/javascript">
    $(".click").click(function(){
        $(".tip").fadeIn(200);
        var _id=$(this).attr('data-id');
        $('#box_id').val(_id);
        $.post("/store/store_comment", {
            'id':_id
        },function(data){
            $('#mark').val(data.data)
        },'json');

        return false;
    });
</script>