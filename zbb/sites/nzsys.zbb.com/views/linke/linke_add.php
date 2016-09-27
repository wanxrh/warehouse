<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>无标题文档</title>
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
                <li>推送管理</li>
                <?php if ($type == 1): ?>
                    <li><a href="/linkecate?type=1">文字推送</a></li>
                <?php elseif ($type == 2): ?>
                    <li><a href="/linkecate?type=2">图片推送</a></li>
                <?php endif; ?>
                
                <?php if (!empty($p_cate)) : ?>
                <?php array_pop($p_cate);?>
                    <?php foreach ($p_cate as $val) : ?>
                        <li><a href="/linkecate/linke_add?type=<?php echo $val['type'];?>&cid=<?php echo $val['id']; ?>"><?php echo $val['name']; ?></a></li>
                    <?php endforeach;?>
                <?php endif; ?>

                <?php foreach ($category as $key => $val): ?>
                    <?php if ($val['id'] == $cid && $val['type'] == $type): ?>
                    <?php $max=$val['max_num'];?>
                        <li><a href="/linkecate/linke_add?type=<?php echo $type;?>&cid=<?php echo $cid; ?>"><?php echo $val['name'] ?></a></li>
                    <?php endif; ?>
                <?php endforeach; ?>

            </ul>
        </div>

        <div class="g-mnr">



            <table class="tablelist">

                <thead>
                    <tr>


                        <th>分类名称</th>
                        <th>查看</th>
                        <th>操作</th>
                    </tr>
                </thead>

                <tbody>
                    <?php foreach ($arr as $v): ?>
                        <tr>

                            <td><?php echo $v['title']; ?></td>
                            <td><a href="<?php echo $v['img'] ? img_url($v['img']) : $v['url']; ?>" target="_blank">查看</td>
                            <td><a href="?cid=<?php echo $cid; ?>&id=<?php echo $v['id']; ?>&type=<?php echo $type; ?>">编辑</a> | 
                                <a href="linke_delete?id=<?php echo $v['id']; ?>" onclick="if (confirm('确定删除?') == false)
                                                return false;">删除</a>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>

            </table>
            <div class="u-bd-tt">
                <span>位置：</span>
                <ul >
                    <li><a href="#">首页</a></li>
                    <li><a href="#">推荐添加</a></li>
                </ul>
            </div>

            <div class="formbody">

                <div class="formtitle"><span>基本信息</span></div>

                <ul class="forminfo">
                    <form method="post" action="?cid=<?php echo $cid; ?>&type=<?php echo $type; ?>" enctype="multipart/form-data" >
                        <input name="id" value="<?php if (!empty($id)) {
                        echo $id;
                    }; ?>"  type="hidden"  />
                        <input name="cid" value="<?php if (!empty($cid)) {
                        echo $cid;
                    }; ?>"  type="hidden"  />
                        <input name="type" value="<?php if (!empty($type)) {
                        echo $type;
                    }; ?>"  type="hidden"  />
                        <li><label>标题</label><input name="title" value="<?php if (!empty($id)) {
                        echo $linke['title'];
                    }; ?>"  maxLength="15" type="text" class="dfinput" /><i>标题不能超过15个字符</i></li>
<?php if ($type == 2): ?>
                            <li><label>引用地址</label><input name="url" type="text" class="dfinput" value="<?php if (!empty($id)) {
        echo $linke['url'];
    }; ?>" /></li>
                            <li><label>上传图片</label><input class="infoTableFile2" id="brand_logo" name="logo" type="file"></li>
<?php else: ?>
                            <li><label>引用地址</label><input name="url" type="text" class="dfinput" value="<?php if (!empty($id)) {
        echo $linke['url'];
    }; ?>" /></li>
<?php endif; ?>        
                           <li><label>描述文字</label><textarea  style="width:400px; height:150px;" name="content"><?php if (!empty($id)) {
        echo $linke['content'];
    }; ?></textarea></li>
                        <li><label>&nbsp;</label><input name="" type="submit" class="u-btn" value="确认保存"/></li>
                     </form> 
                    <form method="post" action="<?php echo $this->config->item('domain_nzsys'); ?>linkecate/linke_num" enctype="multipart/form-data" >
                        <input name="id" value="<?php if (!empty($cid)) {
                        echo $cid;
                    }; ?>"  type="hidden"  />
                
                            <li><label>最大数量</label><input name="num" type="text" class="dfinput" value=""   onafterpaste="this.value=this.value.replace(/\D/g,'')" onkeyup="this.value = this.value.replace(/\D/g, '')" maxlength="2"/><?php echo $max ?></li>

                        <li><label>&nbsp;</label><input name="" type="submit" class="u-btn" value="确认保存"/></li>
                    </form> 
                </ul>
               

            </div>


            <script type="text/javascript">
                $('.imgtable tbody tr:odd').addClass('odd');
            </script>

    </body>

</html>
