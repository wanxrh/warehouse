<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>查看会员信息</title>
    <link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
    <!-- <link href="<?php echo $this->config->item('domain_static'); ?>common/css/public2016.css" rel="stylesheet"/> -->
    <link rel="stylesheet" href="<?php echo $this->config->item('domain_static'); ?>web/css/beautiful.css">
    <style>
        .m-logo li{
            height: 54px;
            width: 150px;
            margin: 10px 0 0 13px;
            float: left;
        }
        .m-logo img{
            display: block;
            height: 54px;
            width: 150px;
            background-color: #eee;
        }
        .m-goods li{
            height: 150px;
            width: 150px;
            margin: 10px 0 0 13px;
            float: left;
        }
        .m-goods img{
            display: block;
            height: 150px;
            width: 150px;
            background-color: #eee;
        }
    </style>
</head>
<body>
<div class="g-page">
    <div class="row">
        <div class="nm">
            <div class="cont" style="line-height: 28px;">

            </div>
        </div>
        <div class="sd"><span>*</span><label>店主：</label><?php echo $store['uname'];?></div>
    </div>
    <h2 class="m-tt tt-color"><label>店铺名称 :</label><?php echo $store['store_name'];?></h2>
    <h2 class="m-tt"><label>公司名称 :</label><?php echo $store['company_name'];?></h2>
    <h2 class="m-tt tt-color"><label>邮箱 :</label><?php echo $store['email'];?></h2>
    <h2 class="m-tt"><label>电话 :</label><?php echo $store['mobile'];?></h2>
    <h2 class="m-tt tt-color"><label>法人 :</label><?php echo $store['corporation'];?></h2>
    <h2 class="m-tt"><label>身份证号码 :</label><?php echo $store['id_card'];?></h2>
    <h2 class="m-tt tt-color"><label>照片 :</label>
        <?php foreach ($card_imgs as $value):?>
        <img src="<?php echo img_url($value);?>"><br />
        <?php endforeach;?>
    </h2>
    <h2 class="m-tt"><label>营业执照号 :</label><?php echo $store['license'];?></h2>
    <h2 class="m-tt tt-color"><label>企业经营有效期 :</label><?php echo $store['start_end'];?></h2>
    <h2 class="m-tt"><label>公司照片 :</label>
        <?php foreach ($company_img as $value):?>
            <img src="<?php echo img_url($value);?>"><br />
        <?php endforeach;?>
    </h2>
    <h2 class="m-tt tt-color"><label>银行开户许可证 :</label><?php echo $store['bank_sn'];?></h2>
    <h2 class="m-tt"><label>C店链接 :</label><?php echo $store['check_url'];?></h2>
    <?php $arr = array('0'=>'待审核','1'=>'审核通过','2'=>'审核失败',);?>
    <h2 class="m-tt tt-color"><label>审核状态 :</label><?php echo $arr[$store['status']];?></h2>
    <h2 class="m-tt"><label>提交时间 :</label><?php echo date('Y-m-d',$store['dateline']);?></h2>
    <h2 class="m-tt tt-color"><label>审核失败原因 :</label><?php echo $store['comment'];?></h2>

</body>
</html>