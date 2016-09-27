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
 * 商家中心-消息管理
 * @author 郭朝俊
 * @email 191777962@qq.com
 */
define('goodsList', function(require, exports, module) {
    var $ = require("jquery");
    require('./common/js/seajs/cb_all');
    exports.init = function() {


        $('.J_del').on('click', delMsg);
        /**
         * [delMsg 删除消息]
         * @return {[type]} [提示成功与否]
         */
        function delMsg() {
            var bool = confirm('确定删除该消息吗？'),
                id = $(this).data('id'),
                $this = $(this);
            if (bool) {
                $.ajax({
                    type: "POST",
                    url: '/message/del_message',
                    dataType: 'json',
                    data: {
                        'msg_id': id
                    },
                    success: function(data) {
                        if (data.success) {
                            $this.parents('.itme').remove(); //无刷新删除该条消息;
                        } else {
                            alert(data.data); //失败时提示
                        }
                    }
                });
            };
        };

        $('.J_info').on('click', showMsg);
        /**
         * [showMsg 获取消息内容]
         * @return {[type]} [返回消息内容，如已有内容则切换显示与隐藏]
         */
        function showMsg() {
            var id = $(this).data('id'),
                $this = $(this),
                $cont = $(this).parents('.itme').find('.cont');

            if ($cont.hasClass('txt')) {
                //已经获取过消息内容;
                $cont.toggleClass('show');
            } else {
                //未获取过消息内容;
                $.ajax({
                    type: "POST",
                    url: '/message/content_message',
                    dataType: 'json',
                    data: {
                        'msg_id': id
                    },
                    success: function(data) {
                        if (data.success) {
                            $cont.html(data.data).addClass('txt show'); 
                        } else {
                            alert(data.data); //失败时提示
                        }
                    }
                });
            };
        };
        //   /message/del_all_message 

        $('#J_all_del').on('click', delAllMsg);
        /**
         * [delAllMsg 批量删除消息]
         * @return {[type]} [返回成功与否]
         */
        function delAllMsg() {
            var arr = [];
            $('.J-checkbox').each(function(i) {
                if ($(this).prop("checked")) {
                    arr.push($(this).data('id'))
                };
            });
            if (arr.length == 0) {
                return false;
            }
            var bool = confirm('确定删除该消息吗？');
            if (bool) {
                $.ajax({
                    type: "POST",
                    url: '/message/del_all_message',
                    dataType: 'json',
                    data: {
                        'msg_id': arr
                    },
                    success: function(data) {
                        if (data.success) {//删除成功提示并刷新页面
                            alert(data.data);
                            window.location.reload();
                        } else {
                            alert(data.data); //失败时提示
                        };
                    }
                });
            };
        }; 

        //全选
        $("#J_all").checkAll("input[type=checkbox]");

    };

    exports.init();
})
seajs.use('goodsList');