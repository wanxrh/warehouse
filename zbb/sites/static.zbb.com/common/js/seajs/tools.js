/**
* Created by surging on 13-11-18.
* Function：验证字数，并显示当前字数
* Email：surging2@qq.com
* 修改 郭朝俊
*/
define(function(require,exports,module){
    String.prototype.len = function() {
        return this.replace(/[^\x00-\xff]/g, "aa").length;
    };
    var regGbk = new RegExp("[^\x00-\xff]");
    var SizeClew=function(element, max, index) {
        var id = "clewTip" + index;
        var objClew = document.getElementById(id);
        var len = element.value.len();
        if (objClew == null) {
            var parent = element.parentNode;
            var clew_box = document.createElement("span");
            clew_box.setAttribute("id", id);
            parent.appendChild(clew_box);
            objClew = document.getElementById(id);
        };
        if (len > max) {
            var arr = element.value.split("");
            var arrLen = arr.length;
            var num = 0;
            var index = 0;
            for (var i = 0; i < arrLen; i++) {
                if (num >= max) {
                    break;
                }
                if (regGbk.test(arr[i])) {
                    num += 2;
                    if (num >= max) {
                        break;
                    }
                } else {
                    num++;
                }
                index++;
            }
            element.value = element.value.substring(0, index);
            objClew.innerHTML = "<b id='inFont' style='color:#D80000;'>" + element.value.len() + "</b>/" + max;
        } else {
            objClew.innerHTML = "<b id='inFont' style='color:#139337;'>" + len + "</b>/" + max +"<span style='color:#999;padding-left:5px;font-size:12px;'>" + "字符" + "</span>";
        };
    };
    module.exports = SizeClew;
})
