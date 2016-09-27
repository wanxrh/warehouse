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
 *
 * 众宝贝-用户中心-发货
 * @author 郭朝俊
 * @email 191777962@qq.com
 */
define('sendGoods', function(require, exports, module) {
    var $ = require("jquery");
    var global = require('global');
    var citySelect = require('citySelect'); //省市区 三级联动插件
    exports.init = function() {
        /**
         * [old_consignee 原始地址数据]
         * @type {[type]}
         */
        var old_consignee = $("#consignee").val(),
            old_region_name = $("#region_name").val(),
            old_address = $("#address").val(),
            old_zipcode = $("#zipcode").val(),
            old_tel = $("#tel").val() || '',
            old_mobile = $("#mobile").val() || '';

        //省市县三级连动
        citySelect({
            provice: "#provice",
            city: "#city",
            dist: "#country",
            region_id: "#region_id",
            region_name: '#region_name',
            url: '/express/get_region'
        });

        var $oldAdd = $('#oldAddr'),
            $newAdd = $('#J_addr'),
            $Jedit = $('#J_edit_addr');

        $Jedit.on('click', editAddr);
        /**
         * [editAddr 修改收货信息]
         *  显示修改区域，隐藏原地址
         * @return {[type]} [无返回值]
         */
        function editAddr() {
            $Jedit.parent().hide();
            $oldAdd.hide();
            $newAdd.show();
        };

        $("#J-set0").on('click', unSetAdd);
        /**
         * [unSetAdd 取消修改地址]
         *  显示原地址，隐藏修改区域
         * @return {[type]} [无返回]
         */
        function unSetAdd() {
            $oldAdd.show();
            $newAdd.hide();
            $Jedit.parent().show();
            return false;
        };

        $("#J-set1").on('click', setAdd);
        /**
         * [setAdd 修改收货信息]
         */
        function setAdd() {
            //判断收货地址是否通过检测；
            if (!checkform()) {
                return false;
            };
            var consignee = $("#consignee").val(),
                province_id = $("#provice option:selected").val(),
                city_id = $("#city option:selected").val(),
                country_id = $("#country option:selected").val(),
                region_name = $("#region_name").val(),
                address = $("#address").val(),
                zipcode = $("#zipcode").val(),
                tel = $("#tel").val() || '',
                mobile = $("#mobile").val() || '',
                oid = $(this).data('oid');



            //如果 原数据与 现数据 全匹配则没有任何改动，跳出；  
            if (consignee == old_consignee && address == old_address && zipcode == old_zipcode && tel == old_tel && mobile == old_mobile && region_name == old_region_name) {
                unSetAdd();
                return false;
            };
            //邮寄地址信息拼接；
            var arrAdd = {};
            arrAdd.consignee = consignee;
            arrAdd.province_id = province_id; //省
            arrAdd.city_id = city_id; //市
            arrAdd.country_id = country_id; //区
            arrAdd.region_name = region_name;
            arrAdd.address = address;
            arrAdd.zipcode = zipcode;
            arrAdd.tel = tel;
            arrAdd.mobile = mobile;
            arrAdd = JSON.stringify(arrAdd);


            //ajax 提交交互；
            $.post('/express/address_ajax', {
                    'order_id': oid,
                    'add': arrAdd
                },
                function(data) {
                    alert(data.data);
                    window.location.reload();
                }, "json");
        };

        //新收货地址检测验证
        function checkform() {
            var consignee = $("input[name=consignee]").val(),
                region_id = $("input[name=region_id]").val(),
                address = $("input[name=address]").val(),
                phone_tel = $("input[name=tel]").val(),
                phone_mob = $("input[name=mobile]").val(),
                zipcode = $("input[name=zipcode]").val();

            if (consignee == "") {
                alert("收货人姓名不能为空！");
                return false;
            };
            if (region_id == "") {
                alert("请选择所在地！");
                return false;
            };
            if (address == "") {
                alert("请输入详细地址！");
                return false;
            };
            if (zipcode != "" && !global.iszip(zipcode)) {
                alert("请输正确的6位数邮政编码！");
                return false;
            };
            if (phone_tel == "" && phone_mob == "") {
                alert("固定电话和手机至少填一项!");
                return false;
            };
            if (phone_tel != "" && !global.isTel(phone_tel)) {
                alert("固定电话格式错误!");
                return false;
            };
            if (phone_mob != "" && !global.isPhoen(phone_mob)) {
                alert("手机格式错误!");
                return false;
            };
            return true;

        };


        var ajax = true; //防止多次提交；
        $("#J_send").on('click', ajaxform);

        function ajaxform() {
            /*if ($(this).data('type') == '0') {//data-type=0 没有退货地址； var _html = '<div><h2>您还没添加或设置“默认退货地址”，是否确认马上添加“退货地址”？</h2><div  style=" text-align: center; padding-top:20px;"><input type="button" id="leave" data-type="1" value="取消" class="u-gray-btn J_true">　　　<input type="button" value="确定" class="u-btn u-g-btn J_true"  data-url="/seller/depot"></div></div>'pops(_html); return false; };*/

            var order_id = $(this).data('oid'), //订单ID
                shopType = $(this).data('type'), //店铺是否设置退货地址
                express_name = $('#express_name option:selected').val(), //物流公司
                invoice_no = $.trim($('#invoice_no').val()), //物流单号
                comment = $.trim($('#comment').val()); //备注
            if (shopType == '0') {
                alert('您还没添加或设置“默认退货地址”，不能进行发货');
                return false;
            };

            if (express_name == '0') {
                alert('有订单没有选择物流公司！');
                return false;
            };

            if (invoice_no == '') {
                alert('有订单没有填写订单号！');
                return false;
            };
            if (ajax == false) {
                return false;
            }
            ajax = false;

            // 发货ajax 提交交互；
            $.post('/express/shipments', {
                    'order_id': order_id, //订单编号
                    'express_name': express_name, //物流公司
                    'invoice_no': invoice_no, //运单号码
                    'comment': comment //备注
                },
                function(data) {
                    if (data.success == true) {
                        alert(data.data);
                        window.location.href = '/orders/lists'; //跳到订单列表页面(PHP偷懒，只能前端强行跳转了)
                        return false;
                    } else {
                        alert(data.data);
                    };
                    ajax = true;

                }, "json");
        };

    };
    exports.init();
});
seajs.use('sendGoods');