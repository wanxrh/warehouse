define("ybglobal",["jquery"],function(require,exports,module){var $=require("jquery"),t=window.location.href.split(".")[1],o={};o.domain_www="http://www."+t+".com/",o.user_url="http://user."+t+".com/",o.help_url="http://help."+t+".com/",o.static_url="http://static."+t+".com/",o.img_url="http://img."+t+".com/",o.cookie=function(t,o,e){if("undefined"==typeof o){var i=null;if(document.cookie&&""!=document.cookie)for(var n=document.cookie.split(";"),s=0;s<n.length;s++){var r=$.trim(n[s]);if(r.substring(0,t.length+1)==t+"="){i=decodeURIComponent(r.substring(t.length+1));break}}return i}e=e||{},null===o&&(o="",e=$.extend({},e),e.expires=-1);var a="";if(e.expires&&("number"==typeof e.expires||e.expires.toUTCString)){var c;"number"==typeof e.expires?(c=new Date,c.setTime(c.getTime()+24*e.expires*60*60*1e3)):c=e.expires,a="; expires="+c.toUTCString()}var d=e.path?"; path="+e.path:"",l=e.domain?"; domain="+e.domain:"",u=e.secure?"; secure":"";document.cookie=[t,"=",encodeURIComponent(o),a,d,l,u].join("")},o.loadCSS=function(t){var o=document.createElement("link");o.rel="stylesheet",o.type="text/css",o.href=t,document.getElementsByTagName("head")[0].appendChild(o)},o.isPhoen=function(t){var o=/^1[3|4|5|7|8][0-9]\d{8}$/;return o.test(t)},o.isCardID=function(t){var o=/(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;return o.test(t)},o.isTel=function(t){var o=/^([0|4\+]\d{2,3}[—]?-)?(0|8\d{2,3}-)?(\d{4,8})(-\d{1,4})?$/;return o.test(t)},o.isEmail=function(t){var o=/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;return o.test(t)},o.iszip=function(t){var o=/^\d{6}$/;return o.test(t)},o.cart=function(){var t=this.info()||"";""!=t&&$.ajax({url:o.cart_url+"/cart_count",type:"post",dataType:"jsonp",beforeSend:function(){$("#num_txt").html("0")},success:function(t){$("#num_txt").html(t.data)}})},o.message=function(){var t=this.info()||"";""!=t&&$.ajax({url:o.domain_www+"home/user_stat?"+(new Date).getTime(),type:"post",dataType:"jsonp",beforeSend:function(){$("#unread1").html()},success:function(t){$("#unread1").html(t.unread)}})},o.info=function(){var t=this.cookie("NZW_YZ");if(!t||2!=t.split("|").length)return null;var o=t.split("|");return{name:o[0],type:o[1]}},o.toTop=function(){var t=function(t,o,e){var i=$(t).click(function(){return $("body,html").animate({scrollTop:0},e),!1}),n=$(window),s=1140;n.width()>=s&&$(this).scroll(function(){$(this).scrollTop()>o?i.fadeIn(e):i.fadeOut(e)})};$('<a id="backToTop" title="回到顶部" target="_self" href="javascript:;"><i>回到顶部</i><span class="I-ico">&#xe713;</span></a>').appendTo("body"),t("#backToTop",500,300)},o.browserIE6_8=function(){var t=/msie 6/i.test(navigator.userAgent),o=/msie 7/i.test(navigator.userAgent),e=/msie 8/i.test(navigator.userAgent);/msie 9/i.test(navigator.userAgent);return!!(t||o||e)},o.cnzz=function(){var t=document.createElement("script");t.src="http://s11.cnzz.com/z_stat.php?id=1257124587&web_id=1257124587";var o=document.getElementsByTagName("body")[0];o.appendChild(t,o)},module.exports=o}),define("jquery.scroll.loading",["jquery"],function(require,exports,module){require("jquery");!function(t){t.fn.scrollLoading=function(o){var e={attr:"data-url",container:t(window),callback:t.noop},i=t.extend({},e,o||{});i.cache=[],t(this).each(function(){var o=this.nodeName.toLowerCase(),e=t(this).attr(i.attr),n={obj:t(this),tag:o,url:e};i.cache.push(n)});var n=function(o){t.isFunction(i.callback)&&i.callback.call(o.get(0))},s=function(){var o=i.container.height();t(window).get(0)===window?contop=t(window).scrollTop():contop=i.container.offset().top,t.each(i.cache,function(t,e){var i,s,r=e.obj,a=e.tag,c=e.url;r&&(i=r.offset().top-contop,i+r.height(),(i>=0&&i<o||s>0&&s<=o)&&(c?"img"===a?n(r.attr("src",c)):r.load(c,{},function(){n(r)}):n(r),e.obj=null))})};s(),i.container.bind("scroll",s)}}(jQuery)}),define("jqueryzoom",[],function(require,exports,t){return function(t){function o(t){this.x=t.pageX,this.y=t.pageY}!function($){$.fn.jqueryzoom=function(e){var i={xzoom:200,yzoom:200,offset:10,position:"right",lens:1,preload:1};e&&$.extend(i,e);var n="";$(this).hover(function(){var t=$(this).parents();t.each(function(){"relative"==$(this).css("position")&&($(this).css("position","static"),$(this).attr("ectype","jqzoom_relative"))});var e=this.offsetLeft,s=(this.offsetRight,$(this).get(0).offsetTop),r=$(this).children("img").get(0).offsetWidth,a=$(this).children("img").get(0).offsetHeight;n=$(this).children("img").attr("alt");var c=$(this).children("img").attr("jqimg");$(this).children("img").attr("alt",""),0==$("div.zoomdiv").get().length&&($(this).after("<div class='zoomdiv'><img class='bigimg' src='"+c+"'/></div>"),$(this).append("<div class='jqZoomPup'>&nbsp;</div>")),"right"==i.position?e+r+i.offset+i.xzoom>screen.width?leftpos=e-i.offset-i.xzoom:leftpos=e+r+i.offset:(leftpos=e-i.xzoom-i.offset,leftpos<0&&(leftpos=e+r+i.offset)),$("div.zoomdiv").css({top:s,left:leftpos}),$("div.zoomdiv").width(i.xzoom),$("div.zoomdiv").height(i.yzoom),$("div.zoomdiv").show(),i.lens||$(this).css("cursor","crosshair"),$(document.body).mousemove(function(t){mouse=new o(t);var n=$(".bigimg").get(0).offsetWidth,c=$(".bigimg").get(0).offsetHeight,d="x",l="y";if(isNaN(l)|isNaN(d)){var l=n/r,d=c/a,u=l<=1?r:i.xzoom/l,m=d<=1?a:i.yzoom/d;$("div.jqZoomPup").width(u),$("div.jqZoomPup").height(m),i.lens&&$("div.jqZoomPup").css("visibility","visible")}xpos=mouse.x-$("div.jqZoomPup").width()/2-e,ypos=mouse.y-$("div.jqZoomPup").height()/2-s,i.lens&&(xpos=mouse.x-$("div.jqZoomPup").width()/2<e?0:mouse.x+$("div.jqZoomPup").width()/2>r+e?r-$("div.jqZoomPup").width()-2:xpos,ypos=mouse.y-$("div.jqZoomPup").height()/2<s?0:mouse.y+$("div.jqZoomPup").height()/2>a+s?a-$("div.jqZoomPup").height()-2:ypos),i.lens&&$("div.jqZoomPup").css({top:ypos,left:xpos}),scrolly=ypos,$("div.zoomdiv").get(0).scrollTop=scrolly*d,scrollx=xpos,$("div.zoomdiv").get(0).scrollLeft=scrollx*l})},function(){var t=$(this).parents();t.each(function(){"jqzoom_relative"==$(this).attr("ectype")&&$(this).css("position","relative")}),$(this).children("img").attr("alt",n),$(document.body).unbind("mousemove"),i.lens&&$("div.jqZoomPup").remove(),$("div.zoomdiv").remove()}),count=0,i.preload&&($("body").append("<div style='display:none;' class='jqPreload"+count+"'></div>"),$(this).each(function(){var o=$(this).children("img").attr("jqimg"),e=t("div.jqPreload"+count).html();t("div.jqPreload"+count).html(e+'<img src="'+o+'">')}))}}(t)}}),define("main",["jquery","ybglobal","jqueryzoom","jquery.scroll.loading"],function(require,exports,module){var $=require("jquery"),t=require("ybglobal");require("jqueryzoom")($),require("jquery.scroll.loading"),exports.init=function(){function o(){return $("#J_make,#J_pop").show(),!1}function e(){$("#J_make,#J_pop").hide()}function i(){$(this).siblings().removeClass("pic_hover"),$(this).addClass("pic_hover");var t=$(this).children("img").data("src"),o=$(this).children("img").data("img");$(".jqzoom img").attr({src:t,jqimg:o})}1==t.browserIE6_8()&&require.async("ybadaptive")($),t.cnzz(),$(".j_ImgLoad").find("img").scrollLoading(),$("#J_op,.m-sd .m-tt").on("click",o),$("#J_pop .colse").on("click",e),$(".jqzoom").jqueryzoom({xzoom:430,yzoom:300});var n=$(".pic_move");n.find("li").on("mouseover",i)},exports.init()}),seajs.use("main");