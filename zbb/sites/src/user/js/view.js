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
 * 订单详情，查看物流 修改物流单号
 * @author 冯丽秋
 * @email 3304518291@qq.com
 */
define('view', function(require, exports, module) {
    var $ = require('jquery');
    exports.init = function() {

        //添加点击查看物流事件
        $("#checkExp").on("click", checkExp);

        function checkExp() {
            var $this = $(this),
                val = $this.data("val"), //获取订单号
                isShow = $this.data('show'); //1为显示，0为收起
            if (isShow == 0) {
                $.ajax({
                    url: " /orders/get_express", //接口
                    type: "POST", //数据类型
                    dataType: "json",
                    data: {
                        'order_id': val
                    },
                    success: function(data) {
                        if (data.success) {
                            //改变内容和字体颜色还有show的值
                            $this.html("点击收起物流").css("color", "#00A63F").data('show', 1);

                            if (data.data.length == 0) { //判断是否有物流信息
                                var str = '<p class="triangle-t"></p>' + '<ul class="show_List"><li>此单号尚没有物流信息</li></ul>';
                                $("#show").html(str);
                            } else {
                                //遍历数据里面的数组
                                var html = '<p class="triangle-t"></p><ul class="show_List">';
                                $.each(data.data, function(i) { //i为索引个数 
                                    html += '<li><label>' + data.data[i].time + '</label>' + '<span>' + data.data[i].content + '</span></li>';
                                });
                                html += '</ul>';
                                //请求物流数据然后放到id=show里面
                                $("#show").html(html);
                            };
                        } else {
                            alert(data.data);
                        };
                    }
                })
            } else { //当isShow为1时执行下面的代码
                //改变内容和字体颜色还有show的值
                $this.html("点击查看物流").css("color", "#666").data('show', 0);
                $("#show").empty(); //清空物流的内容
            };

        };

        //修改订单号显示，隐藏
        function showInfo() {
            var _id = $(this).attr('id');
            if (_id == "EditBtn") { //判断如果点击的是修改按钮则:
                $("#editInfo").show();
                $("#logistics").hide();

            } else { //如果点击的是取消按钮则：
                $("#editInfo").hide();
                $("#logistics").show();
            };
        };
        $("#cancelBtn").on("click", showInfo); //点击取消按钮
        $("#EditBtn").on("click", showInfo); //点击修改按钮

        //点击确定修改订单
        $("#surelBtn").on("click", EditOrder);

        function EditOrder() {
            var order_id = $("#checkExp").data("val"), //订单号
                express_name = $("#select :selected").text(), //快递公司
                shipping_name = $("#select :selected").val(), //快递公司ID
                invoice_no = $("input[name='invoice_no']").val(); //快递单号


            //判断信息是否为空
            if (shipping_name == '0' || $.trim(invoice_no) == '' || isNaN(invoice_no)) {
                $("#editInfo").find('.msg-error').show();
                return false;
            } else {
                $("#editInfo").find('.msg-error').hide();
            };
            //用post方法传递数据
            $.post('/orders/express', { //路径
                    'order_id': order_id, //订单号
                    'express_name': express_name, //物流公司
                    'invoice_no': invoice_no //物流单号            
                },
                function(data) { //数据成功执行的代码
                    if (data.success) {
                        alert(data.data);
                        window.location.reload(); //刷新页面
                    } else {
                        alert(data.data);  
                    };

                }, "json");
        };

    };
    exports.init();
})
seajs.use("view");