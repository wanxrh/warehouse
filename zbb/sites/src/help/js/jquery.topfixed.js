;(function($){
        $.fn.topFixed = function(options){
            if(!-[1,] && !window.XMLHttpRequest) return !1;/*判断IE6不执行*/
            var settings = $.extend({
                topRange:300    /*开始滚动的距离*/
            },options),
            $this = $(this);
            $(window).on('scroll resize',function(){
                settings.topRange < $(this).scrollTop() ? $this.css('position','fixed') : $this.css('position','static');
            });
        }
    })(jQuery);