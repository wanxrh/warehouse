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
 * 商家中心 退货
 * @author 郭朝俊
 * @email 191777962@qq.com
 */
define('refundGoods', function(require, exports, module) {
    var $ = require("jquery");
    require("common/js/seajs/count_down"); //倒计时
    require('user/js/lightbox');// lightbox插件
    var SizeClew=require('SizeClew');
    exports.init = function() {

        $('#uploadimg').val(''); //刷新页面时清空上传图片记录

        $(".goods-img").lightbox();

        var $J_agree = $('#J_agree'), //同意退货申请
            $J_refuse = $("#J_refuse"), //拒绝退货申请
            $J_refused = $('#J_refused'), //确认拒绝
            $J_cancel = $('#J_cancel'); //撤消并退货

        //字数限制
        $('#remark').on('keyup',function(){
             SizeClew(this, 200, 0);
        });
        
        $J_agree.on('click', agreeAjax);
        /**
         * [agreeAjax 同意退货]
         * @return {[type]} [description]
         */
        function agreeAjax() {
            var bool = confirm("确认同意退货申请吗？");
            if (bool) {
                var url = $(this).data('url');
                window.location.href = url;
            };
        };


        $J_refused.on('click',refuseAjax);
        /**
         * [refuseAjax 确认拒绝退货]
         * @return {[type]} [description]
         */
        var checkAjax = false; // 防止多次提交
        function refuseAjax() {
            /*ajax路径:refund/refused_mone
               参数 refuse_reason；supplement，uploadimg ，rec_id*/
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
                url: '/refund/refused_goods', 
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
                        alert(data.data);
                        window.location.reload();
                    } else {
                        alert(data.data);
                    }
                }
            });

        };

        $J_refuse.on('click', refuse);
        /**
         * [refuse 拒绝退货申请]
         * @return {[type]} [切换到拒绝页面]
         */
        function refuse() {
            $('#J_act_1').hide();
            $('#J_act_2').show();
        };


        $J_cancel.on('click', cancel);
        /**
         * [cancel 撤消拒绝退货申请]
         * @return {[type]} [切换到同意页面]
         */
        function cancel() {
            $('#J_act_2').hide();
            $('#J_act_1').show();
        };

        $('#J_refuseMoney').on('click',refuseMoney)
        /**
         * [refuseMoney 收到退货后同意退款]
         * @return {[type]} [返回跳转地址]
         */
        function refuseMoney(){
            var bool = confirm("确认退款吗？"), 
                _rid = $(this).data('rid');
            if (!bool) {
                return false;
            };
            if (checkAjax) {
                return false;
            };
            checkAjax = true;
            $.ajax({
                type: "POST",
                url: '/refund/drawback',
                dataType: 'json',
                data: {
                    'rec_id': _rid
                },
                success: function(data) {
                    checkAjax = false;
                    if (data.success) {
                        window.location.href=data.data.url;
                    } else {
                        alert(data.data);
                    }
                }
            });
        };

    };

    exports.init();
})
seajs.use('refundGoods');