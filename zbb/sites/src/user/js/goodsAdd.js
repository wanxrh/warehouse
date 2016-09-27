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
 * 众宝贝-添加(修改)商品-JS
 * @author jon
 * @email 191777962@qq.com
 */
define('goodsAdd', function(require, exports, module) {
    var $ = require('jquery');
    var dialog=require('z_dialog')
    var matchmoney = require("./common/js/seajs/matchmoney"); //自动补.00
    exports.init = function() {

        $('#J_A_type').on('change', changeAType);
        /**
         * [changeAType 宝贝分类]
         * @return {[type]} [返回该分类下的子分类]
         */
        function changeAType() {
            var id = $(this).val();
            $.ajax({
                type: "POST",
                url: '/store/get_cate',
                dataType: 'json',
                data: {
                    'parent_id': id
                },
                success: function(data) {
                    if (data.success) {
                        var html = '<option selected="selected" value="0">-- 请选择商品分类 --</option>';
                        $.each(data.data, function(i) {
                            html += '<option value="' + data.data[i].cate_id + '">' + data.data[i].cate_name + '</option>';
                        });
                        $('#J_A2_type').html(html).show();
                    };
                }
            });
        };

        $('#J_B_type').on('change', changeBType);
        /**
         * [changeAType 宝贝本店分类]
         * @return {[type]} [返回该分类下的子分类]
         */
        function changeBType() {
            var id = $(this).val();
            $.ajax({
                type: "POST",
                url: '/goods/shop_cate',
                dataType: 'json',
                data: {
                    'parent_id': id
                },
                success: function(data) {
                    if (data.success) {
                        var html = '<option selected="selected" value="0">-- 请选择商品分类 --</option>';
                        $.each(data.data, function(i) {
                            html += '<option value="' + data.data[i].cate_id + '">' + data.data[i].cate_name + '</option>';
                        });
                        $('#J_B2_type').html(html).attr('disabled', false).show();
                    } else {
                        $('#J_B2_type').attr('disabled', true).hide();
                    };
                }
            });
        };
       
        
        $('#J_add').on('click',goodsAdd);
         /**
          * [goodsAdd 查看修改商品规格]
          * @return {[type]} [无返回]
          */
        function goodsAdd(){
            var type=$(this).data('type');
            if (type) {//编辑原商品
                var opHtml = '';
            } else {//新增商品
                var opHtml = '<p class="mt"><button class="addL btn-txt"><span>+</span>添加新属性</button> <button class="subL btn-txt btn-green"><span>-</span>减少新的属性</button></p>';
            };
           
            require.async(['./user/js/editType'], function(editType) {
                var cont='<div class="cont">'
                        +    '<div class="t-tt clearfix">'
                        +       '<div class="pro">'
                        +           '<ul>'
                        +               '<li><input type="text" class="m-txt" name="spec_n[]" value=""></li>'
                        +               '<li><input type="text" class="m-txt" name="spec_n[]" value=""></li>'
                        +           '</ul>'                
                        +       '</div>'
                        +       '<div class="rigid">'
                        +           '<ul><li>原价</li><li>售价</li><li>库存</li><li class="num-width">货号</li><li>操作</li></ul>'
                        +        '</div>'
                        +    '</div>'
                        +    '<div class="mn">'
                        +        '<div class="list clearfix">' 
                        +            '<div class="pro">'
                        +                '<ul>'
                        +                   '<li><input type="text" class="m-txt J-txt" name="spec_v_0[]" value=""></li>'
                        +                   '<li><input type="text" class="m-txt J-txt" name="spec_v_1[]" value=""></li>' 
                        +                '</ul>'
                        +            '</div>'
                        +            '<div class="rigid">'
                        +                '<ul>'
                        +                    '<li><input type="text" class="m-txt J-txt J-money" name="cost_price[]" value=""></li>'
                        +                    '<li><input type="text" class="m-txt J-txt J-money" name="price[]" value=""></li>'
                        +                    '<li><input type="text" class="m-txt J-txt J-num" name="stock[]" value=""></li>'
                        +                    '<li class="num-width"><input type="text" class="m-txt num-width J-txt" name="sku[]" value=""></li>'
                        +                    '<li><span class="op">x</span></li>'
                        +                '</ul>'
                        +             '</div>'
                        +        '</div>'
                        +     '</div>'
                        +'</div>'; 

                var clone = $('#J_copy').find('.cont').length > 0 ? $('#J_copy').find('.cont').clone() : cont;

                var str = '<div id="box" class="popBox">'
                        +   '<div class="m-tt">编辑商品规格</div>'
                        +   '<div id="J_cont"></div>'              
                        +   '<div class="ft">'
                        +       opHtml
                        +       '<p class="mt"><button class="addH btn-txt"><span>+</span>增加新的一行</button> <button class="subH btn-txt btn-green"><span>-</span>减少一行</button></p>'
                        +       '<p class="f-tac"><button class="btn J_save">保存规格</button></p>'
                        +   '</div>'
                        + '</div>';

                var z_dialog = new dialog({
                    content: str
                });
                z_dialog.init();

                $('#J_cont').append(clone);

                $('#box rigid').find('.J-txt').attr('readonly', false);//解除只读

                //遍历属性项如含readonly样式 则为原有数据不可修改。如不含readonly样式则当次可修改数据
                $('#box').find('.pro').each(function(i) {
                    if (!$(this).hasClass("readonly")) {
                        $(this).find('.J-txt').attr('readonly', false);
                    };
                });

                editType({
                    Box: '#box', //可编辑box
                    cBox: '#J_copy' // 展示不可编辑box
                });

                $('#box').on('click', 'button', function() {
                    z_dialog.position();//重新定位弹出层
                });

                $('#box').on('click', '.J_save', function() {
                    z_dialog.remove();//移除弹出层
                });

                

                //库存只能输入数字
                $('body').on('keyup', '.J-num', function() {
                    this.value = this.value.replace(/\D/g, ''); 
                });
            });
        };

        $('#appbtn').on('click',appAjax);
        /**
         * [appAjax 添加商品验证并保存]
         * @return {[type]} [无返回值]
         */
        function appAjax() {
            var a = $("#J_A_type option:selected").val(),
                b = $("#J_A2_type option:selected").val(),
                c = $("#J_B_type option:selected").val(),
                d = $("#J_B2_type option:selected").val(),
                g_name = $.trim($('[name=goods_name]').val()),
                sku=$(this).data('sku'),
                spec = $('#J_copy').find('.cont').length;

            if (a == 0 || b == 0) {
                alert('请选择好宝贝分类！');
                return false;
            };
            if (c == 0) {
                alert('请选择好宝贝在本店的分类！');
                return false;
            };
            if ($("#J_B2_type").attr('disabled') == undefined && d == 0) {
                alert('请选择好宝贝在本店的分类！');
                return false;
            };
            if (g_name=='') {
                alert('请输入宝贝的商品名称！'); 
                return false;
            };
            if (sku > 0 && spec < 1) {
                alert('请输入宝贝的相关规格！'); 
                return false;
            };
            $('#myForm').submit(); 
        };

        $('body').matchmoney({
            obj:'.J-money' 
        }); //自动补.00 

    };

    exports.init();
});
seajs.use('goodsAdd');