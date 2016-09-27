/*
 * 试客后台-//倒计时count_down()-js
 * @author jon
 * @email 191777962@qq.com
 */

define(function(require, exports, moudles) {
    //引入JQ
    var $ = require("jquery");
    function count_down(sec) {
        if (sec <= 0) return '-';
        var s = sec,
            left_s = s % 60,
            m = Math.floor(s / 60),
            left_m = m % 60,
            h = Math.floor(m / 60),
            left_h = h % 24,
            d = Math.floor(h / 24),
            ret = [];
        d && ret.push('<em class="d">', d, '</em>天');
        left_h && ret.push('<em class="h">', left_h, '</em>时');
        left_m && ret.push('<em class="m">', left_m, '</em>分');
        left_s && ret.push('<em class="s">', left_s, '</em>秒');

        return ret.join('');
    }
    var now = $("#time").val();
    setInterval(function() {
        ++now;
        $('.time').each(function() {
            var remain_sec = $(this).attr('data-time');
            this.innerHTML = count_down(remain_sec - now);
        });
    }, 1000);
});