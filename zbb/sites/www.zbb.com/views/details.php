<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>众宝贝-<?php echo $goods_info['goods_name'];?></title>
    <meta name="description" content="众宝贝  一个只卖折扣商品的平台, 100%保证正品！!">
    <meta name="keywords" content="众宝贝,商品特卖,品牌特卖">
    <!-- <link rel="shortcut icon" type="image/ico" href="<?php echo $this->config->item('domain_static'); ?>common/img/favicon.ico" /> -->
    <link  type="text/css" href="<?php echo $this->config->item('domain_static'); ?>web/css/details.css" rel="stylesheet"/>
    <link rel="stylesheet" href="<?php echo $this->config->item('domain_static'); ?>/common/css/jqzoom.css">
</head>
<body>
    <div class="g-hd">
        <div class="g-wrap clearfix">
            <a href="<?php echo $this->config->item('domain_www'); ?>" target="_blank" ><h1 class="m-logo"></h1></a>
            <div class="m-ad">
                <ul class="s-icoT">
                    <li class="ico-n">每日上新</li>
                    <li class="ico-p">专业买手团砍价</li>
                    <li class="ico-b">担保交易</li>
                    <li class="ico-q">7天无理由退货</li>
                </ul>
            </div>
        </div>
    </div>

    <div class="g-nav">
        <div class="g-wrap">
            <ul class="clearfix">
                <li><a href="<?php echo $this->config->item('domain_www'); ?>">首页</a></li>
                <li><a href="/baoyou-3.html" class="z-crt">9.9元包邮</a></li>
                <li><a href="/zdm.html">值得买</a></li>                                 
                <li><a href="/gyh.html">手机更优惠</a></li>
            </ul>
        </div>
    </div>

    <div class="g-ct g-wrap">
        <div class="m-nm">
            <div class="m-nmc">
                <div class="m-box">
                    <div class="m-info">
                        <div class="m-ct" id="J_op">
                            <h2 class="m-tt"><?php echo $goods_info['goods_name'];?></h2>

                            <div class="s-gray">
                                <div class="m-box">
                                   <div class="ct"> 
                                        <div class="cont"><span class="s-txt-red s-txt-size">¥<?php echo $goods_info['price'];?></span></div>
                                    </div>
                                   <div class="tt">促销:</div>
                                </div>

                                <div class="m-box">
                                    <div class="ct"> 
                                        <div class="cont"><del>¥<?php echo $goods_info['cost_price'];?></del></div>
                                    </div>
                                   <div class="tt">原价:</div>
                                </div>
                            </div>
              
                            <div class="m-box">
                                <div class="ct"> 
                                    <div class="cont"><span class="s-txt-red">免运费</span></div>
                                </div>
                                <div class="tt">运费:</div>
                            </div>
                            <?php foreach($spec_info as $key=>$v){?> 
                            <div class="m-box">
                                <div class="ct">
                                    <div class="cont">
                                        <?php foreach($v as $m){?>
                                        <span class="s-size"><?php echo $m['attr_value'];?></span>
                                        <?php }?>
                                    </div>
                                </div>
                                <div class="tt"><?php echo $key;?>:</div>
                            </div>
                            <?php }?>

                            <div class="m-box">
                                <div class="ct">
                                    <div class="cont">
                                        <a class="cutNum disableNum" href="#">-</a>
                                        <input type="text" value="1" id="quantity" name="" maxlength="8">
                                        <a class="addNum" href="#">+</a>　
                                        件(库存 <span><?php echo $stock;?></span> 件)
                                    </div>
                                </div>
                                <div class="tt">数量:</div>
                            </div>

                            <div class="m-box">
                                <a  class="btn" href="javascript:void(0);">加入购物车</a>
                            </div>
                            <div class="m-box">
                                <div class="effects">
                                    <spna class="txt">
                                        <span class="m-l"></span>众宝贝 · 认证商家
                                        <span class="m-r"></span>
                                    </spna>
                                </div>
                                <div class="crm">
                                    <span class="g-ico"></span>
                                    <?php echo $store_name;?>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="m-pic">
                        <div class="pic">
                            <span class="jqzoom">
                            <img width="380" height="380" jqimg="<?php echo img_url($goods_info['default_image']);?>" src="<?php echo img_url($goods_info['default_image']);?>_390x390.jpg">
                            </span>
                        </div>
                        <div class="m-box">
                            <ul class="pic_move">
                                <?php foreach($goods_img as $v){?>
                                <li class="ware_pic_hover"><img width="68" height="68" data-src="<?php echo img_url($v['image_url']);?>_390x390.jpg" src="<?php echo img_url($v['image_url']);?>_68x68.jpg" data-img="<?php echo img_url($v['image_url']);?>">
                                </li>
                                <?php }?>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="m-box">
                    <div class="m-crm">
                        <span>宝贝详情</span>
                    </div>
                    <div class="g-data">
                        <div class="m-data"><?php echo isset($goods_etxm['attributes'])?$goods_etxm['attributes']:'';?></div>
                         <div class="m-data"><?php echo isset($goods_etxm['detail'])?$goods_etxm['detail']:'';?></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="m-sd">
            <div class="m-tt">换一批</div>
            <div class="m-ct j_ImgLoad">
                <ul class="m-list">
                <?php foreach($goods_recom as $m){?>
                   <li>
                       <div class="pic"><a href="<?php echo goods_url($m['target_id']);?>" target="_blank"><img src="<?php echo $this->config->item('domain_static'); ?>common/img/default.jpg" data-url="<?php echo img_url($m['img']);?>" alt="<?php echo $m['title'];?>"></a></div>
                       <div class="cont">
                           <h2 class="tt"><a href="<?php echo goods_url($m['target_id']);?>" target="_blank"><?php echo $m['title'];?></a></h2>
                           <div class="price">
                               <span class="crt"><em>&yen;</em><?php echo $m['price'];?></span>
                               <del><em>&yen;</em><?php echo $m['cost_price'];?></del>
                           </div>
                       </div>
                   </li>
                <?php }?>   
                </ul>
            </div>
        </div>
    </div>


    <div class="g-ft">
        <div class="g-wrap">
            <a href="#">商家入驻</a>
            <a href="#">关于我们</a>
            <a href="#">用户协议</a>
            <a href="#">帮助中心</a>
            <a href="#">法律声明</a>
            <p class="m-cprt">
                © 2016  zhongbaobei.com 
            </p>
        </div>
    </div>

    <a href="tencent://message/?uin=2729811264&Site=zhongbaobei.com&Menu=yes" class="m-online"></a>
    

    <div class="g-remake" id="J_make">
    </div>
    <div class="g-pop" id="J_pop">
        <div class="colse">X</div>
        <h2 class="m-tt">打开众宝贝扫一扫，在APP上支付</h2>
        <div class="m-hot s-gray">
            <div class="m-ct">
                <div class="m-nm">
                    <div class="tt"><?php echo $goods_info['goods_name'];?></div>
                    <div class="price">
                        <span>￥<?php echo $goods_info['price'];?></span><del>￥<?php echo $goods_info['cost_price'];?></del>
                    </div>
                </div>
            </div>
            <div class="m-pic">
                <img src="http://pan.baidu.com/share/qrcode?w=150&h=150&url=<?php echo $goods_info['goods_id'];?>" alt="商品二维码">
            </div>
        </div>
        <div class="m-dld">
            <div class="m-ct">
                <div class="m-nm">
                    <div class="dld"><span>Android下载</span><span>iPhone下载</span></div>
                    <div class="tt">扫一扫，下载众宝贝手机客户端，更多精彩！</div>
                </div>
            </div>
            <div class="m-pic">
                <img src="" alt="APP下载二维码">
            </div>
        </div>
    </div>

    <script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>common/js/seajs/sea.js" charset="utf-8"></script>
    <script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>web/js/main.js" charset="utf-8"></script>
</body>
</html>