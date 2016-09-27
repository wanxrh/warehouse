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
* yiban.com mobile 瀑布流
* @author jon
* @email 191777962@qq.com
* @param ajxa请求url地址
*/

$.waterfallLayout = function(url) {

    var $minUl = $("#container"),
        page = 0;
        complete=false;

    //滑动加载事件
    $(window).on("scroll", function() {
        if ( getDataCheck() && complete == false) {
            //post 
            complete=true;
            $.post(url, {
                    "page": page
                },
                function(data) {
                    loadMeinv(data); //加载新图片
                }, "json");

            //加载参数累计; 
            page++;
        }
    })

    //加载新图片
    function loadMeinv(data) {

        var _length= data.length;
        for (var i = 0; i < _length; i++) { //每次加载时模拟随机加载图片
            var html = "";
            html = '<li class="m-goods-list-view">'
                    +'<a href="'+data[i].goods_url+'">'
                    +    '<div class="pic">'
                    +        '<img src="'+data[i].default_image+'" alt="">'
                    +    '</div>'
                    +    '<div class="info-box">'
                    +        '<div class="info">'
                    +            '<div class="tt">'
                    +                '<h2>'+data[i].goods_name+'</h2>'
                    +            '</div>'
                    +            '<div class="price-box">'
                    +                '<span class="price">￥'+data[i].price+'</span><span class="un-price">￥'+data[i].cost_price+'</span>'
                    +            '</div>'
                    +        '</div>'
                    +    '</div>'
                    +'</a>'   
                    +'</li>';

            $minUl.append(html);
            //加载完成时
            if (i == _length - 1) {
                complete = false;
            }
        }
    }

    // 判断请求数据的开关
    function getDataCheck() {
        var box = $(".m-goods-list-view");
        var lastboxHeight = $(box[box.length - 1]).offset().top + Math.floor($(box[box.length - 1]).outerHeight() / 2);
        var documentHeight = $(window).height();
        var scrollTop = $(document).scrollTop();
        return lastboxHeight < (documentHeight + scrollTop) ? true : false;
    }

    //返回顶部
    var a = function(c, f, e) {
        var d = $(c).click(function() {
                $("body,html").animate({
                    scrollTop: 0
                }, e);
                return false
            });

            $(this).scroll(function() {
                $(this).scrollTop() > f ? d.fadeIn(e) : d.fadeOut(e)
            })
    };

    $('<a id="backToTop" title="\u56de\u5230\u9876\u90e8" target="_self" href="javascript:;"><span class="I-ico">&#xa602;</span></a>').appendTo("body");
    a("#backToTop", 0, 300);
};