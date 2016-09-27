$(function($) {

    //商品分类
    $(".tpye").click(function() {
            $(".mask").toggle();
            if ($(this).hasClass("cur")) {
                $(this).removeClass("cur");
                $(".wsc-sub").toggle().animate({
                    left: '-61.8%'
                }, 300);
            } else {
                $(this).addClass("cur");
                $(".wsc-sub").toggle().animate({
                    left: 0
                }, 300);
            }
        })
        //复选框
    $(".checkbox").click(function() {
        if ($(this).hasClass("checkbox-setion")) {
            $(this).removeClass("checkbox-setion");
        } else {
            $(this).addClass("checkbox-setion");
        }
    })

    //购物车增减产品
    $(".add").click(function() {
        var _input = $(this).parent().find("input"),
            _int = _input.val();
        _int++;
        _input.val(_int);
    })
    $(".sub").click(function() {
        var _input = $(this).parent().find("input"),
            _int = _input.val();
        if (_int > 0) {
            _int--;
        }
        _input.val(_int);
    })

    //显示余额
    $("#pb_money").click(function() {
       // $(this).text("post返回金额-‘等待路径’").css("font-weight", 700).off();
        $.get("index.php?app=mobile&act=get_hlpay_amount",
            function(data){
            $("#pb_money").text(data).css("font-weight", 700).off();
        }); 
    })


    
})
/* MSG提示
     *  type: ok / no / normal 弹出层样式
     *  data: 弹出层信息内容
     *  time：弹出层消失时间
     *  TipMsg("如果你尚未收到货品请不要点击“确认”。", "no", 2000);
     */
    function TipMsg(data, type, time) {
        var type = ($.trim(type) != "") ? type : "normal",
            html = '<div id="MsgPop"><div class="price ' + type + '"></div><div class="info">' + data + '</div></div>',
            time = time || 3000;
        $("body").append(html);
        $("#MsgPop").animate({
            top: '40%'
        }, "slow");
        setTimeout(function() {
            $("div").remove("#MsgPop");
        }, time)
    }
