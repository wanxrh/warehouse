define("ybglobal",["jquery"],function(require,exports,module){var $=require("jquery"),e=window.location.href.split(".")[1],t={};t.domain_www="http://www."+e+".com/",t.user_url="http://user."+e+".com/",t.help_url="http://help."+e+".com/",t.static_url="http://static."+e+".com/",t.img_url="http://img."+e+".com/",t.cookie=function(e,t,n){if("undefined"==typeof t){var i=null;if(document.cookie&&""!=document.cookie)for(var a=document.cookie.split(";"),o=0;o<a.length;o++){var r=$.trim(a[o]);if(r.substring(0,e.length+1)==e+"="){i=decodeURIComponent(r.substring(e.length+1));break}}return i}n=n||{},null===t&&(t="",n=$.extend({},n),n.expires=-1);var s="";if(n.expires&&("number"==typeof n.expires||n.expires.toUTCString)){var u;"number"==typeof n.expires?(u=new Date,u.setTime(u.getTime()+24*n.expires*60*60*1e3)):u=n.expires,s="; expires="+u.toUTCString()}var c=n.path?"; path="+n.path:"",l=n.domain?"; domain="+n.domain:"",d=n.secure?"; secure":"";document.cookie=[e,"=",encodeURIComponent(t),s,c,l,d].join("")},t.loadCSS=function(e){var t=document.createElement("link");t.rel="stylesheet",t.type="text/css",t.href=e,document.getElementsByTagName("head")[0].appendChild(t)},t.isPhoen=function(e){var t=/^1[3|4|5|7|8][0-9]\d{8}$/;return t.test(e)},t.isCardID=function(e){var t=/(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;return t.test(e)},t.isTel=function(e){var t=/^([0|4\+]\d{2,3}[—]?-)?(0|8\d{2,3}-)?(\d{4,8})(-\d{1,4})?$/;return t.test(e)},t.isEmail=function(e){var t=/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;return t.test(e)},t.iszip=function(e){var t=/^\d{6}$/;return t.test(e)},t.cart=function(){var e=this.info()||"";""!=e&&$.ajax({url:t.cart_url+"/cart_count",type:"post",dataType:"jsonp",beforeSend:function(){$("#num_txt").html("0")},success:function(e){$("#num_txt").html(e.data)}})},t.message=function(){var e=this.info()||"";""!=e&&$.ajax({url:t.domain_www+"home/user_stat?"+(new Date).getTime(),type:"post",dataType:"jsonp",beforeSend:function(){$("#unread1").html()},success:function(e){$("#unread1").html(e.unread)}})},t.info=function(){var e=this.cookie("NZW_YZ");if(!e||2!=e.split("|").length)return null;var t=e.split("|");return{name:t[0],type:t[1]}},t.toTop=function(){var e=function(e,t,n){var i=$(e).click(function(){return $("body,html").animate({scrollTop:0},n),!1}),a=$(window),o=1140;a.width()>=o&&$(this).scroll(function(){$(this).scrollTop()>t?i.fadeIn(n):i.fadeOut(n)})};$('<a id="backToTop" title="回到顶部" target="_self" href="javascript:;"><i>回到顶部</i><span class="I-ico">&#xe713;</span></a>').appendTo("body"),e("#backToTop",500,300)},t.browserIE6_8=function(){var e=/msie 6/i.test(navigator.userAgent),t=/msie 7/i.test(navigator.userAgent),n=/msie 8/i.test(navigator.userAgent);/msie 9/i.test(navigator.userAgent);return!!(e||t||n)},t.cnzz=function(){var e=document.createElement("script");e.src="http://s11.cnzz.com/z_stat.php?id=1257124587&web_id=1257124587";var t=document.getElementsByTagName("body")[0];t.appendChild(e,t)},module.exports=t}),define("search",[],function(require,exports,module){var e=document,t=e.getElementsByTagName("input"),n="placeholder"in e.createElement("input"),i=function(e){var t=e.getAttribute("placeholder"),n=e.defaultValue;""==n&&(e.value=t),e.onfocus=function(){e.value===t&&(this.value="")},e.onblur=function(){""===e.value&&(this.value=t)}};if(!n)for(var a=0,o=t.length;a<o;a++){var r=t[a],s=r.getAttribute("placeholder");"text"===r.type&&s&&i(r)}}),define("help",["jquery","ybglobal","search"],function(require,exports,module){var $=require("jquery"),e=require("ybglobal");require("search"),exports.init=function(){e.cnzz(),1==e.browserIE6_8()&&require.async("ybadaptive")($);var t="/"+window.location.href.split("/")[3];$("#J_sideMenu a").each(function(e,n){var i=$(this).attr("href");i==t&&$(this).addClass("z-crt")});var n=$(".subtt h2");n.hover(function(e){$(this).addClass("hover")},function(){$(this).removeClass("hover")}),n.click(function(e){$(this).toggleClass("tt-bgc"),$(this).next("ul").slideToggle("slow")}),$(".subtt li").click(function(e){$(".subtt li").removeClass("menufc"),$(this).addClass("menufc")})},exports.init()}),seajs.use("help");