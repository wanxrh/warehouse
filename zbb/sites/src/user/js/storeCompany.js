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
 * 众宝贝-企业信息填写-JS
 * @author jon
 * @email 191777962@qq.com
 */
define('storeCompany', function(require, exports, module) {
    var $ = require('jquery');
    var global = require('global');
    exports.init = function() {

        var $uname = $('[name=uname]'), //申请人姓名
            $email = $('[name=email]'), //申请人邮箱
            $mobile = $('[name=mobile]'), //申请人手机
            $corporation = $('[name=corporation]'), //身份证姓名
            $id_card = $('[name=id_card]'), //法人身份证号码
            $img_1 = $('[name=card_img_1]'), //图片正面
            $img_2 = $('[name=card_img_2]'); //法人身份证背面

        //邮箱验证
        $email.on('blur', function() {
            if (!global.isEmail($(this).val())) {
                alert('请输入正确的电子邮箱地址！');
            };
        });
        //手机验证
        $mobile.on('blur', function() {
            if (!global.isPhoen($(this).val())) {
                alert('请输入正确的手机号码！');
            };
        });
        //身份证验证
        $id_card.on('blur', function() {
            if (!global.isCardID($(this).val())) {
                alert('请输入正确的身份证号码！');
            };
        });



        /**
         * [next 下一步]
         * @return {Function} [无返回]
         */
        function next() {
            if ($.trim($uname.val()) == '') {
                alert('请输入申请人姓名！');
                return false
            };
            if ($.trim($email.val()) == '' || !global.isEmail($email.val())) {
                alert('请输入正确的电子邮箱地址！');
                return false
            };
            if ($.trim($mobile.val()) == '' || !global.isPhoen($mobile.val())) {
                alert('请输入正确的手机号码！');
                return false
            };
            if ($.trim($corporation.val()) == '') {
                alert('请输入身份证所有人姓名！');
                return false
            };
            if ($.trim($id_card.val()) == '' || !global.isCardID($id_card.val())) {
                alert('请输入正确的身份证号码！');
                return false
            };
            if ($.trim($img_1.val()) == '' || $.trim($img_2.val()) == '') {
                alert('请上传身份证证件图片文件！');
                return false
            };

            $('#J_form').submit();
        };

        //$('#J_pre').on('click', prev);
        $('#J_next').on('click', next);

    };

    exports.init();
});
seajs.use('storeCompany')