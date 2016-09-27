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
* yiban全局-JS
* @author jon
* @email 191777962@qq.com
*/

define(function(require, exports, module) {
      var $ = require("jquery");
      var _url = window.location.href.split('.')[1];
      var mod = {};
      
      mod.domain_www = "http://www." + _url + ".com/";
      mod.user_url = "http://user." + _url + ".com/";
      mod.help_url = "http://help." + _url + ".com/";
      mod.static_url = "http://static." + _url + ".com/";
      mod.img_url="http://img." + _url + ".com/";
      //cookie 设置
      mod.cookie = function(name, value, options) {
            if (typeof value != 'undefined') {
                  options = options || {};
                  if (value === null) {
                        value = '';
                        options = $.extend({}, options);
                        options.expires = -1;
                  }
                  var expires = '';
                  if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {
                        var date;
                        if (typeof options.expires == 'number') {
                              date = new Date();
                              date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
                              //date.setTime(date.getTime() + (options.expires * 30 * 60 * 1000));
                        } else {
                              date = options.expires;
                        }
                        expires = '; expires=' + date.toUTCString();
                  }
                  var path = options.path ? '; path=' + (options.path) : '';
                  var domain = options.domain ? '; domain=' + (options.domain) : '';
                  var secure = options.secure ? '; secure' : '';
                  document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
            } else {
                  var cookieValue = null;
                  if (document.cookie && document.cookie != '') {
                        var cookies = document.cookie.split(';');
                        for (var i = 0; i < cookies.length; i++) {
                              var cookie = $.trim(cookies[i]);
                              if (cookie.substring(0, name.length + 1) == (name + '=')) {
                                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                                    break;
                              }
                        }
                  }
                  return cookieValue;
            }
      };

      //添加CSS
      mod.loadCSS=function (url){
            var link = document.createElement('link');
            link.rel = "stylesheet";
            link.type = "text/css";
            link.href = url;
            document.getElementsByTagName("head")[0].appendChild(link);
      };

      //手机号码检测；
      mod.isPhoen = function(argument) { 
            var reg = /^1[3|4|5|7|8][0-9]\d{8}$/;
            return reg.test(argument);
      };

      //身份证检测
      mod.isCardID = function(argument) { 
            var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/; 
            return reg.test(argument);
      };
      
      //电话号码检测；
      mod.isTel = function(argument) { 
            var reg = /^([0|4\+]\d{2,3}[—]?-)?(0|8\d{2,3}-)?(\d{4,8})(-\d{1,4})?$/;
            return reg.test(argument);
      };

      //Email检测；
      mod.isEmail = function(argument) {
            var reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
            return reg.test(argument);
      };

      //邮政编码检测；
      mod.iszip = function(argument) {
            var reg = /^\d{6}$/;
            return reg.test(argument);
      };

      //购物车数据
      mod.cart = function() {
            var user = this.info() || "";
            if (user != '') {
                  $.ajax({
                        url: mod.cart_url + "/cart_count",
                        type: 'post',
                        dataType: 'jsonp',
                        beforeSend: function(){
                              $("#num_txt").html('0');
                        },
                        success: function (data) {
                              $("#num_txt").html(data.data);
                              
                        }
                  });
            };
      };

      //我的消息数据
      mod.message = function() {
            var user = this.info() || "";
            if (user != '') {
                  $.ajax({
                        url: mod.domain_www + "home/user_stat?"+ (new Date()).getTime(),
                        type: 'post',
                        dataType: 'jsonp',
                        beforeSend: function(){
                              $("#unread1").html();
                        },
                        success: function (data) {
                              $("#unread1").html( data.unread);
                        }
                  });
            };
      };


      //cookie 解析
      mod.info=function() {
            var cookie = this.cookie('NZW_YZ');
            if (!cookie || cookie.split('|').length != 2) {
                  return null;
            }
            var info = cookie.split('|');
            return {
                  name: info[0],
                  type: info[1]
            };
      };

      //返回顶部
      mod.toTop = function() {
            
            var a = function(c, f, e) {
                  var d = $(c).click(function() {
                              $("body,html").animate({
                                    scrollTop: 0
                              }, e);
                              return false
                        }),
                        g = $(window),
                        b = 1140;
                  if (g.width() >= b) {
                        $(this).scroll(function() {
                              $(this).scrollTop() > f ? d.fadeIn(e) : d.fadeOut(e)
                        })
                  }
            };

            $('<a id="backToTop" title="\u56de\u5230\u9876\u90e8" target="_self" href="javascript:;"><i>回到顶部</i><span class="I-ico">&#xe713;</span></a>').appendTo("body");
            a("#backToTop", 500, 300);

      };

      //判断是否IE6-8
      mod.browserIE6_8 = function() {
            var isIE6 = /msie 6/i.test(navigator.userAgent);
            var isIE7 = /msie 7/i.test(navigator.userAgent);
            var isIE8 = /msie 8/i.test(navigator.userAgent);
            var isIE9 = /msie 9/i.test(navigator.userAgent);
            //var isIE = /msie /i.test(navigator.userAgent);
            if (isIE6 || isIE7 || isIE8) {
                return true;
            } else {
                return false;
            };

      };

      //站长统计
      mod.cnzz = function() {
            var hm = document.createElement("script");
            hm.src = "http://s11.cnzz.com/z_stat.php?id=1257124587&web_id=1257124587";
            var s = document.getElementsByTagName("body")[0];
            s.appendChild(hm, s);
      };

      module.exports = mod;
})