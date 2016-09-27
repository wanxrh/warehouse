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
define('checkStore', function(require, exports, module) {
    var $ = require('jquery');
   
    exports.init = function() {
        $('#J_pre').on('click', prev);
        /**
         * [prev 返回上一步]
         * @return {[type]} [无返回值]
         */
        function prev() {
            var url=$(this).data('url');
            window.location.href=url;
        };


        $('#J_next').on('click', next);
        /**
         * [next 下一步]
         * @return {Function} [无返回]
         */
        function next() {
            if ($.trim($('[name=check_url]').val()) == '') { 
                alert('请填写商品链接！');
                return false;
            } else {
                $('#myForm').submit();
            };
        }
    }

    exports.init();
});
seajs.use('checkStore');