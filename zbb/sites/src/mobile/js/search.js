$(function() {
    //购物车数量
    $.post("/userstat/index", function(data) {
        $("#cart-num").html(data);
    });
})