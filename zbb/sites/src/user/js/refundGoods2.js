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
 * 商家中心 同意退货-发送退货地址
 * @author 郭朝俊
 * @email 191777962@qq.com
 */
define('refundGoods2', function(require, exports, module) {
    var $ = require("jquery");
    require('user/js/lightbox'); // lightbox插件
    var SizeClew=require('SizeClew');
    exports.init = function() {

        $(".goods-img").lightbox();

        var $J_agree = $('#J_agree'), //同意退货-发送退货地址
            $J_cancel = $('#J_cancel'); //撤消并返回

        //字数限制
        $('#remark').on('keyup',function(){
             SizeClew(this, 200, 0);
        });

        $J_agree.on('click', agreeAjax);
        /**
         * [agreeAjax 同意退货]
         * @return {[type]} [description]
         */
        var checkAjax = false; // 防止多次提交
        function agreeAjax() {
            var addr_id = $('[name=addr_id]').filter(":checked").val();

            var bool = confirm("确认同意退货并发送退货地址吗？");
            if (bool) {
                if (checkAjax) {
                    return false;
                };
                checkAjax = true;
                var addr_id = $('[name=addr_id]').filter(":checked").val(),
                    rec_id = $(this).data('rid'),
                    remark = $('[name=remark]').val(),
                    url = $(this).data('url');
                $.ajax({
                    type: "POST",
                    url: url,
                    dataType: 'json',
                    data: {
                        'rec_id': rec_id,
                        'remark': remark,
                        'addr_id': addr_id
                    },
                    success: function(data) {
                        checkAjax = false;
                        if (data.success) {
                            // alert(data.data);
                            window.location.href = data.data.url;
                        } else {
                            alert(data.data);
                        }
                    }
                });
            };
        };

        $J_cancel.on('click', cancel);
        /**
         * [cancel 返回上一页]
         * @return {[type]} [无返回值]
         */
        function cancel() {
           window.history.back(-1);
        };
    };

    exports.init();
})
seajs.use('refundGoods2');