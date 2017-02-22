# 操作手续费和返利方法
disPriceFn = (price) ->

  if price-0 >= 600
    $.getJSON "/orders/poundage?paymoney=#{price}",(data)->
      $(".fenqi-pay span,.zhaoshang-pay span").remove()
      poundage = Math.abs(data.data.poundage)
      $(".fenqi-pay").append "<span price='#{poundage}'>需付手续费#{poundage}</span>"
      $(".mode-list li[class='checked']").click()
  else
    $(".fenqi-pay span,.zhaoshang-pay span").remove()
    $(".fenqi-pay").append "<span price='0'>不满600元无法使用</span>"



# 名称文字限制
$cont_title = $('.row .cont_box')
$cont_title.each ->
    if $(this).text().length > 22
        $(this).text($(this).text().slice(0,23) + "...")

$ ->
  # 订单所属判断
  if $("table").length == 0
    data =
      yesText: '重新扫码'
      msg: '此订单非登录账号所属订单,请重新扫码支付'
      isAlert: true
      callback: ->
        if isAndroid()
          return Android.backToHome()
        else if isiOS()
          return window.webkit.messageHandlers.backToHome.postMessage({})
    showDialog data
  else if is_paied
    data =
      yesText: '重新扫码'
      msg: '此订单已经支付过,<br>订单只可支付一次'
      isAlert: true
      callback: ->
        if isAndroid()
          return Android.backToHome()
        else if isiOS()
          return window.webkit.messageHandlers.backToHome.postMessage({})
    showDialog data
  else
    disPriceFn($(".pay-box input").val())


  orderCode = $(".order-code").text()
  payUrl = ""



  $(".pay-box input").change ->
    inputPrice = $(@).val() - 0
    orderPrice  = $(".order-price").text() - 0
    if inputPrice > orderPrice || inputPrice <= 0
      showDialog "输入金额有误"
      $(@).val orderPrice
      disPriceFn(orderPrice)
      return
    disPriceFn(inputPrice)
  #去支付
  $(".go-pay").click ->
    $(".pay-mode-box").show()
    inputPrice = $(".pay-box input").val() - 0
    $(".pay-ok").html inputPrice
    $(".mode-list .zhaoshang-pay").click()
    # $(".pay-mode-box .pay-mode").css("transform","translateY(0)")

  $(".pay-mode-box .shadow").click ->
    $(".pay-mode-box").hide()
    $(".mode-list li").removeClass("check")
    # $(".pay-mode-box .pay-mode").css("transform","translateY(100%)")

  # 选择支付方式
  $(".mode-list li").click ->
    inputPrice = $(".pay-box input").val() - 0
    if inputPrice < 600 && $(@).hasClass("fenqi-pay")
      showDialog "金额不满600元<br>不能使用分期乐"
      return
    payUrl=""
    $(@).addClass("check").siblings().removeClass("check")
    if $(@).find("span").length != 0
      price = $(".pay-box input").val() - 0
      disPrice = $(@).find("span").attr("price") - 0
      $(".pay-ok").html (price + disPrice).toFixed(2)
    else
      $(".pay-ok").html $(".pay-box input").val() - 0

    # 测试支付地址
    # if $(@).hasClass("fenqi-pay")
    #   payUrl = "http://pay.jhb.net/lfq?code=#{orderCode}&payMoney=#{inputPrice}"
    # else if $(@).hasClass("zhaoshang-pay")
    #    payUrl = "cmb://pay.jhb.net/cmb/index?code=#{orderCode}&payMoney=#{inputPrice}"

    if $(@).hasClass("fenqi-pay")
      payUrl = "http://pay.tunnel.jinhuobao.com.cn/lfq?code=#{orderCode}&payMoney=#{inputPrice}"
    else if $(@).hasClass("zhaoshang-pay")
       payUrl = "cmb://pay.tunnel.jinhuobao.com.cn/cmb/index?code=#{orderCode}&payMoney=#{inputPrice}"


  # 支付
  $(".pay-btn").click ->
    if payUrl == ""
      showDialog "请选择支付方式"
      return
    $(".pay-mode-box").hide()
    uid = $(@).attr("userId")
    window.location = payUrl + "&uid=" + uid
