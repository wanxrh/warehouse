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
 * 商家中心 商家收货入拒绝退款
 * @author 郭朝俊
 * @email 191777962@qq.com
 */
define('refundGoods', function(require, exports, module) {
    var $ = require("jquery");
    require("common/js/seajs/count_down"); //倒计时
    require('user/js/lightbox'); // lightbox插件
    var SizeClew=require('SizeClew');
    exports.init = function() {

        $('#uploadimg').val(''); //刷新页面时清空上传图片记录

        $(".goods-img").lightbox();

        var $J_refused = $('#J_refused'), //确认拒绝
            $J_cancel = $('#J_cancel'); //撤消并返回

        //字数限制
        $('#remark').on('keyup',function(){
             SizeClew(this, 200, 0);
        });


        $J_refused.on('click', refuseAjax);
        /**
         * [refuseAjax 确认拒绝退款]
         * @return {[type]} [description]
         */
        var checkAjax = false;// 防止多次提交
        function refuseAjax() {
            var _rid = $(this).data('rid'),
                _type = $('#J-type').val(),
                _remark = $('#remark').val(),
                _imgArr = $('#uploadimg').val();
            if(_imgArr==''){
                alert('请上传图片凭证！');
                return false;
            };
            if (checkAjax) {
                return false;
            };
            checkAjax = true;
            
            $.ajax({
                type: "POST",
                url: '/refund/refused_money_submit', 
                dataType: 'json',
                data: {
                    'rec_id': _rid,
                    'refuse_reason': _type,
                    'supplement': _remark,
                    'uploadimg': _imgArr
                },
                success: function(data) {
                    checkAjax = false;
                    if (data.success) {
                        window.location.href = data.data.url; //跳转URL
                    } else {
                        alert(data.data);
                    }
                }
            });

        };


        $J_cancel.on('click', cancel);
        /**
         * [cancel 撤消并返回]
         * @return {[type]} [返回上一页面]
         */
        function cancel() {
            window.history.back(-1);
        };

    };

    exports.init();
})
seajs.use('refundGoods');