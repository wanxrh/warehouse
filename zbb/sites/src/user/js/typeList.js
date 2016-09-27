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
 * 众宝贝-商品分类-JS
 * @author jon
 * @email 191777962@qq.com
 */
define('typeList',function(require, exports, module) {
    var $ = require("jquery");
    var dialog = require("z_dialog");
    exports.init = function() {

        /**
         * [add 添加商品分类]
         */
        function add() {
            var id = $(this).data('id') || 0, 
                str='<div class="popBox">'
                    +'<div class="m-tt">新增商品分类</div>' 
                    +'<ul>'
                    +    '<li><span class="tt">分类名称：</span><input type="text" class="txt" id="p_tt" placeholder="最多能输入10个字"></li>'
                    +    '<li><span class="tt">排序：</span><input type="text" class="txt" id="p_sort"></li>'
                    +    '<li><span class="tt">显示：</span><input type="radio" name="checkA" value="1" checked>是 　<input type="radio" name="checkA" value="0">否 </li>'
                    +'</ul>'
                    +'<div class="f-tac"><button class="btn" id="subBtn">提交</button></div>'
                +'</div>';
            showPOP(str, id);
        };
        $('.J_add').on('click', add);
        
        /**
         * [edit 修改商品分类]
         */
        function edit() {
            var lv = $(this).data('lv'),
                id = $(this).data('id'),
                pid = $(this).data('pid') || 0,
                $this = $(this);

            $.ajax({
                type:'POST',
                url:'/cate/cate_edit_ajax',
                dataType:'json',
                data:{
                    'id':id
                },
                success:function(data){
                    var ifshow = data.data.cate_info.if_show > 0 ? true : false;
                    if(ifshow){
                        var _show='<input type="radio" name="checkA" value="1" checked>是　<input type="radio" name="checkA" value="0">否';
                    }else{
                        var _show='<input type="radio" name="checkA" value="1">是　<input type="radio" name="checkA" value="0" checked>否';
                    };
                    var p_type='';
                    if (pid) {
                        var option='';
                        for (var i = data.data.top_cate.length - 1; i >= 0; i--) {
                            if (data.data.top_cate[i].cate_id == pid) {
                                option += '<option value="' + data.data.top_cate[i].cate_id + '" selected="selected">' + data.data.top_cate[i].cate_name + '</option>';
                            }else{
                                option += '<option value="' + data.data.top_cate[i].cate_id + '">' + data.data.top_cate[i].cate_name + '</option>';
                            }
                        };

                        p_type='<li id="p_type"><span class="tt">上级分类：</span><select id="J_pid" class="select">'+ option +'</select></li>';
                    }
                    
                    var str='<div class="popBox">'
                            +'<div class="m-tt">修改商品分类</div>'
                            +'<ul>'
                            +    '<li><span class="tt">分类名称：</span><input type="text" id="p_tt" class="txt" value="'+ data.data.cate_info.cate_name +'"></li>'
                            +    p_type
                            +    '<li><span class="tt">排序：</span><input type="text" class="txt" id="p_sort" value="'+ data.data.cate_info.sort_order +'"></li>'
                            +    '<li><span class="tt">显示：</span>'+ _show +'</li>'
                            +'</ul>'
                            +'<div class="f-tac"><button class="btn" id="editAjax">提交</button></div>'
                        +'</div>';
                    showPOP(str, id);
                }
            });
            
        };
        $('.J_edit').on('click', edit);
        
        /**
         * [del 删除商品分类]
         * @return {[type]} [无返回]
         */
        function del() {
            var id = $(this).data('id'),
                url = '/cate/cate_del',
                $this=$(this);
            $.ajax({
                type: "POST",
                url: url,
                dataType:'json',
                data: {
                    'id': id
                },
                success: function(data) {
                    if(data.success){
                        $this.parents('tr').remove();
                    }else{
                        var html='<div style="color:#666; font-size:18px; text-align: center"><span class="I-ico" style=" font-size:60px; color:#e83228;">&#xb607;</span> <p>'+ data.data +'</p></div>'
                        showPOP(html);
                    }
                }
            });
        };
        $('.J_del').on('click', del);

        /**
         * [showPOP description]
         * @param  {[type]} str [弹出层内容]
         * @param  {[type]} id  [当前分类的 ID]
         * @return {[type]}     [无返回]
         */
        function showPOP(str, id) {
            var z_dialog = new dialog({
                content: str,
            });
            z_dialog.init();

            $("body").on('keyup','#p_sort', function() {
                this.value = this.value.replace(/\D/g, ''); //只能输入数字
            });

            //防止点击一次，多次提交
            $("body").off("click", "#subBtn"); 
            $("body").off("click", "#editAjax"); 

            //新增
            $('body').on('click', '#subBtn', function subajax() {
                var cate_name = $.trim($('#p_tt').val()),
                    sort_order = $.trim($('#p_sort').val());
                if (cate_name == '' || sort_order == '') {
                    alert('请输入完信息！');
                    return false;
                }
                $.ajax({
                    type: "POST",
                    url: '/cate/cate_add',
                    dataType: 'json',
                    data: {
                        'id': id,
                        'cate_name': cate_name,
                        'sort_order': sort_order,
                        'show': $('[name=checkA]').filter(":checked").val()
                    },
                    success: function(data) {
                        if (data.success) {
                            alert('已经成功添加商品分类！');
                            window.location.reload();
                        } else {
                            alert(data.data);
                        }
                    }
                });
            });

            //修改
            $('body').on('click', '#editAjax', function subajax() {
                var cate_name = $.trim($('#p_tt').val()),
                    sort_order = $.trim($('#p_sort').val());
                if (cate_name == '' || sort_order == '') {
                    alert('请输入完信息！');
                    return false;
                }
                $.ajax({
                    type: "POST",
                    url: '/cate/cate_edit',
                    dataType: 'json',
                    data: {
                        'id': id,
                        'pid': $('#J_pid').val() || 0,
                        'cate_name': cate_name,
                        'sort_order': sort_order,
                        'show': $('[name=checkA]').filter(":checked").val()
                    },
                    success: function(data) {
                        if (data.success) {
                            alert('已经成功修改商品分类！');
                            window.location.reload();
                        } else {
                            alert(data.data);
                        }
                    }
                });
            });
        };

    };
    
    exports.init();
});
seajs.use('typeList');
