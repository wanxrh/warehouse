<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>文章列表1</title>
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
                <li>文章管理</li>
                <li><a href="/article">文章列表</a></li>

            </ul>
        </div>

        <div class="g-mnr">

            <div class="tools">

                <ul class="toolbar">
                    <li><a href="/article/add">新增<span><img src="<?php echo $this->config->item('domain_static'); ?>system/images/t01.png" /></span></a></li>
                </ul>


                <form method="get" action="/article/index">
                    <ul class="toolbar1">
                        标题:<input class="dfinput" style="width:150px;" type="text" value="" name="title">
                            文章分类：<select id="cate_id" class="querySelect" name="cate_id">
                                <option value="">请选择...</option>
                                <?php foreach ($acategory as $item): ?>
                                    <option value="<?php echo $item['cate_id'] ?>"><?php echo $item['cate_name'] ?></option>
                                <?php endforeach; ?>
                            </select>
                            <input class="u-btn" style="width:80px;" type="submit" value="查询">
                                </ul>
                                </form>



                                </div>

                                <table class="tablelist">

                                    <thead>
                                        <tr align="center">
                                            <th><input name="" type="checkbox" value="" checked="checked"/></th>
                                            <th>编号</th>
                                            <th>标题</th>
                                            <th>所属分类</th>
                                            <th>显示</th>
                                            <th>添加时间</th>
                                            <th>排序</th>
                                            <th>操作</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <?php foreach ($list as $item): ?>
                                            <tr align="center">
                                                <td><input type="checkbox" class="checkitem" value="<?php echo $item['article_id'] ?>" /></td>
                                                <td><?php echo $item['article_id'] ?></td>
                                                <td><?php echo $item['title'] ?></td>
                                                <td><?php echo $item['cate_name'] ?></td>
                                                <td><?php echo $item['if_show'] ?></td>
                                                <td><?php echo date('Y-m-d H:i:s',$item['add_time']); ?></td>
                                                <td><?php echo $item['sort_order'] ?></td>
                                                <td> <a target="_blank" href="<?php if($item['link']):?><?php echo $item['link'];?><?php else: ?>/article/preview/id/<?php echo $item['article_id'] ?><?php endif; ?>">预览</a> | <a href="/article/edit/id/<?php echo $item['article_id'] ?>">编辑</a> | 
                                                    <a href="/article/delete/id/<?php echo $item['article_id'] ?>" onclick="if(confirm('确定删除?')==false)return false;">删除</a></td>
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
                                    $('.imgtable tbody tr:odd').addClass('odd');
                                </script>

                                </body>

                                </html>
