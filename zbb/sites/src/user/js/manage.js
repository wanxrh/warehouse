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
 * 店铺设置/数据的提交
 * @author 冯丽秋
 * @email 3304518291@qq.com
 */
define('manage', function(require, exports, module) {
    var $ = require("jquery");
    var citySelect = require('citySelect');
    var global = require("global");
    var uploadPreview = require("uploadPreview");
    exports.init = function() {
        //省市县三级连动 
        citySelect({
            provice: "#provice",
            city: "#city",
            dist: "#country",
            region_id: "#region_id",
            region_name: '#region_name',
            url: '/address/get_province'
        });
        //设置图片可见
        new uploadPreview({
            UpBtn: "up_img",
            DivShow: "imgdiv",
            ImgShow: "imgShow"
        });
        //添加提交点击事件
        $('body').on('click', '.btn', submit);

        function submit() {
            var name = $.trim($('#D_name').val()), //店铺名称
                region_id = $.trim($('#region_id').val()), //城市编码
                region_name = $('#region_name').val(), //城市
                addr = $.trim($('#address').val()), //详细地址
                phone = $.trim($('#tel').val()), //手机  
                qq = $.trim($('#im_qq').val()), //QQ
                ww = $.trim($('#im_ww').val()); //旺旺 

                //判断信息是否为空 
            if (region_id == '' || region_name == '') {
                alert('请填选择你的收获地址！');
                return false;
            };
               if (name == ''  ) {  
                alert('请填写您的店铺名称');
                return false;
            };
               if (addr == ''  ) {
                alert('请填写详细地址！');
                return false;  
            }; 
               if (qq  == ''  ) {
                alert('请填写正确的QQ号');
                return false;
            };
                if (ww  == ''  ) {
                alert('请填写正确的旺旺号');
                return false;
            };
                //判断手机号码
                   if (phone == ''  ) {
                alert('请填写您的手机号');
                return false;
             };
                 if (!global.isPhoen(phone)) {
                alert('请填写正确的手机号！');
                return false;
            };
                //选择跳转页面  
               $('#J_form').submit();//触发form表单submit()事件
        }

    };       
    exports.init();
})
seajs.use('manage');