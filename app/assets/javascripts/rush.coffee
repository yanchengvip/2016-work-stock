@rushBuy = (product_id) ->
    delay =>
        if window.rushPromise and window.rushPromise.state() == "pending"
            return
        window.rushPromise = $.postJSON "/activity/rush_product", "product_id": product_id, (o) ->
            if o.status == "ok"
                showDialog "恭喜抢购成功，请到购物车查看"
                Cart.refresh()
            else
                showDialog o.message

$(".day-nav span").click -> 
    $(this).addClass("active").siblings().removeClass("active")
    $(".items ul").eq($(this).index()).show().siblings().css("display","none")
  
