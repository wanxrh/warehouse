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
 * 注册页面验证-JS
 * @author 郭朝俊
 * @email 191777962@qq.com
 * 添加修改 冯丽秋 
 *入驻开店跳转链接
 */
define('reg', function(require, exports, module) {
    //引入JQ
    var $ = require("jquery");
    //引入 passwordStrength-min
    var global = require("global");
    exports.init = function() {
        global.cnzz(); //站长统计
        //注册
        var $name = $("#un"),
            $psw = $("#pws"),
            $Rpsw = $("#rpws"),
            $vcode = $("#vcode"),
            $phone = $("#phone"),
            $pcode = $("#pcode"),
            $p_btn = $('.p_btn'),
            $J_reg = $('#J_reg');

        var reg = {
            _name: false,
            _psw: false,
            _rpsw: false,
            _vcode: false,
            bool: true, // ajax 只能提交一次
            Error: function($obj, msg) {
                $obj.focus().addClass('error').removeClass('right');
                $('#J_reg_tips').text(msg).show();
            },
            Rigth: function($obj) {
                $obj.addClass('right').removeClass('error');
                $('#J_reg_tips').text('').hide();
            },
            countdown: function(obj, time, str) {
                obj.text(time + str);
                var countdownTimer = setInterval(function() {
                    if (--time > 0) {
                        obj.text(time + str);
                    } else {
                        clearInterval(countdownTimer);
                        obj
                            .text('重新发送')
                            .removeClass('disabled')
                            .parent().addClass('btnWrap');
                    };
                }, 1000);
            },
            testPSW: function() {
                //用户名与密码相同
                if ($psw.val() == $name.val() && $psw.val() != "") {
                    reg._psw = false;
                    var msg = '用户名和密码不能相同！';
                    reg.Error($(this), msg);
                    return false;
                };
                //密码验证
                var exp = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z_]{6,20}$/;
                if (exp.test($psw.val()) != true) {
                    reg._psw = false;
                    var msg = '密码为6-20个字符，请用英文加数字或下划线组合！';
                    reg.Error($(this), msg)
                    return false;
                } else if (exp.test($psw.val()) != false && $Rpsw.val() == '') {
                    reg._psw = true;
                    return false;
                };
                //两次密码匹配验证
                if ($psw.val() != $Rpsw.val() && $psw.val() != "" && $Rpsw.val() != "") {
                    reg._psw = false;
                    var msg = '输入的密码不一致！';
                    reg.Error($(this), msg);
                    return false;
                };
                //密码正确
                if ($psw.val() == $Rpsw.val() && $psw.val() != $name.val() && $psw.val() != "") {
                    reg._psw = true;
                    reg._rpsw = true;
                    reg.Rigth($(this));
                    return false;
                };
            },
            testName: function() {
                var _this = $(this),
                    exp = /^(?!.*\d{5,6})[a-zA-Z_\u4e00-\u9fa5\d+)]{6,50}$/;
                if (exp.test(_this.val()) != true) {
                    reg._name = false;
                    var msg = '请输入6-50位非连续字符，支持中文数字及“_”组合。';
                    reg.Error(_this, msg);
                    return false;
                };
                $.post("/reg/check_username", {
                    "uname": $(this).val()
                }, function(data) {
                    if (data.code == "200") {
                        reg._name = true;
                        reg.Rigth(_this);
                    } else {
                        reg._name = false;
                        reg.Error(_this, data.data);
                    };
                }, 'json');
            },
            testVcode: function() {
                var _this = $(this);
                $.post("/reg/check_vcode", {
                        "vcode": $(this).val()
                    },
                    function(data) {
                        if (data.code == "200") {
                            reg._vcode = true;
                            reg.Rigth(_this);
                        } else {
                            reg._vcode = false;
                            reg.Error(_this, data.data);
                        }
                    }, "json");
            },
            testPhnoe: function() {
                var _val = $(this).val(),
                    _this = $(this);
                if (!global.isPhoen(_val)) {
                    var msg = '请输入正确的手机号！';
                    reg.Error($phone, msg);
                    return false;
                };
                $p_btn.attr('disabled', true);
                $.post("/reg/check_mobile", {
                        "mobile": _val
                    },
                    function(data) {
                        if (data.code == "200") {
                            //手机可用
                            $p_btn
                                .attr('disabled', false)
                                .removeClass("btn-Disable");
                            reg.Rigth(_this);
                        } else { //
                            //不可用
                            reg.Error($phone, data.data);
                            $p_btn
                                .attr('disabled', true)
                                .addClass("btn-Disable");
                        };
                    }, "json");
            },
            sendCode: function() {
                var mobile = $phone.val();
                if (!global.isPhoen(mobile)) {
                    return false;
                };
                $.post(" /reg/get_mobile_code", {
                        "mobile": mobile
                    },
                    function(datas) {
                        if (datas.code == '200') {
                            $p_btn.attr({
                                'value': '发送中...',
                                'disabled': 'disabled'
                            });
                            reg.countdown($p_btn, 60, '秒后可重新发送');
                            return true;
                        }
                    }, "json");
            },
            testCode: function() {
                var mobile = $phone.val(),
                    code = $(this).val(),
                    _this = $(this);
                //手机格式不对则跳出
                if (!global.isPhoen(mobile)) {
                    return false;
                };

                $.post("/reg/check_mobile_code", {
                        "mobile": mobile,
                        "code": code
                    },
                    function(data) {
                        if (data.code != '200') {
                            $J_reg
                                .attr('disabled', true)
                                .addClass("btn-Disable");
                            reg.Error(_this, data.data);
                        } else {
                            $J_reg
                                .attr('disabled', false)
                                .removeClass("btn-Disable");
                            reg.Rigth(_this);
                        };
                    }, "json");
            },
            subAjax: function() {
                if (reg.bool != true) { //防止恶意多次提交
                    return false;
                };

                //检测是否各该填项已填写正确
                if (reg._name != true) {
                    var msg = '用户名为6-50位非连续字符，支持中文数字及“_”组合。';
                    reg.Error($name, msg);
                    return false;
                };

                if (reg._psw != true) {
                    var msg = '密码为6-20个字符，请用英文加数字或下划线组合！';
                    reg.Error($psw, msg);
                    return false;
                };

                if (reg._rpsw != true) {
                    var msg = '密码为6-20个字符，请用英文加数字或下划线组合！';
                    reg.Error($Rpsw, msg);
                    return false;
                };

                if (reg._vcode != true) {
                    var msg = '验证码错误或不能为空！';
                    reg.Error($vcode, msg);
                    return false;
                };
                reg.bool = false;
                $.post("/reg/save", {
                        "uname": $name.val(),
                        "password": $psw.val(),
                        "a_password": $Rpsw.val(),
                        "vcode": $vcode.val(),
                        "mobile": $phone.val(),
                        "code": $pcode.val()
                    },
                    function(data) {
                        if (data.code == "200") {
                            window.location.href = data.to;
                        } else {
                            reg.Error(null, data.data);
                        }
                    }, "json");
            },
            init: function() {
                $name.on('change', reg.testName);
                $psw.on('change', reg.testPSW);
                $Rpsw.on('change', reg.testPSW);
                $phone.on('change', reg.testPhnoe);
                $vcode.on('change', reg.testVcode);
                $p_btn.on('click', reg.sendCode);
                $pcode.on('change', reg.testCode);
                $J_reg.on('click', reg.subAjax);
                $('.m-txt').on('focus', function() {
                    $(this).removeClass("error");
                })
            }
        };
        reg.init();

        //登录
        function userLogin() {
            var $un = $("#d_un"),
                $pw = $("#d_pw"),
                $tips = $("#J_tips");
            if ($un.val() == '' || $pw.val() == '') {
                $tips.html("用户名或密码不能为空！").show();
                return false;
            } else {
                $.post('/login', {
                        username: $un.val(),
                        password: $pw.val()
                    },
                    function(data) {
                        if (data.code == "200") { //success
                            window.location.href = data.to;
                        } else {
                            $tips
                                .html(data.data)
                                .show();
                            $un
                                .focus()
                                .addClass("error");
                        };
                    }, "json");
            };
            return false;
        };

        $('body').on('click', '#J_log', userLogin);


        //弹出层操作
        var pops = {
            show: function() {
                $('#J_make,#J_pop').show();
            },
            hide: function() {
                $('#J_make,#J_pop').hide();
            },
            tab: function() {
                var index = $(this).index(),
                    lastIndex = $('#J_tab li').filter('.z-crt').index();

                $('#J_tab li').eq(lastIndex).removeClass('z-crt');
                $('#J_tab li').eq(index).addClass('z-crt');
                $('#J_tab_ct ul').eq(lastIndex).hide();
                $('#J_tab_ct ul').eq(index).show();

                //根据内容适应屏幕所在高度
                var h = $('#J_pop').innerHeight();
                $('#J_pop').css('margin-top', -(h / 2 - 40));
            },
            init: function() {
                $('body').on('click', '#J_pop .colse', pops.hide);
                $('body').on('click', '#J_tab li', pops.tab);
            }
        };
        pops.init();

        //点击入驻开店

        $('body').on('click', '#J_dld,#J_rz,#J_ent', enter);
        /**
         * [enter 判断用户是否已经登录]
         * @return {[type]} [已登录则跳转至商家中心，没登录则弹出登录窗]
         */
        function enter() {
            var $this = $(this)
            var url = $this.data("url");
            $.post("/home/check_login",
                function(data) {
                    if (data.success == true) {  
                        window.location.href = data.data.url;                     
                    } else {
                        pops.show();                     
                    }
                }, "json");
        };

    };
    exports.init();  
});
seajs.use('reg');