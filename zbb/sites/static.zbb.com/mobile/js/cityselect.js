/**      .----.
*       _.'__    `.
*   .--($)($$)---/#\
* .' @          /###\
* :         ,   #####
*  `-..__.-' _.-\###/
*        `;_:    `"'
*      .'"""""`.
*     /,     ,\\
*    //  !BUG  \\
*    `-._______.-'
*    ___`. | .'___
*   (______|______)
* @author jon
* @email 191777962@qq.com
*   Ajax 三级省市联动
*   #provice 省级
*   #city   市级
*   #country 县级
*   name=region_id,name=region_name隐藏域；
*/
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
        if (_id == "provice") { //省
            $region_id.val("");
            $region_name.val(region_name);
            _provice = $region_name.val();
        } else if (_id == "city") { //市
            $region_id.val("");
            $region_name.val(_provice + " " + region_name);
            _city = $region_name.val();
        } else if (_id == "country") { //地区
            $region_id.val(parent_id);
            $region_name.val(_city + " " + region_name);
            return false;
        }

        $.post("/buyer/address/get_region", {
                "parent_id": parent_id
            },
            function(data) {
                if (data.success) {
                    var temp_html = "<option value='" + 0 + "'>" + "请选择……" + "</option>";
                    $.each(data.data, function(i) {
                        temp_html += "<option  value='" + data.data[i].region_id + "'>" + data.data[i].region_name + "</option>";
                    });
                    if (_id == "provice") {
                        $dist.hide();
                        $city.show();
                        $city.html(temp_html);
                    };
                    if (_id == "city") {
                        $dist.show();
                        $dist.html(temp_html);
                    };
                }
            }, "json");
    }
})