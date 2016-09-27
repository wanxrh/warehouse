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
 * 商家中心的会员上传头像
 * 账户余额的请求查看和隐藏
 * @author 冯丽秋
 * @email 3304518291@qq.com
 */
define('index', function(require, exports, module) {
    var $ = require("jquery");
    var uploadPreview = require("uploadPreview"); //调用插件

    exports.init = function() {

        new uploadPreview({
            UpBtn: "up_img", //选择文件控件ID;
            DivShow: "imgdiv", //DIV控件ID;
            ImgShow: "imgShow" //图片控件ID;
        });   
        //添加点击事件
        $(".submitd").on("click", submit);

        function submit() {

            if ($("#up_img").val()) {

                $('#J_form').submit(); //触发form表单submit()事件
            }
        }; 
          

        //添加账户余额的查看事件
        $("#J_showMoney").on("click", showMoney);

        function showMoney() {
            var self = $(this); //保存当前对象指针，ajax内无法获取对象
            var isShow = self.data('shw');

            if (isShow == 0) {

                $.ajax({
                    url: 'myinfo/member_ajax', //接口
                    type: 'GET', //类型get--单纯获取
                    data: {},
                    dataType: 'json',  
                    
                    //成功后执行的方法
                    success: function(res) { 

                        //如果不成功则弹出窗
                        if (!res.success) {
                            alert('报错了'); 
                            return false;
                        }
                        //成功的话则执行此方法
                        self.html("[隐藏]").data('shw', 1);
                        $('.price').html('￥' + res.data).show();
                        $('.hide').hide();
                    }
                })

            } else {

                $('.price').hide();
                $('.hide').show();
                self.html("[显示]").data('shw', 0);
            }

        }
    };

    exports.init();
})
seajs.use('index');