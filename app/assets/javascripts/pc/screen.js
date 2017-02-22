// 点击选中	
$(function () {

    $('.click_add').bind("click", function () {
        $(this).addClass('bg_red').siblings().removeClass('bg_red');
    })


    $('.add_son').bind("click", function () {
        window.location.href = "/order_info?id=" + $("#car-list").data("order-id") + "&address_id=" + $(this).attr("id");

        //$(this).addClass('active').siblings().removeClass('active');

        //$("#address").html($(this).children("ul").children("li").eq(2).html());
        //$("#recipient").html($(this).children("ul").children("li").eq(0).html());
        //$("#tel").html($(this).children("ul").children("li").eq(1).html());
        //$("#address_id").val($(this).attr("id"));
    })

    $('#toggleclass a').click(function () {
        $(this).addClass('bg_red').siblings().removeClass('bg_red');
        $('.click_add').removeClass('bg_red');
    })


    $('.add_border a').bind("click", function () {
        $(this).addClass('active').siblings().removeClass('active');
        $(this).parent().parent().siblings().find('a').removeClass('active');

        $("#mode").val($(this).attr("mode"));
    })
})
