/*   *      .----.
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
 * 众宝贝9.9包邮，值得买-JS
 * @author jon
 * @email 191777962@qq.com
 */
define('main', function(require, exports, module) {  
    var $ = require("jquery");
    var global = require('global');
    require('JQzoom')($); //共享给jquery
    require('jQloading') //方式B

    exports.init = function() {
        //判断是否支持 @media 属性 IE6-8 返回flase 其它返回true;
        if (global.browserIE6_8() == true) {
            require.async('ybadaptive')($);
        };
        global.cnzz(); //站长统计
        //图片懒加载
        $(".j_ImgLoad").find("img").scrollLoading();


       
        //显示与隐藏弹出层 详情页面
        function popShow() {
            $('#J_make,#J_pop').show();
            return false;
        }
        $('#J_op,.m-sd .m-tt').on('click', popShow);
       
        function popHide(){
            $('#J_make,#J_pop').hide();
        }
        $('#J_pop .colse').on('click',popHide); 


        //图片预览
        $(".jqzoom").jqueryzoom({
            xzoom: 430,
            yzoom: 300
        });

        var $picMove=$(".pic_move");
        // 图片替换效果
        $picMove.find('li').on('mouseover',PicTab);
        function PicTab(){
            $(this).siblings().removeClass('pic_hover');//siblings
            $(this).addClass('pic_hover');
            var _src=$(this).children('img').data('src'),
                _img=$(this).children('img').data('img');
            $('.jqzoom img').attr({
                'src': _src,
                'jqimg': _img
            });
        };


    };
    exports.init();
});
seajs.use('main');