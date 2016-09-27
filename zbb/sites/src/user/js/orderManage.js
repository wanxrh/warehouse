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
 * 商家中心-订单管理（已卖出宝贝）
 * @author 郭朝俊
 * @email 191777962@qq.com
 *修改：冯丽秋，点击导出跳转链接
 */
define('orderManage', function(require, exports, module) {
    var $ = require("jquery");
    require('./common/js/seajs/cb_all'); //全选控件
    require("./common/js/seajs/laydate.dev"); //日期控件
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


        //点击(导出)跳转链接
        $(".btn-gray").on("click", exporte);

        function exporte() {
            var form_url = "/orders/lists";
            var url = $(this).attr("data-url");
            var r = confirm("为了保证您的订单导出顺畅，两次导出的时间间隔请保持在 2 分钟以上。");
            if (r == true) {
                $("#form").attr("action", url); //导出订单的路径
                $("#form").submit();
                $("#form").attr("action", form_url);//搜索路径
            };

        }

        //全选
        $("#J_all").checkAll("input[type=checkbox]");

    };

    exports.init();
})
seajs.use('orderManage');