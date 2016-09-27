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
 * yiban IE6-8 响应式解决方案-JS
 * @author jon
 * @email 191777962@qq.com
 */

define(function(require, exports, moudles) {
    return function($) {
        $(function($) {
            $(window).resize(function() {
                var _w = document.body.clientWidth;
                if (_w < 1200) {
                    $('body').addClass("w990");
                } else {
                    $('body').removeClass("w990");
                }
            });
            $(window).resize();
        });
    };
})