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
 * 自动匹配人民币（.00）；
 * @author jon
 * @email 191777962@qq.com
 */

define(function(require, exports, moudles) {
    //引入JQ
    var $ = require("jquery");
    $.fn.matchmoney = function(op) {
        this.each(function() {
            var c = $.extend({
                obj: '.obj'
            }, op);
            $(this).on('keyup', c.obj, function() {
                var regStrs = [
                    ['^0(\\d+)$', '$1'], //禁止录入整数部分两位以上，但首位为0
                    ['[^\\d\\.]+$', ''], //禁止录入任何非数字和点
                    ['\\.(\\d?)\\.+', '.$1'], //禁止录入两个以上的点
                    ['^(\\d+\\.\\d{2}).+', '$1'] //禁止录入小数点后两位以上
                ];
                for (var i = 0; i < regStrs.length; i++) {
                    var reg = new RegExp(regStrs[i][0]);
                    var _val = $(this).val().replace(reg, regStrs[i][1]);
                    $(this).val(_val)
                }
            });
            $(this).on('blur', c.obj, function() {
                var v = $(this).val();
                if (v === '') {
                    v = '0.00';
                } else if (v === '0') {
                    v = '0.00';
                } else if (v === '0.') {
                    v = '0.00';
                } else if (/^0+\d+\.?\d*.*$/.test(v)) {
                    v = v.replace(/^0+(\d+\.?\d*).*$/, '$1');
                    v = inp.getRightPriceFormat(v).val;
                } else if (/^0\.\d$/.test(v)) {
                    v = v + '0';
                } else if (!/^\d+\.\d{2}$/.test(v)) {
                    if (/^\d+\.\d{2}.+/.test(v)) {
                        v = v.replace(/^(\d+\.\d{2}).*$/, '$1');
                    } else if (/^\d+$/.test(v)) {
                        v = v + '.00';
                    } else if (/^\d+\.$/.test(v)) {
                        v = v + '00';
                    } else if (/^\d+\.\d$/.test(v)) {
                        v = v + '0';
                    } else if (/^[^\d]+\d+\.?\d*$/.test(v)) {
                        v = v.replace(/^[^\d]+(\d+\.?\d*)$/, '$1');
                    } else if (/\d+/.test(v)) {
                        v = v.replace(/^[^\d]*(\d+\.?\d*).*$/, '$1');
                        ty = false;
                    } else if (/^0+\d+\.?\d*$/.test(v)) {
                        v = v.replace(/^0+(\d+\.?\d*)$/, '$1');
                        ty = false;
                    } else {
                        v = '0.00';
                    }
                }
                $(this).val(v);
            })
        });
    };

})