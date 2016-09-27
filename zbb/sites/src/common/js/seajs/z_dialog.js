define(function(require, exports, module) {
    var $ = require("jquery");

    var dialog = function(opts) {
        $.extend(this, {
            content: null,
            width: null
        }, opts || {});
    };

    dialog.prototype = {
        show: function(html) {
            var html = '<div id="J_make" class="g-remake"></div>' +
                '<div id="J_pop" class="g-pop"><span class="colse">X</span><div class="cont">' +
                this.content +
                '</div></div>';
            $('body').append(html);
            this.position();
        },
        remove: function() {
            $('#J_make,#J_pop').remove();
        },
        position: function() {
            $('#J_pop').css({
                'width': this.width
            });
            var top = $('#J_pop').innerHeight() / 2,
                left = $('#J_pop').innerWidth() / 2;
            $('#J_pop').css({
                'margin-top': -top,
                'margin-left': -left
            });
        },
        init: function() {
            this.show();
            $('body').on('click', '#J_pop .colse', this.remove);
        }
    };

    /*var test = function(ops) {
        var z_dialog = new dialog({
            content: ops,
        });
        z_dialog.init();
        return z_dialog;
    };*/


    module.exports = dialog;
})