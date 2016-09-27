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
 * 众宝贝-入驻店铺信息-JS
 * @author jon
 * @email 191777962@qq.com
 */
define('apply', function(require, exports, module) {
    var $ = require('jquery');
    //日期控件
    require("./common/js/seajs/laydate.dev");
    exports.init = function() {

        //日期控件
        var e_start = {
            elem: '#add_time_from',
            event: 'click', //触发事件
            choose: function(dates) { //选择好日期的回调
                e_end.min = dates;
                e_end.start = dates;
            }
        };
        var e_end = {
            elem: '#add_time_to',
            event: 'click', //触发事件
            choose: function(dates) { //选择好日期的回调
                e_start.max = dates;
            }
        };
        laydate(e_start);
        laydate(e_end);


        $('[name=store_type]').on('change', changeType);
        /**
         * [changeType 店铺类型切换]
         * @return {[type]} [无返回值]
         */
        function changeType() {
            if ($(this).val() == 5) { //5 为c店
                $('#J_other').hide().find('input').attr('disabled', true);
                //$('#myForm').attr('action', '/store/check_store');
            } else { // 非C店
                $('#J_other').show().find('input').attr('disabled', false);
                //$('#myForm').attr('action', '/store/under_review');
            };
        };


        $('[name=typeA]').on('click', changePaper);

        /**
         * [changePaper 证件类型切换]
         * @return {[type]} [无返回值]
         */
        function changePaper() {
            if ($('[name=typeA]:checked').val() == 1) { //三证分离
                $('#J_three').show().find('input').attr('disabled', false);
                $('#J_all').hide().find('input').attr('disabled', true);
            } else { //三证合一
                $('#J_all').show().find('input').attr('disabled', false);
                $('#J_three').hide().find('input').attr('disabled', true);
            };
        };
        //刷新页面时判断
        changePaper();

        $('[name=cate_1]').on('change', changeShopType);
        /**
         * [changeShopType 选择店铺商品类型]
         * @return {[type]} [返回该分类下的子分类]
         */
        function changeShopType() {
            var id = $(this).val();
            $.ajax({
                type: "POST",
                url: '/store/get_cate',
                dataType: 'json',
                data: {
                    'parent_id': id
                },
                success: function(data) {
                    if (data.success) {
                        var html = '<option selected="selected" value="0">-- 请选择商品分类 --</option>';
                        $.each(data.data, function(i) {
                            html += '<option value="' + data.data[i].cate_id + '">' + data.data[i].cate_name + '</option>';
                        });
                        $('[name=cate_2]').html(html).show();
                    };
                }
            });
        };



        $('#J_pre').on('click', prev);
        /**
         * [prev 返回上一步]
         * @return {[type]} [无返回值]
         */
        function prev() {
            var url=$(this).data('url');
            window.location.href=url;
        };


        $('#J_btn').on('click', next);
        /**
         * [next 下一步]
         * @return {Function} [无返回]
         */
        function next() {

            if ($.trim($('[name=store_name]').val()) == '') {
                alert('请填写店铺名称！');
                return false;
            };
            if ($('[name=cate_2]').val() == 0) {
                alert('请选择主营类目！');
                return false;
            };
            //name="cate_2" 
            if ($('[name=store_type]').val() == 5) { //C店
                $('#myForm').submit();
            } else { //非C店
                var check = $('[name=start_end]').prop('checked');
                if ($.trim($('[name=company_name]').val()) == '') {
                    alert('请填写公司名称！');
                    return false;
                };
                if ($.trim($('[name=license]').val()) == '') {
                    alert('请填营业执照注册号！');
                    return false;
                };
                if ($('[name=start_time]').val() == '') {
                    alert('请填营业期限！');
                    return false;
                }; //
                if ($('[name=end_time]').val() == '' && !check) {
                    console.log('check===>'+check)
                    alert('请填营业期限！');
                    return false;
                };
                if ($('[name=typeA]:checked').val() == 1) { //三证分离
                    var img1 = $('[name=image_1]').val(),
                        img2 = $('[name=image_2]').val(),
                        img3 = $('[name=image_3]').val();
                    if (img1 == '' || img2 == '' || img3 == '') {
                        alert('请上传相关证件资料！');
                        return false;
                    } else {
                        $('#myForm').submit();
                    };
                } else { //三证合一
                    var img4 = $('[name=image_4]').val();
                    if (img4 == '') {
                        alert('请上传相关证件资料！');
                        return false;
                    } else {
                        $('#myForm').submit();
                    };
                };
            };
            return false;
        };
    };

    exports.init();
});
seajs.use('apply');