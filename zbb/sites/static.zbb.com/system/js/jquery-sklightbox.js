/**
 * $.sklightbox
 * @extends jquery
 * @fileOverview lightbox申诉凭证图片展示
 * @author jon
 * @email 191777962@qq.com
 * @site www.yiban.com
 * @version 0.2
 * @date 2014-2-19
 */
(function($) {
    $.fn.sklightbox = function() {
        var $this = $(this),
            aResult = [], //存储对象数组；
            _block = false, //判断是否已经弹出层锁定当前页面；
            imgdefereds = [], //图片加载成功与失败数组；
            _imgLength; //相应图片总数
        //点击获取图片总数量，并存入数组。显示弹出层
        $this.find("img").off("click").on("click", function() {
            //$(this).parent().css('background-color', 'red');
            aResult.length = 0;
            var aElement = $(this).parent().find("img"),
                Allimg = aElement.length,
                _srt = "";
            for (var i = 0; i < Allimg; i++) {
                aResult.push(aElement[i]);
                _srt += '<img id="light_img" src="' + aResult[i].href + '"/>';
            }
            var _int = $(this).parent().find("a").index($(this));
            showPopup(_int, Allimg, _srt);
            return false;
        })
        //页面添加Popup弹出层
        var d_height = $(document).height();
        var w_height = $(window).height();
        function showPopup(_int, Allimg, _srt) {
            imgdefereds.length = 0;
            //获取初始的文档高度和窗口高度
            var _mask = '<div class="mask"></div>';
            var _html = '<div class="popup"><iframe id="lightbox"></iframe>' +
                '<div class="prev btn"><div></div></div>' +
                '<div class="next btn"><div></div></div>' +
                '<div id="lightbox-cont">' + _srt + '</div>' +
                '<div class="popupClose"><a></a></div>' +
                '</div>';
            if ($(".aui_state_lock").length > 0) { //如果.aui_state_lock对象存在，就隐藏该对象
                _block = true;
                $(".aui_state_lock").hide();
            } else {
                $("body").append(_mask);
            }
            $(" body").append(_html);
            //判断图片是否加载成功
            _imgLength = $('#lightbox-cont img').length;
            $('#lightbox-cont img').one('load', function() {
                imgdefereds.push("true");
                loadComplete(_int, Allimg, imgdefereds);
            }).one('error', function() {
                imgdefereds.push("false");
                loadComplete(_int, Allimg, imgdefereds);
            }).each(function() {
                if (this.complete) $(this).load();
            })

            //prev事件
            $(".prev").on('click', function() {
                _int--;
                if (_int == -1) {
                    _int = Allimg - 1;
                }
                clickSwitch(_int, Allimg, imgdefereds);
            })
            //next事件
            $(".next").on('click', function() {
                _int++;
                if (_int == Allimg) {
                    _int = 0;
                }
                clickSwitch(_int, Allimg, imgdefereds);
            })
            //删除事件
            $(".popupClose").on('click', function() {
                $("div").detach(".popup");
                if (_block) { //显示.aui_state_lock对象；
                    $(".aui_state_lock").show();
                } else {
                    $("div").detach(".mask");
                }
            })
            //移入显示关闭按钮
            $(".popup,.btn").hover(
                function() {
                    $(this).addClass("popuphover");
                },
                function() {
                    $(this).removeClass("popuphover");
                }
            );
        }
        //图片判断完成
        function loadComplete(_int, Allimg, imgdefereds) {
            _imgLength--;
            if (_imgLength == 0) {
                clickSwitch(_int, Allimg, imgdefereds);
            }
        }
        //切换显示图片。
        function clickSwitch(_int, Allimg, imgdefereds) {
            $(".popup").show();
            for (var i = 0; i < Allimg; i++) {
                //显示相对应图片
                if (i != _int) {
                    $("#lightbox-cont img").eq(i).hide();
                } else {
                    $("#lightbox-cont img").eq(i).show();
                }
                if (imgdefereds[i] != "true") {
                    //如果图片加载失败
                    $("#lightbox-cont img").eq(i).hide();
                    var h = 300,
                        w = 300;
                } else {
                    //如果图片加载成功
                    var h = $(".popup").find("img").eq(_int).height(),
                        w = $(".popup").find("img").eq(_int).width();
                }
            }
            var _top = ($(window).height() - h) / 2 + $(document).scrollTop(),
                _left = ($(window).width() - w) / 2;
            resizePop(h, w, _top, _left);
        }
        //重写弹出层大小。
        function resizePop(h, w, _top, _left) {
            if (!_block) { //如果有遮罩，设置遮罩高度;
                if ($(window).height() > $(document).height()) {
                    $(".mask").css("height",w_height);
                } else {
                    $(".mask").css("height", d_height);
                }
            }
            if ($(window).height() < h) { //弹出层强制头部在页面内
                _top > 0 ? _top = _top : _top = 50;
            }
            $("#lightbox-cont,#lightbox").css({
                "height": h,
                "width": w
            });
            $(".popup").css({
                "left": _left,
                "top": _top,
                "height": h + 20,
                "width": w + 20
            });
        }
    }
})(jQuery);