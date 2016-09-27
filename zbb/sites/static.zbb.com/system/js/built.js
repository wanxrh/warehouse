;$(function() {


    //匹配删除数组中重复值并返回新数组；
    Array.prototype.del = function() {
        var a = {},
            c = [],
            l = this.length;
        for (var i = 0; i < l; i++) {
            var b = this[i];
            var d = (typeof b) + b;
            if (a[d] === undefined) {
                c.push(b);
                a[d] = 1;
            };
        };
        return c;
    }

    //匹配值是否存在于数组 返回 true / false;
    Array.prototype.in_array = function(e, PRM) {
        for (i = 0; i < this.length; i++) {
            if (this[i][PRM] == e)
                return true;
        };
        return false;
    };

    //匹配值是否存在于数组，如存则返回所存在的位置的索引值，并返回索引值数组 arr，
    Array.prototype.in_arrayS = function(e, arr, PRM) {
        arr = [];
        for (i = 0; i < this.length; i++) {
            if (this[i][PRM] == e)
                arr.push(this[i]);
        };
        return arr;
    };

    //匹配多全值是否存在于数组，如存在则返回所在位置的索引值
    Array.prototype.mateFruit = function(e, a) {

        for (i = 0; i < this.length; i++) {
            if (this[i].size == e && this[i].color == a)
                return i;
        };
        return false;
    };

    var colorArr = [],
        sizeArr = [],
        newSArr = [],
        newCArr = [],
        spec_id;

    var colorName,
        sizeName,
        stockNum = 0,
        setNum = 0;

    var specInfo = strToJson(spec_info);
       // $stock = $("#stock"); //库货

    //字符串转换Json
    function strToJson(str) {
        var json = eval('(' + str + ')');
        return json;
    }

    //初始化
    checkLoad();

    function checkLoad() {
        var cArr = [],
            sArr = [];

        //销完状态
        if ($('#saleTips').length > 0 && specInfo == "") {
            return false;
        };
       
        if (specInfo != "") {

            //初始数据，排列数组;
            for (var i = 0; i < specInfo.length; i++) {
                cArr.push(specInfo[i].color);
                sArr.push(specInfo[i].size);
                stockNum += parseInt(specInfo[i].stock);
            };

            //删除数组重复项
            colorArr = cArr.del();
            sizeArr = sArr.del(); 

            //根据数组初始选项，
            setcolorUl(colorArr);
            setsizeUl(sizeArr);

            //$stock.text(stockNum); //库存
        };
    }

    //拼装服装颜色列表；
    function setcolorUl(colorArr) {
        var srt = '';
        for (var i = 0; i < colorArr.length; i++) {
            srt += '<span class="dotted setClass doClass" data-code="1">' + colorArr[i] + '</span>';
        };
        $("#colorBox").append(srt);
    }

    //拼装服装尺寸列表；
    function setsizeUl(sizeArr) {
        var srt = '';
        for (var i = 0; i < sizeArr.length; i++) {
            srt += '<span class="dotted setClass doClass" data-code="2">' + sizeArr[i] + '</span>';
        };
        $("#sizeBox").append(srt);

    }

    //服装规格选项；
    $("#colorBox,#sizeBox").on("click", "span.setClass", selOption);

    function selOption(){
        var num = $(this).attr("data-code");
        if (setNum != Number(num)) {
            setNum += Number(num);
        }
        var _int;
        $(this).siblings(".setClass")
            .addClass("dotted")
            .removeClass("solid");
        $(this)
            .addClass("solid")
            .removeClass("dotted");
        // 选中与刷新规格；
        // 负数为选中，正数为未选中；
        if (num == 1) {
            colorName = $(this).text();
            newSArr = specInfo.in_arrayS(colorName, newSArr, "color");
            // 样式操作
            selSize($(this), 1, -1);
            //遍历 衣服码数是否在存在于所选的颜色组里
            ergodicArr($('#sizeBox'), newSArr, "size");
        } else if (num == 2) {
            sizeName = $(this).text();
            newCArr = specInfo.in_arrayS(sizeName, newCArr, "size");
            // 样式操作
            selSize($(this), 2, -2);
            //遍历 衣服颜色是否在存在于所选的码数组里
            ergodicArr($('#colorBox'), newCArr, "color");
        } else if (num == -1) {
            //取消已选中的尺寸时 样式操作
            CancelCheck($(this), $('#sizeBox'), 1); 
        } else if (num == -2) {
            //取消已选中的颜色时 样式操作
            CancelCheck($(this), $('#colorBox'), 2); 
        };
        //大于3则两个规格都选中；
        if (setNum >= 3) {
            setNum = 3;
            _int = specInfo.mateFruit(sizeName, colorName);
            if (_int != 'false') {
                //console.log("_int:"+_int);
                spec_id = specInfo[_int].spec_id;
            };
        };
        
    };

    //遍历 选择颜色、尺寸是否存在于所选的码数组里
    function ergodicArr($this, ARR, PRM) {
       
        $this.find('.doClass').each(function(i) {
            if (ARR.in_array($(this).text(), PRM) == false) {
                ergodicArrWrong($(this));
            } else {
                ergodicArrRight($(this));
            }
        });
    };

    // 遍历 选择颜色、尺寸存在于所选的码数组里 样式操作
    function ergodicArrRight($this) {
        $this
            .addClass("setClass")
            .removeClass("notClass");

    };
    // 遍历 选择颜色、尺寸不存在于所选的码数组里 样式操作
    function ergodicArrWrong($this) {
        $this
            .addClass("notClass")
            .removeClass("setClass");
    };
    //选择颜色、尺寸时 样式操作
    function selSize($this, i, k) {
        $this.siblings(".setClass").attr("data-code", i);
        $this.attr("data-code", k);
    };
    //取消已选中的颜色、尺寸时 样式操作
    function CancelCheck($this, $obj, i) {
        $this
            .attr("data-code", i)
            .addClass("dotted")
            .removeClass("solid");

        $obj.find('.doClass')
            .addClass("setClass")
            .removeClass("notClass");
    };



    function subAjax() {
        var gid=$(this).data('gid'),
            uid=$(this).data('uid');
        if(spec_id==''||spec_id==undefined){
            alert('请选择商品尺寸与颜色！');
            return false;
        }
        $.post('/beautiful/qrcode', {
            "goods_id": gid,
            "spec_id": spec_id,
            "uid":uid
        }, function(data) {
            if (data.success == true) {
                window.location.reload();
            } else {
                alert(data.data);
            };
           
        }, "json");
    };


    $('.J-Btn').on('click',subAjax);

})