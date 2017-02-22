

setBackUrl "/mine"

#关闭取消订单弹窗
closeCancelBox = () ->
    $("#show-box").hide()
    $(".cancel-reason li").removeClass("on")
    normalSlide()
#未完成取消
unCancelOrder = () ->
    orderId = sessionStorage.getItem("OrderId")
    orderStatus = sessionStorage.getItem("OrderStatus")
    $("##{orderId}").find(".remove-order").show()
    $("##{orderId}").find(".remove-order").html("取消订单")
    $("##{orderId}").find(".remove-order").removeAttr("disabled")

#点击确认 弹出处理信息
showHandleResult = (message) ->
    msg = message
    if $("#show-handle-result").length == 0
      html = """
      <div id="show-handle-result">
        #{msg}
      </div>
      """
    $("body").append(html)
#禁止滑动
def = (e) ->
    e.preventDefault()
noSlide = () ->
    document.body.style.overflow = 'hidden'
    document.addEventListener("touchmove",def,false)
normalSlide = () ->
    document.body.style.overflow = ''
    document.removeEventListener("touchmove",def,false)
$ ->
    #标题
    $cont_title = $('.row .cont_box')
    $cont_title.each( ->
        if $(this).text().length > 22
            $(this).text($(this).text().slice(0,23) + "...")
        # if $(this).text().slice(0,1) == "【"
        #     $(this).css("text-indent","-0.7rem")
        )
    #取消订单
    $(".cancel-reason").click (e) ->
        if (e.target.nodeName.toUpperCase() == "LI")
            $(".cancel-reason li").each (index,item) ->
                $(item).removeClass("on")
            $(e.target).addClass("on")
    
    $("#show-box .cancel").click ->
        closeCancelBox()
        unCancelOrder()

    $("#cancel-reason-box .confirm").click ->
        reasonText = $(".cancel-reason li.on").html()
        closeCancelBox()
        orderId = sessionStorage.getItem("OrderId")
        orderStatus = sessionStorage.getItem("OrderStatus")
        if reasonText == undefined
            showHandleResult "请选择取消原因"
            unCancelOrder()
            #$("##{orderId}").find(".remove-order").removeAttr("disabled")
        else
            $.putJSON "/orders/#{orderId}/cancel", reason:reasonText, (o) ->
              showHandleResult o.message
              if orderStatus == "已提交"
                $("##{orderId}").find(".status").html("已取消")
              else
                if orderStatus == "待出库"
                  $("##{orderId}").find(".remove-order").html("等待取消")
        setTimeout ->
            $("#show-handle-result").fadeOut("fast", ->
              $(@).remove()
            )
            #$("#show-handle-result").remove()
        ,1500

    $(".remove-order").click ->
        $("#show-box").slideDown("fast")
        noSlide()
        order_id = $(@).parents(".new-order-item").get(0).dataset.id
        order_status = $(@).parents(".new-order-item").get(0).dataset.orderStatus
        #console.log order_status
        if order_status == "已提交"
          $("##{order_id}").find(".remove-order").hide()
        else
          if order_status == "待出库"
            $("##{order_id}").find(".remove-order").html("等待取消")
        sessionStorage.setItem("OrderId",order_id)
        sessionStorage.setItem("OrderStatus",order_status)
        $(@).attr("disabled","disabled")

    $(".goods-list").click ->
        # console.log @#.dataset.id
        location.href = "/orders/#{$(@).parent().data('id')}"
