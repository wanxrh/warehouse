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
 * 众宝贝-退货地址-JS
 * @author jon
 * @email 191777962@qq.com
 */
define('refund', function(require, exports, module) {
    var $ = require('jquery');
    var citySelect = require('citySelect');
    var dialog = require("z_dialog");
    var global = require("global");  
    exports.init = function() {

        /**
         * [del 删除退货地址]
         * @return {[type]} [返回是否删除成功]
         */
        function del() {
            var bool = confirm('确定删除该条退货地址吗？'),
                $this = $(this);
            if (bool) {
                var id = $(this).data('id');
                $.ajax({
                    type: "POST",
                    url: '/address/addr_del',
                    dataType: 'json',
                    data: {
                        'addr_id': id
                    },
                    success: function(data) {
                        if (data.success) {
                            alert('已经成功删除该条退货地址！');
                            $this.parents('tr').remove();
                            //window.location.reload();
                        } else {
                            alert(data.data);
                        }
                    }
                });
            }
        };
        $('.J_del').on('click', del); 

        /**
         * [setDefualt 设置默认退货地址并高亮显示]
         */
        function setDefualt() {
            //如已是默认则跳出；
            if ($(this).hasClass("btn-def")) {
                //return false
            };
            var id = $(this).data('id'),
                $this = $(this);
            $.ajax({
                type: "POST",
                url: '/address/set_default',
                dataType: 'json',
                data: {
                    'addr_id': id
                },
                success: function(data) {
                    if (data.success) {
                        $('.J_def').removeClass('btn-def');
                        $this.addClass('btn-def');
                        //window.location.reload();
                    } else {
                        alert(data.data);
                    }
                }
            });
        };
        $('.J_def').on('click', setDefualt);

        /**
         * [edit description]
         * @return {[type]} [description]
         */
        function edit() {
            var name = $(this).data('c'), //收货人
                region_name=$(this).data('r'),//地址
                addr = $(this).data('addr'),//详细地址
                zip = $(this).data('zip'),//邮政编码
                phone = $(this).data('m'),//手机号码
                id=$(this).data('id'),//数据Id
                url='/address/addr_edit';
            var _country='',
                _city='',
                _province='';
            $.ajax({
                type: "POST",
                url: '/address/addr_view',
                dataType: 'json',
                data:{
                    'addr_id' :id
                },
                success: function(data) {
                    if (data.success) {
                        $.each(data.data.region.country, function(i) {
                            if (data.data.region.country[i].region_id==data.data.my_region.country) {
                                _country += '<option value="' + data.data.region.country[i].region_id + '" selected="selected">'+ data.data.region.country[i].region_name + '</option>';
                            }else{
                                _country += '<option value="' + data.data.region.country[i].region_id + '">'+ data.data.region.country[i].region_name + '</option>';
                            }
                            
                        });
                        $.each(data.data.region.city, function(i) {
                            if (data.data.region.city[i].region_id==data.data.my_region.city) {
                                _city += '<option value="' + data.data.region.city[i].region_id + '" selected="selected">'+ data.data.region.city[i].region_name + '</option>';
                            }else{
                                _city += '<option value="' + data.data.region.city[i].region_id + '">'+ data.data.region.city[i].region_name + '</option>';
                            }
                        });
                        $.each(data.data.region.province, function(i) {
                            if (data.data.region.province[i].region_id==data.data.my_region.province) {
                                _province += '<option value="' + data.data.region.province[i].region_id + '" selected="selected">'+ data.data.region.province[i].region_name + '</option>';
                            }else{
                                _province += '<option value="' + data.data.region.province[i].region_id + '">'+ data.data.region.province[i].region_name + '</option>';
                            }
                        });

                        var html='<div class="popBox">'
                                +    '<div class="m-tt">修改退货地址</div>'
                                +    '<ul>'
                                +        '<li><span class="tt">* 收货人姓名：</span> <input id="J_name" type="text" class="txt" placeholder="请填写收货人姓名" value="'+ name +'"/></li>'
                                +        '<li><span class="tt">* 所在地：</span><select class="select" name="" id="provice">'+ _province +'</select>　<select class="select" name="" id="city">'+ _city +'</select>　<select class="select" name="" id="country">'+ _country +'</select><input type="hidden" id="region_id" value="'+ data.data.my_region.country +'"/><input type="hidden" id="region_name" value="'+ region_name +'"/></li>'
                                +        '<li><span class="tt">* 详细地址：</span><textarea class="textarea" name="" id="J_addr" cols="30" rows="10">'+ addr +'</textarea></li>'
                                +        '<li><span class="tt">* 邮政编码：</span><input type="text" class="txt" id="J_zip" placeholder="请填写6位数字邮政编码" value="'+zip+'"/></li>'
                                +        '<li><span class="tt">* 联系电话：</span><input type="text" id="J_phone" class="txt" placeholder="请填写您的联系电话" value="'+phone+'"/></li>'
                                +    '</ul>'
                                +    '<div class="f-tac"><button class="btn" id="subBtn">保存收货地址</button></div>'
                                +'</div>';
                        showPOP(html ,url, id);    
                    };
                }
            });
               
        };
        $('.J_edit').on('click', edit);

        /**
         * [add 新增退货地址]
         */
        function add(){
            var _html='<option value=""> -- 请选择 -- </option>',
                url='/address/addr_add';
            $.ajax({
                type: "POST",
                url: '/address/get_province',
                dataType: 'json',
                data:{
                    parent_id :0
                },
                success: function(data) {
                    if(data.success){
                        $.each(data.data, function(i) {
                            _html += '<option value="' + data.data[i].region_id + '">'+ data.data[i].region_name + '</option>';
                        });
                    };
                    var html='<div class="popBox">'
                            +    '<div class="m-tt">添加退货地址</div>'
                            +    '<ul>'
                            +        '<li><span class="tt">* 收货人姓名：</span> <input id="J_name" type="text" class="txt" placeholder="请填写收货人姓名"/></li>'
                            +        '<li><span class="tt">* 所在地：</span><select class="select" name="" id="provice">'+ _html +'</select>　<select class="select" name="" id="city" style="display:none"><option>地址</option></select>　<select class="select" name="" id="country"  style="display:none"><option>地址</option></select><input type="hidden" id="region_id"/><input type="hidden" id="region_name"/></li>'
                            +        '<li><span class="tt">* 详细地址：</span><textarea class="textarea" name="" id="J_addr" cols="30" rows="10"></textarea></li>'
                            +        '<li><span class="tt">* 邮政编码：</span><input type="text" id="J_zip" class="txt" placeholder="请填写6位数字邮政编码"/></li>'
                            +        '<li><span class="tt">* 联系电话：</span><input type="text" id="J_phone" class="txt" placeholder="请填写您的联系电话"/></li>'
                            +    '</ul>'
                            +    '<div class="f-tac"><button class="btn" id="subBtn">保存收货地址</button></div>'
                            +'</div>';
                    showPOP(html, url);
                }
            });
        };
        $('.J_add').on('click',add);

        
        
        /**
         * [showPOP 弹出层]
         * @param  {[type]} str [弹出层内容]
         * @param  {[type]} url [弹出层内AJAX 路径]
         * @param  {[type]} id  [修改地址数据 ID/ 新增则无ID]
         * @return {[type]}     [无返回]
         */
        function showPOP(str, url, id) {
            var z_dialog = new dialog({
                content: str,
            });
            z_dialog.init();

            //省市县三级连动
            citySelect({
                provice: "#provice",
                city: "#city",
                dist: "#country",
                region_id: "#region_id",
                region_name: '#region_name',
                url: '/address/get_province'
            });

             //防止点击一次，多次提交
            $("body").off("click", "#subBtn"); 

            //提交新增(修改)地址
            $('body').on('click','#subBtn',addSub);
            function addSub(){
                var name = $.trim($('#J_name').val()),
                    region_id = $.trim($('#region_id').val()), 
                    region_name=$('#region_name').val(),
                    addr = $.trim($('#J_addr').val()),
                    zip = $.trim($('#J_zip').val()),
                    phone = $.trim($('#J_phone').val());
                if (name == '' || region_id == '' || addr == '' || zip == '' || phone == '') {
                    alert('请填写完相应信息！');
                    return false;
                };
                if(!global.iszip(zip)){
                    alert('请填写正确的邮政编号！');
                    return false;
                };
                if(!global.isPhoen(phone)){
                    alert('请填写正确的手机号！');
                    return false;
                };

                if (id) {//有ID为修改，要传该条数据ID
                    var data = {
                        'name': name, // 退货人名字
                        'region_id': region_id, // 区级ID
                        'region_name': region_name, // 省 市 区 内容
                        'addr': addr, // 街道内容
                        'zip': zip, // 邮政编码
                        'addr_id': id, // 数据ID
                        'phone': phone // 手机号码
                    };
                } else {//无id为新增
                    var data = {
                        'name': name, // 退货人名字
                        'region_id': region_id, // 区级ID
                        'region_name': region_name, // 省 市 区 内容
                        'addr': addr, // 街道内容
                        'zip': zip, // 邮政编码
                        'phone': phone // 手机号码
                    };
                };
                
                $.ajax({
                    type: "POST",
                    url: url,
                    dataType: 'json',
                    data: data,
                    success: function(data) {
                        if (data.success) {
                            z_dialog.remove();
                            alert(data.data);
                            window.location.reload();
                        } else {
                            z_dialog.remove();
                            alert(data.data);
                        }
                    }
                });

            };
        };

    };

    exports.init();
});
seajs.use('refund');