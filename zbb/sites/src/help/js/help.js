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
 * 帮助中心-JS
 * @author jon
 * @email 191777962@qq.com
 */

define('help',function(require, exports, module) {  
    var $ = require("jquery");
    var global = require("global");
    require('search'); //搜索框提示语
    exports.init = function() { 

        //global.init();
        global.cnzz();//站长统计

        //判断是否支持 @media 属性 IE6-8 返回flase 其它返回true;
        if (global.browserIE6_8() == true) {
           require.async('ybadaptive')($);
        };
        
        var path_name = "/" + window.location.href.split('/')[3];
        $('#J_sideMenu a').each(function(i, n) {
            var crt_path = $(this).attr('href');
            if (crt_path == path_name) {
                $(this).addClass('z-crt');
            }
        });
        
        /*$('#J_sideMenu').topFixed({
            topRange: 105
        });*/

       
        var menuleft=$(".subtt h2");//找到要点击的h1
        
          
        menuleft.hover(function(e) {//添加鼠标经过事件
        $(this).addClass("hover");},
        function(){
        $(this).removeClass("hover");   
        });

       menuleft.click(function(e) {//添加点击事件
       
        $(this).toggleClass("tt-bgc");
        $(this).next("ul").slideToggle("slow");
 
       })

         $(".subtt li").click(function(e){
            $(".subtt li").removeClass('menufc');
         $(this).addClass("menufc")
        });

    } 
    exports.init();
});

seajs.use('help');

