define("goodsList",["jquery","common/js/seajs/cb_all"],function(require,exports,module){var $=require("jquery");require("common/js/seajs/cb_all"),exports.init=function(){function s(){var s=confirm("确定删除该消息吗？"),a=$(this).data("id"),t=$(this);s&&$.ajax({type:"POST",url:"/message/del_message",dataType:"json",data:{msg_id:a},success:function(s){s.success?t.parents(".itme").remove():alert(s.data)}})}function a(){var s=$(this).data("id"),a=($(this),$(this).parents(".itme").find(".cont"));a.hasClass("txt")?a.toggleClass("show"):$.ajax({type:"POST",url:"/message/content_message",dataType:"json",data:{msg_id:s},success:function(s){s.success?a.html(s.data).addClass("txt show"):alert(s.data)}})}function t(){var s=[];if($(".J-checkbox").each(function(a){$(this).prop("checked")&&s.push($(this).data("id"))}),0==s.length)return!1;var a=confirm("确定删除该消息吗？");a&&$.ajax({type:"POST",url:"/message/del_all_message",dataType:"json",data:{msg_id:s},success:function(s){s.success?(alert(s.data),window.location.reload()):alert(s.data)}})}$(".J_del").on("click",s),$(".J_info").on("click",a),$("#J_all_del").on("click",t),$("#J_all").checkAll("input[type=checkbox]")},exports.init()}),seajs.use("goodsList");