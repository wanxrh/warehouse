/*
Ajax 三级省市联动
    #provice 省级
    #city   市级
    #country 县级
    name=region_id,name=region_name隐藏域；
*/
define(function(require, exports, module) {

    var $ = require("jquery");

    var citySelect = function(op) {
        var c = $.extend({
            provice: '#provice',
            city: '#city',
            dist: '#dist',
            region_id: '#region_id',
            region_name: '#region_name',
            url: '/buyer/address/get_region'
        }, op);

        var parent_id = "",
            region_name = "",
            _provice,
            _city,
            _country;

        var $provice = $(c.provice), //省
            $city = $(c.city), //市
            $dist = $(c.dist), //县
            $region_id = $(c.region_id),
            $region_name = $(c.region_name);

        $provice.on('change', onChange);
        $city.on('change', onChange);
        $dist.on('change', onChange);

        function onChange() {
            parent_id = $(this).val();
            region_name = $(this).find('option:selected').text();

            var _id = $(this).attr("id");
            if (_id == c.provice.substring(1)) { //省
                $region_id.val("");
                $region_name.val(region_name);
            } else if (_id == c.city.substring(1)) { //市
                $region_id.val("");
                _provice = $provice.find('option:selected').text();
                $region_name.val(_provice + " " + region_name);
            } else if (_id == c.dist.substring(1)) { //县
                $region_id.val(parent_id);
                _provice = $provice.find('option:selected').text();
                _city = $city.find('option:selected').text();
                $region_name.val(_provice + " " + _city + " " + region_name);
                return false;
            }

            $.post(c.url, {
                    "parent_id": parent_id
                }, 
                function(data) {
                    if (data.success) {
                        var _html = "<option value='" + 0 + "'>" + "请选择……" + "</option>";
                        $.each(data.data, function(i) {
                            _html += "<option value='" + data.data[i].region_id + "'>" + data.data[i].region_name + "</option>";
                        });
                        if (_id == c.provice.substring(1)) {
                            $dist.hide();
                            $city
                                .show()
                                .html(_html);
                        };
                        if (_id == c.city.substring(1)) {
                            $dist
                                .show()
                                .html(_html);
                        };
                    }
                }, "json");
        }
    }


    module.exports = citySelect;
})