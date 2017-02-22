doc = document.documentElement
clientWidth = doc.clientWidth

window.runSlider()

$count = $("#count")
inCart = false


$(".add-to-carts").click (e) ->
    count = $count.val() - 0
    if count > 0
        # if window.isLimitBuy and count > 60
        #     Materialize.toast "单件商品数量不能超过60", 2000
        #     return
        addToCart e.target, productId, count


#标题不能超过20个字
$cont_title = $('.row .cont_box')
$cont_title.each( ->
    if $(this).text().length > 22
        $(this).text($(this).text().slice(0,23) + "...")
    # if $(this).text().slice(0,1) == "【"
    #     $(this).css("text-indent","-0.7rem")
    )

# 产品详情页限制input数量不得小于最小起定量
# $(".amount .num-box input").change ->
#     tempNum = $(".amount .num-box").attr("data-min-buycount")
#     if $(@).val()-0 < tempNum
#         showDialog "该商品最少购买#{tempNum}件"
#         $(@).val tempNum
#         setTimeout ->
#             $("#show-dialog").remove()
#         , 1000

$(".item-num input").change ->
    oldVal = $(@).attr("num")-0
    newVal = $(@).val()-0
    if newVal <= 0
      updateNum $(@).attr("id"),0
      return false
    minBuy = $(@).parent().attr("data-min-buycount")-0
    if newVal < minBuy
      showDialog "该商品最少购买#{minBuy}件"
      if oldVal == 0
        addToCart  $(@)[0],$(@).attr("id"),minBuy
      else
        updateNum $(@).attr("id"),minBuy
      setTimeout ->
          $("#show-dialog").remove()
      , 1000
    else
      if oldVal == 0
        addToCart  $(@)[0],$(@).attr("id"),newVal
      else
        updateNum $(@).attr("id"),newVal
# $bkColor = $('.order-detail-header').css('backgroundColor')
# $('.border_color').css('backgroundColor',$bkColor)
# $('.order_time').css('backgroundColor',$bkColor)
