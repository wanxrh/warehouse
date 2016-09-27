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
 * 商家中心-全部宝贝管理
 * @author 冯丽秋
 * @email 3304518291@qq.com
 */
define('goodsList', function(require, exports, module) {
    var $ = require("jquery");
    require('./common/js/seajs/cb_all');
    exports.init = function() {
        /**
         * [goodsState 商品上下架状态改变]
         *批量上下架
         * @return {[type]} [无返回值]
         */
        $('.J_btn').on('click', goodsState); //批量上下架
        $('.box_btn').on('click', goodsState); //单个上下架 


        function goodsState() {
            var $this = $(this);
            var id = $this.parents('td').data('id');
            var isShow = $(this).data('isshow');
            var arr = []; //创建数组

            //判断是否为单个上下架

            if (id) { //判断id是否为ture来判断是否为单个上下架
                arr.push(id);

            } else { //如果为false判断为批量上下架
                $(".checkitem:checked").each(function() {
                    var val = $(this).val();
                    arr.push(val);
                })
            };
            //判断是否有选中的商品
            if (arr.length == 0) {
                return false; //如果没有选中则跳出循环
            }
            $.ajax({
                type: "POST",
                url: "/goods/up_goods",
                dataType: 'json',
                data: {
                    'goods_id': arr, //传递数组里面的id号
                    'if_show': isShow
                },
                success: function(data) {
                    if (data.success) { //成功后执行的代码

                        if ($this.hasClass("box_btn")) {
                            $this.toggleClass("close");
                            $this.data('isshow', isShow > 0 ? 0 : 1);//改变isShow的值
                        } else {
                            alert(data.data);
                            window.location.reload();
                        };
                    } else {
                        alert(data.data);
                    };

                }
            });
        };
        /** 
         * [del 删除商品事件]
         * @return {[type]} [返回是否删除成功]
         */
        $(".J_del").on("click", removed);

        function removed() {
            var arr = []; //创建数组 
            var $this = $(this);
            var id = $(this).data("id");
            //通过判断id是否为true来判断是否选了单条删除
            if (id) {
                arr.push(id);
            } else { //如果id为false则为批量删除
                //遍历所有选择的复选框      
                $(".checkitem:checked").each(function() {
                    var val = $(this).val();
                    //把遍历出来的id放入数组
                    arr.push(val);
                })

            } //判断是否有选中的商品
            if (arr.length == 0) {
                //没选中则跳出循环
                return false;
            }

            //选中了则弹出窗
            var del = confirm("确认删除商品信息吗？");

            if (!del) { //如果弹出窗为false则跳出循环
                return false;
            };
            $.ajax({
                type: "POST",
                url: "/goods/del_goods",
                dataType: "json",
                data: {
                    'goods_id': arr
                },
                success: function(data) {
                    if (data.success) {
                        alert(data.data);
                        window.location.reload();
                    } else {
                        alert(data.data);
                    }
                }
            });
        }
        //全选
        $("#all").checkAll("input[type=checkbox]");

    };

    exports.init();
})
seajs.use('goodsList');