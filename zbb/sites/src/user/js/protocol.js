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
 * 判断用户是否选择了复选框
 * @author 冯丽秋
 * @email 3304518291@qq.com
 */
define('protocol', function(require, exports, module) {
    var $ = require("jquery");
    exports.init = function() {

        //添加点击事件
        $('.btn').on('click', clickbtn);  
        function clickbtn() {
            var check = $('#checkbox').prop('checked');
            //判断是否选择了复选框
            if (check == true) {
                //选择了则跳转页面
                var url = $(this).attr("data-url");

                window.location.href = url;
                //如果没有选则弹出提示框
            } else {
                alert("请先阅读并同意《众宝贝商家服务协议》");

            };
            return false;
        };
    };
    exports.init();
})
seajs.use('protocol');   