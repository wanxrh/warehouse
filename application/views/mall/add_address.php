<?php $this->load->view('mall/mobile_head'); ?>
<link href="<?php echo $this->config->base_url(); ?>static/mobile/common.css" rel="stylesheet" type="text/css">
<body>
    <div class="container">
    	<form action="" method="post" onSubmit="return tgSubmit()">
            <div class="address_form">
            	<div class="addressItem tb">
                    <label for="truename" class="flex_1">收货人</label>
                    <div class="right flex_1">
                        <input type="text" name="truename" id="truename" value="<?php echo $info['truename']; ?>"/>
                    </div>
                </div>
                <div class="addressItem tb">
                    <label for="mobile" class="flex_1">手机号码</label>
                    <div class="right flex_1">
                        <input type="text" name="mobile" id="mobile" value="<?php echo $info['mobile']; ?>"/>
                    </div>
                </div>
                

                <div class="addressItem tb">
                	<input type="hidden" name="region_id" value="<?php echo $info['region_id']; ?>">
                	<input type="hidden" name="region_name" value="<?php echo $info['region_name']; ?>">
                    <label for="address" class="flex_1">省&nbsp;&nbsp;份</label>
                    <div class="right flex_1 ">
                        <div id="cascade_city"></div>
                       	<select id="provice">
                       		<option value="0">请选择......</option>
                       		<?php foreach ($region['provice'] as $v){ ?>
                       		<option  <?php if($v['id'] == $myregion['provice']){ ?>selected="selected"<?php }; ?>  value="<?php echo $v['id']; ?>"><?php echo $v['name']; ?></option>
                       		<?php }; ?>
                       	</select>
                    </div>
                </div>
				
				
                  <div id="city_tb" class="addressItem tb" <?php if(!$region['city']){ ?>style="display:none"<?php }; ?> >
                    <label for="address" class="flex_1">城&nbsp;&nbsp;市</label>
                    <div class="right flex_1 ">
                        <div id="cascade_city"></div>
                       <select id="city">
                       		<option value="0">请选择......</option>
                       		<?php foreach ($region['city'] as $v){ ?>
                       		<option <?php if($v['id'] == $myregion['city']){ ?>selected="selected"<?php }; ?> value="<?php echo $v['id']; ?>"><?php echo $v['name']; ?></option>
                       		<?php }; ?>
                       	</select>
                    </div>
                </div>
                
              
                  <div id="country_tb" class="addressItem tb"   <?php if(!$region['country']){ ?>style="display:none"<?php }; ?> >
                    <label for="address" class="flex_1">县&nbsp;&nbsp;区</label>
                    <div class="right flex_1 ">
                        <div id="cascade_city"></div>
                       <select id="country" >
                       		<option value="0">请选择......</option>
                       		<?php foreach ($region['country'] as $v){ ?>
                       		<option <?php if($v['id'] == $myregion['country']){ ?>selected="selected"<?php }; ?> value="<?php echo $v['id']; ?>"><?php echo $v['name']; ?></option>
                       		<?php }; ?>
                       	</select>
                    </div>
                </div>
                
                <div class="addressItem tb">
                    <label for="address" class="flex_1">详细地址</label>
                    <div class="right flex_1 ">
                        <div id="cascade_city"></div>
                       
                        <input type="text" name="address" id="address" value="<?php echo $info['address']; ?>" />
                    </div>
                </div>
                <div class="addressItem tb">
                    <label for="is_use" class="flex_1">设置为默认地址</label>
                    <div class="right flex_1">
                        <label class="radio"><input type="radio" value="0" name="is_use" <?php if($info['is_use'] == 0){ ?>checked="checked"<?php }; ?> />否 </label>
                        <label class="radio"><input type="radio" value="1" name="is_use" <?php if($info['is_use'] == 1){ ?>checked="checked"<?php }; ?> />是 </label>
                    </div>
                </div>                
            </div>
   			<div class="m_15" style="position:static">
                <input type="hidden" name="id" value="<?php echo $info['id']; ?>" />
                <input type="hidden" name="from" value="<?php echo $from; ?>"/>
                <button class="btn" type="submit">保存</button>
            </div>
        </form>
    </div>	
<script type="text/javascript">
function tgSubmit() {      
	var userName = $('#truename').val();
	if ($.trim(userName) == "") {
		$.Dialog.fail('请填写姓名');
		return false;
	}
	var regionName = $("input[name=region_name]").val();
	var regionID = $("input[name=region_id]").val();
	if(!regionName || regionID == 0){
		$.Dialog.fail('请选择地址所在地');
		return false;
	}
	var addContent = $("#address").val();
	if( !addContent ){
		$.Dialog.fail('请填写详细地址');
		return false;
	}
	var userPhone = $("#mobile").val();
	if ($.trim(userPhone) == "") {
		$.Dialog.fail('请填写您的手机号码');
		return false;
	}                   
	var patrn = /^0?(13[0-9]|15[0123456789]|18[0123456789]|14[0123456789])[0-9]{8}$/;
	if (!patrn.exec($.trim(userPhone))) {
		$.Dialog.fail('手机号格式错误');
		return false;
	}
	return true;
}
$(function() {

	
	
    var parent_id = "",
        region_name = "",
        $city = $("#city"),
        $dist = $("#country"),
        $provice = $("#provice"),
        $region_id = $("input[name=region_id]"),
        $region_name = $("input[name=region_name]");

    var _provice,
        _city,
        _country;

    $city.on("change", onchange);
    $provice.on("change", onchange);
    $dist.on("change", onchange);

    function onchange() {
        parent_id = $(this).val();
        region_name = $(this).find('option:selected').text();
        var _id = $(this).attr("id");
        if (_id == "provice") {
            $region_id.val("");
            $region_name.val(region_name);
        } else if (_id == "city") {
            $region_id.val("");
            _provice =  $('#provice').find('option:selected').text();
            $region_name.val(_provice + " " + region_name);
        } else if (_id == "country") {
            $region_id.val(parent_id);
            _provice =  $('#provice').find('option:selected').text();
            _city =  $('#city').find('option:selected').text();
            $region_name.val(_provice+ " " + _city + " " + region_name);
            return false;
        }

        $.post("/mall/ajaxregion", {
                "parent_id": parent_id
            },
            function(data) {
                if (data.status) {
                    var temp_html = "<option value='" + 0 + "'>" + "请选择……" + "</option>";
                    $.each(data.info, function(i) {
                        temp_html += "<option  value='" + data.info[i].id + "'>" + data.info[i].name + "</option>";
                    });
                    if (_id == "provice") {
                        $("#country_tb").hide();
                        $("#city_tb").show();
                        //$dist.hide();
                        //$city.show();
                        $city.html(temp_html);
                    };
                    if (_id == "city") {
                        //$dist.show();
                    	$("#country_tb").show();
                        $dist.html(temp_html);
                    };
                }
            }, "json");
    }
})
</script>
</body>
</html>