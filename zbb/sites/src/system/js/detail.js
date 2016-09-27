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
* 待处理申述列表-定时器-关闭退款申请-退款给买家
* @author 冯丽秋
* @email 3304518291@qq.com
*/
define('detail', function(require, exports, module) {
    var $ = require("jquery");
    require("common/js/seajs/count_down"); //倒计时
    exports.init = function() {
        //关闭退款申请
        $("#J_close").on("click", close);

        function close() {
            var clos = confirm('关闭退款将会回到正常流程，确定关闭吗？'),
                rid = $(this).data("rid");
            if (clos) {
                $.ajax({
                    type: "POST",
                    url: "/appeal/close",
                    dataType: "json",
                    data: {
                        'appeal_id': rid
                    },
                    success: function(data) {
                        if (data.success == true) {
                            alert(data.data);
                            window.location.reload();
                        } else {
                            alert(data.data);
                        }
                    }
                })
            };
        };

        //退款给买家
        $("#J_refund").on("click", refund);

        function refund() {
            var bool = confirm('确定要退款给买家吗？'),
                rid = $(this).data("rid");
            if (bool) {
                $.ajax({
                    type: "POST",
                    url: "/appeal/refund",
                    dataType: "json",
                    data: {
                        'appeal_id': rid
                    },
                    success: function(data) {
                        if (data.success == true) {
                            alert(data.data);
                            window.location.reload();
                        } else {
                            alert(data.data);
                        }
                    }
                })
            }
        };

        //退款给卖家
        $('#J_refund_seller').on('click',refundSeller);
        function refundSeller() {
            var bool = confirm('确定要退款给卖家吗？'),
                rid = $(this).data("rid");
            if (bool) {
                $.ajax({
                    type: "POST",
                    url: "/refund/refund_seller",
                    dataType: "json",
                    data: {
                        'appeal_id': rid
                    },
                    success: function(data) {
                        if (data.success == true) {
                            alert(data.data);
                            window.location.reload();
                        } else {
                            alert(data.data);
                        }
                    }
                })
            }
        };

        //同意退货
        $('#J_agree').on('click',agreeRefund); 
        function agreeRefund() {
            var bool = confirm('确定要同意退货吗？'),
                rid = $(this).data("rid");
            if (bool) {
                $.ajax({
                    type: "POST",
                    url: "/refund/drawback",
                    dataType: "json",
                    data: {
                        'appeal_id': rid
                    },
                    success: function(data) {
                        if (data.success == true) {
                            alert(data.data);
                            window.location.reload();
                        } else {
                            alert(data.data);
                        }
                    }
                })
            }
        };
    };
    exports.init();
})
seajs.use('detail');