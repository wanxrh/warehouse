
$(function() {
    function ClickCateType() {        
        $cate_type = $(this).val();
        $('.dfinput').html('');
        $.getJSON('/gcategory/cate_children/?cate_type=' + $cate_type, function(result) {
            if (result) {
                $('.dfinput').html(result.data);
                return;
            }
        });
    };
    $(".cate-type").on("click.ClickCate",ClickCateType)
})