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
 * 众宝贝-添加(修改)商品-添加商品规格-JS
 * @author jon
 * @email 191777962@qq.com
 */
define(function(require, exports, module) {

    var $ = require("jquery");

    var editType = function(op) {
        var c = $.extend({
            Box: '#provice', //可编辑box
            cBox: '#city' // 展示不可编辑box
        }, op);

        var $Box = $(c.Box), //主要box
            $cBox = $(c.cBox), //展示不可编辑box
            $addL = $(c.Box).find('.addL'), //添加列btn
            $subL = $(c.Box).find('.subL'), //减少列btn
            $addH = $(c.Box).find('.addH'), //添加行btn
            $subH = $(c.Box).find('.subH'), //减少行btn
            $save = $(c.Box).find('.J_save'); //保存btn

        function addL() {
            //添加商品规格 -列
            var _int = $Box.find('.t-tt .pro li').length;
            if (_int < 6) {
                //表头
                var TTstr = '<li><input type="text" class="m-txt J-txt" name="spec_n[]" value=""></li>';
                $Box.find('.t-tt .pro ul').append(TTstr);
                //表身
                var MNstr = '<li><input type="text" class="m-txt J-txt" name="spec_v_' + _int + '[]" value=""></li>';
                $Box.find('.mn .pro ul').append(MNstr);
            }
        };

        function subL() {
            //减少商品规格 -列
            $Box.find('.pro li:last-child').remove();
        };

        function addH() {
            //添加商品参数 -行
            var html = $Box.find('.list:last-child').clone();
            html.find('.J-txt').val('');
            html.find('.J_sku').attr('name', 'new_sku[]').val(''); //原有数据的修改 
            html.find('.pro .J-txt').attr('readonly', false); //修改只读为假
            html.find('.pro').removeClass('readonly'); //移除class 
            html.appendTo($Box.find('.mn'));
        };

        function subH() {
            //减少商品参数 -行
            if ($Box.find('.list').length <= 1) {
                return false;
            }
            $Box.find('.list:last-child').remove();
        };

        function check() {
            //检测整个商品填写
            var arr = [];
            $Box.find('.t-tt .pro .J-txt').each(function() {
                arr.push($.trim($(this).val()));
            });
            if (isRepeat(arr)) {
                alert('商品属性不能为空且不能重复！');
                return false;
            };
            if (leakage()) {
                alert('商品规格不能为空!');
                return false;
            };
            save();
        };

        function isRepeat(arr) {
            //检测数组是否有重复 有重复或数组值为'' 时返回true
            //用于检测商品 规格名
            var hash = {};
            for (var i in arr) {
                if (hash[arr[i]] || arr[i] == '') {
                    return true;
                };
                hash[arr[i]] = true;
            };
            return false;
        };

        function leakage() {
            //检测商品规格是否填写完，如没填写完 返回true
            var bool = false;
            $Box.find('.J-txt').each(function() {
                if ($.trim($(this).val()) == '') {
                    bool = true;
                };
            });
            return bool;
        };

        function save() {
            //保存显示编辑结果
            $cBox.html('');
            var html = $Box.find('.cont').clone();
            html.find('.m-txt').attr('readonly', true);
            html.find('.ft').remove();
            html.appendTo($cBox);
        };

        function remove() {
            var i = $(this).parents('.mn').find('.list').length;
            if (i > 1) {
                $(this).parents('.list').remove();
            }else{
                alert('商品规格条数不能少于一条！'); 
            }
        };

        $addL.on('click', addL);
        $subH.on('click', subH);
        $addH.on('click', addH);
        $subL.on('click', subL);
        $save.on('click', check);
        $('body').on('click', '.op', remove);
    };


    module.exports = editType;
})