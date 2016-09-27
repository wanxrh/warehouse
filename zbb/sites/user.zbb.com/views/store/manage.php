<?php $this->load->view('header');?>

<div class="g-wrap clearfix">
    <div class="g-mn">
        <div class="g-mnc">
            <!--  正文  -->
            <div class="m-tt">
                <span>店铺设置<em></em></span>
            </div>
            <form id="J_form" method="post" action="/store/get_manage" enctype="multipart/form-data">
                <div class="m-opbox m-shop">
                    <div class="pic" id="imgdiv">  
                        <img src="<?php echo img_url($store_info['store_logo']);?>" alt="" class="logo" id="imgShow" onerror="this.onerror=null,this.src='<?php echo $this->config->item('domain_static'); ?>user/img/default.gif' " >
                    </div>
                    <input type="hidden" name="store_id" value="<?php echo $store_info['store_id'];?>">
                    <div class="box">
                        <input type="file" class="file" onchange="javascript:setImagePreview();" ectype="change_store_logo" hidefocus="true" maxlength="0" size="1" id="up_img" name="store_logo"> <label class="setcode">更改图标</label>
                    </div>
                    <div class="tip">
                        <span class="arrow"></span>此处为您的店铺标志，将显示在店铺信息栏里建议：<font style="color:red;">尺寸176*60像素，支持jpg\jpeg\png格式，图片大小在500k以内</font>
                    </div>

                    <ul class="manage">
                        <li><span class="tt">店铺名称:</span><input id="D_name" name="store_name" type="text" class="txt" value="<?php echo $store_info['store_name']?>"> <label>店铺名称</label></li>
                        <li><span class="tt">地　　区:</span>
                            <select name="province_id" id="provice">
                                <?php foreach ($province as $item):?>
                                    <option value="<?php echo $item['region_id'] ;?>" <?php if($store_info['province_id']==$item['region_id']):?>selected="selected"<?php endif; ?>><?php echo $item['region_name']?></option>
                                <?php endforeach;?>
                            </select>

                            <select name="city_id" id="city">
                                <?php foreach ($city as $item):?>
                                    <option value="<?php echo $item['region_id'] ;?>" <?php if($store_info['city_id']==$item['region_id']):?>selected="selected"<?php endif; ?>><?php echo $item['region_name']?></option>
                                <?php endforeach;?>
                            </select>
                            <select name="country_id" id="country">
                                <?php foreach ($country as $item):?>
                                    <option value="<?php echo $item['region_id'] ;?>" <?php if($store_info['country_id']==$item['region_id']):?>selected="selected"<?php endif; ?>><?php echo $item['region_name']?></option>
                                <?php endforeach;?>
                            </select>
                            <input type="hidden" id="region_id" value="<?php echo $store_info['country_id'] ;?>"/>
                            <?php if(!empty($province_name)):?><input type="hidden" id="region_name" name="region_name" value="<?php echo isset($province_name)?$province_name['region_name']:'';?> <?php echo isset($city_name)?$city_name['region_name']:'';?> <?php echo isset($country_name)?$country_name['region_name']:'';?>"/><?php endif;?>

                        </li>
                        <li><span class="tt">详细地址:</span><input type="text" class="txt" name="address" id="address" value="<?php echo $store_info['address']?>"> <label> 不必重复填写所在地区</label></li>
                        <li><span class="tt">联系电话:</span><input type="text" class="txt" name="tel" id="tel" value="<?php echo $store_info['tel']?>"> <label>  请填写正确的手机号码</label></li>
                        <li><span class="tt">客服Q Q:</span><input type="text" class="txt" name="im_qq" id="im_qq" value="<?php echo $store_info['im_qq']?>"> <label>  请确保QQ已开通在线通讯功能</label></li>
                        <li><span class="tt">阿里旺旺:</span><input type="text" class="txt" name="im_ww" id="im_ww" value="<?php echo $store_info['im_ww']?>"></li>
                    </ul>

                    <div class="f-tac">
                        <button class="btn" data-url="/store/get_manage">提交</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div class="g-sd">
        <?php $this->load->view('menu');?>
    </div>
</div>

<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>user/js/manage.js" charset="utf-8"></script>
<?php $this->load->view('footer');?>