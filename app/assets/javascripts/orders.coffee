window.onpopstate = ->
    loadAddress()
    setBackUrl "/carts"
    # loadCoupon()


@getAddressId = ->
    $(".address-item").attr("id").slice(3)

# checkStock = ->
#     $.getJSON "/orders/#{orderID}/stocks.json?address_id=#{getAddressId()}", (o) ->
#             console.log oorders


loadAddress = (callback) ->
    address = sessionStorage.getItem "address"
    setTimeout ->
        if address
            $("a.address").html(address).find(".address-item").removeClass("active")
            sessionStorage.removeItem "address"
            callback and callback()
    , 0

# loadCoupon = ->
#     coupon = sessionStorage.getItem "coupon"
#     setTimeout ->
#         if coupon
#             $("a.coupon").html(coupon)
#             sessionStorage.removeItem "coupon"
#     , 0



# <div class="card coupon-item" data-id="#{coupon.ID}" data-price="#{coupon.Price}" data-money="#{coupon.UseMoney}">
# <div class="card-content red-text">
#   <span class="card-title">¥#{coupon.Price}</span>
#   <p>有效期至#{parseDate(coupon.EndDate)}</p>
#   <p>消费满#{coupon.UseMoney}元可用</p>
# </div>
# </div>

@showCoupons = (key)->
    # url = "/coupons/mine?order_id=#{key}"
    tempkey = "temp" + key
    className = ".order" + key + " "
    $(".coupon-rule").hide()
    $(".coupon-items").show()
    $(className + '.modal').openModal
                dismissible: true
                opacity: .5
                in_duration: 300
                out_duration: 200
     $(className + ".list-title li:first-child").click()



# 有多少张优惠券可用
canUseNum = ->
    $(".order-item-box").each ->
        allNum = 0
        $(@).find(".coupon-item").each ->
          allNum += ($(@).attr("num")-0)
        noUseNum = allNum - $(@).find(".used").length
        $(@).find(".coupon-title em").html "#{noUseNum}张可用"
$ ->
    # 得到优惠券
    $(".order-item-box").each ->
        key = $(@).attr("key")
        url = "/coupons/mine?order_id=#{key}"
        tempkey = "temp" + key
        className = ".order" + key + " "
        num = 0;
        $.ajax {
          type: "GET",
          dataType : "json",
          url: url,
          success: (data) ->
            if data.status == "ok"
                ordersObj[tempkey].html = ""
                # 可用优惠券
                usable_coupons = data.data.usable_coupons
                unusable_coupons = data.data.unusable_coupons
                disStr = ""
                yesStr = ""
                cashStr = ""
                isShow = ""
                yesStrHide = ""
                canUseCouponNum = usable_coupons.length
                noUseCouponNum = unusable_coupons.length

                for coupon in usable_coupons
                    # console.log coupon
                    useTimes1 = ""
                    text1 = ""
                    priceText1 = ""
                    num = 0
                    useMoney = coupon.UseMoney
                    if coupon.CouponType == 5
                      isShow = "show"
                      num = coupon.CurrentCount
                      useTimes1 = "<i>X#{coupon.CurrentCount}张</i>"
                      # 剩余优惠券数量
                      text1 = "折"
                      priceText1 = (coupon.CouponDiscount*10).toFixed(2)
                      disStr += """
                      <li couponId="#{coupon.ID}" money="#{coupon.DiscountMoney}" num="#{coupon.CurrentCount}" couponType="#{coupon.CouponType}" class="coupon-item ">
                        <strong>#{coupon.TypeName}</strong>
                        <div class="clearfix">
                          <div class="price-box"><span class="coupon-price">#{priceText1}</span>#{text1}<div class="coupon-price-amount">满#{useMoney}元使用</div></div>
                          <p>
                            <span class="cont">#{coupon.Title}</span><br>
                            <span class="time">#{coupon.StartDate}-#{coupon.EndDate}</span>
                          </p>
                          <span class="check-coupon-btn"></span>
                        </div>
                      </li>
                    """
                    else if coupon.CouponType == 6
                      isShow = "show"
                      priceText1 = coupon.Price
                      num = 1
                      cashStr += """
                        <li couponId="#{coupon.ID}" money="#{coupon.DiscountMoney}" num="#{num}" couponType="#{coupon.CouponType}" class="coupon-item ">
                          <strong>#{coupon.TypeName}</strong>
                          <div class="clearfix">
                            <div class="price-box">&yen;<span class="coupon-price">#{priceText1}</span>#{text1}<div class="coupon-price-amount">满#{useMoney}元使用</div></div>
                            <p>
                              <span class="cont">#{coupon.Title}</span><br>
                              <span class="time">#{coupon.StartDate}-#{coupon.EndDate}</span>
                            </p>
                            <span class="check-coupon-btn"></span>
                          </div>
                        </li>
                      """
                    else
                      num = 1
                      priceText1 = coupon.Price
                      yesStr += """
                      <li couponId="#{coupon.ID}" money="#{coupon.DiscountMoney}" num="#{num}" couponType="#{coupon.CouponType}" class="coupon-item ">
                        <strong>#{coupon.TypeName}</strong>
                        <div class="clearfix">
                          <div class="price-box">&yen;<span class="coupon-price">#{priceText1}</span>#{text1}<div class="coupon-price-amount">满#{useMoney}元使用</div></div>
                          <p>
                            <span class="cont">#{coupon.Title}</span><br>
                            <span class="time">#{coupon.StartDate}-#{coupon.EndDate}</span>
                          </p>
                          <span class="check-coupon-btn"></span>
                        </div>
                      </li>
                    """
                # 不可用优惠券
                unusable_coupons = data.data.unusable_coupons
                noStr = ""
                noDisStr = ""
                noIsShow = ""
                for coupon in unusable_coupons
                    # console.log coupon
                    useTimes2 = ""
                    text2 = ""
                    priceText2 = ""
                    useMoney = coupon.UseMoney
                    if coupon.CouponType == 5
                      noIsShow = "show"
                      useTimes2 = "<i>X#{coupon.CurrentCount}张</i>"
                      text2 = "折"
                      priceText2 = (coupon.CouponDiscount*10).toFixed(2)
                      noDisStr += """
                      <li couponId="#{coupon.ID}" class="">
                        <strong>#{coupon.TypeName}</strong>
                        <div class="clearfix">
                          <div class="price-box"><span class="coupon-price">#{priceText2}</span>#{text2}<div class="coupon-price-amount">满#{useMoney}元使用</div></div>
                          <p>
                            <span class="cont">#{coupon.Title}</span><br>
                            <span class="time">#{coupon.StartDate}-#{coupon.EndDate}</span>
                          </p>
                        </div>
                      </li>
                    """
                    else
                      priceText2 = coupon.Price
                      noStr += """
                      <li couponId="#{coupon.ID}" class="">
                        <strong>#{coupon.TypeName}</strong>
                        <div class="clearfix">
                          <div class="price-box">&yen;<span class="coupon-price">#{priceText2}</span>#{text2}<div class="coupon-price-amount">满#{useMoney}元使用</div></div>
                          <p>
                            <span class="cont">#{coupon.Title}</span><br>
                            <span class="time">#{coupon.StartDate}-#{coupon.EndDate}#{useTimes2}</span>
                          </p>
                        </div>
                      </li>
                    """
                # 拼接
                if yesStr == ""
                  yesStrHide = "hidden"
                ordersObj[tempkey].html = """
                  <div class="coupons-status-box coupon-list-box"">
                    <div class="fixed-title">
                        <div class="coupon-cont-title">选择优惠券<span class="closed">使用规则</span></div>
                        <ul class="list-title clearfix">
                          <li class="active">可用优惠券<span class="can-num">(#{canUseCouponNum})</span></li>
                          <li>不可用优惠券<span class="no-num">(#{noUseCouponNum})</span></li>
                        </ul>
                    </div>
                    <div class="list-cont">
                      <div class="can-coupon coupon-list coupon-items">
                        <div class="ZK-box #{isShow}">
                          <ul class="ZK-coupon">
                            #{disStr}
                          </ul>
                          <ul class="DJ-coupon">
                            #{cashStr}
                          </ul>
                          <span class="tip #{yesStrHide}">注意：基本券和代金券与以下优惠券可同时使用</span>
                        </div>
                        <ul class="PT-coupon #{yesStrHide}">
                          #{yesStr}
                        </ul>
                      </div>
                      <div>
                        <div class="ZK-box #{noIsShow}">
                          <ul>
                            #{noDisStr}
                          </ul>
                        </div>
                        <ul class="no-coupon">
                          #{noStr}
                        </ul>
                      </div>
                    </div>
                    <div class="sure-btn">确定</div>
                  </div>
                """
                $(className + ".coupon-items").html ordersObj[tempkey].html
                $(className + ".coupon-title em").html "#{num}张可用"

                # 优惠券小数字体变小
                $(".coupon-price").each ->
                  price = $(@).html()
                  if price.split('.')[1] != undefined
                    $(@).html '<i class="big">' + price.split('.')[0] + '</i><i class="small-font">.' + price.split('.')[1] + '</i>'
            }



    # 默认选择最大的优惠券
    $(document).ajaxStop ->
        canUseNum()
        $(".can-coupon .PT-coupon:hidden").each ->
            $(@).find("li").each ->
                if window.couponArr.indexOf($(@).attr("couponId")) == -1
                    $(@).click()
                    return false

        $(".ZK-coupon:hidden").each ->
            $(@).find("li").each ->
                id = $(@).attr("couponId")
                useNum = $("li[couponid='"+id+"'].used").length
                time = $(@).attr("num")-0
                if time > useNum
                    $(@).click()
                    return false
        $(".DJ-coupon:hidden").each ->
            $(@).find("li").each ->
                if window.couponArr.indexOf($(@).attr("couponId")) == -1
                    $(@).click()
                    return false


$("button.pure-button").click ->
    if $(".empty-address").length > 0
        Materialize.toast '请选择地址', 2000
    if $(".delivery").length > 0
      timeServer = new Date($(".delivery").attr("data-server-time")).toLocaleDateString()
      timeNow = new Date().toLocaleDateString()
      if timeServer != timeNow
        reloadData =
            yesText: '确定'
            msg: '请重新选择送达时间日期,即将为您重新加载'
            isAlert: true
            callback: ->
              window.location.reload()
        return showDialog reloadData

    addressID = getAddressId()
    if ordersObj.temp0 != undefined
        couponId = ordersObj.temp0.couponId
    else
        couponId = null;
    data =
        'Address': $.trim($(".contact-address").text()) + $.trim($(".contact-address-detail").text())
        'ShipName': $(".contact-name").text()
        'ShipTel': $(".contact-tel").text()
        'PayType': 21

    if $("input[name='InvitationCode']").length != 0
      invitationCode = $.trim $("input[name='InvitationCode']").val()
      if invitationCode
        data.InvitationCode = invitationCode
      else
        showDialog "业务员编码不能为空"
        return false
    orders = {}
    $(".order-item-box").each ->
        key = $(@).attr("key")
        className = ".order" + key + " "
        keyObj = orders[key] = {}
        keyObj.Message =  $(className + ".input").val()
        # keyObj.CouponCode = []
        # if ordersObj["temp"+key].ZKcouponId
        #   keyObj.CouponCode.push ordersObj["temp"+key].ZKcouponId
        # if ordersObj["temp"+key].PTcouponId
        #   keyObj.CouponCode.push ordersObj["temp"+key].PTcouponId
        # if ordersObj["temp"+key].DJcouponId
        #   keyObj.CouponCode.push ordersObj["temp"+key].DJcouponId
        # keyObj.CouponCode = keyObj.CouponCode.join(",")
        keyObj.CouponCode = window.couponArr.join(",")
        if $(".integral-box a").hasClass "checked"
          keyObj.CashVolume = $(className + ".integral-money span").html()
        # if $(className + ".delivery").attr("data-date")
        keyObj.DeliveryDate = $(className + ".delivery").attr("data-date")
        if $(className + ".delivery").attr("data-time")
          deliveryTime = parseInt($(className + ".delivery").attr("data-time"))
        keyObj.DeliveryTime = deliveryTime
        # else
        #     keyObj.DeliveryDate = $(className + ".delivery").attr("data-date")
        #     keyObj.DeliveryTime = parseInt($(className + ".delivery").attr("data-time"))
    delay =>
        if @.promise and @.promise.state() == "pending"
            return
        @.promise = $.postJSON "/orders/#{orderCode}/confirm", order: data, AddressID: addressID,orders:orders,  (o) ->
                if o.status == "ok"
                    location.href = "/orders/submit_success?id=#{orderCode}"
                else
                    Materialize.toast o.message, 2500


updatePrice = (key)->
    # price = window.priceCount
    # giveAway = window.giveAwayCount
    tempkey = "temp" + key
    className = ".order" + key + " "
    price = ordersObj[tempkey].priceCount-0
    giveAway = ordersObj[tempkey].giveAwayCount
    couponPrice = ordersObj[tempkey].PTPrice + ordersObj[tempkey].ZKPrice + ordersObj[tempkey].DJPrice
    price -= couponPrice
    giveAway += couponPrice
    # 实付后最大的抵扣余额
    integralPrice = ordersObj[tempkey].priceCount - ordersObj[tempkey].couponPrice

    # if ordersObj[tempkey].PTcouponId || ordersObj[tempkey].ZKcouponId
    #     price -= couponPrice
    #     giveAway += couponPrice
    #     # 实付金额相当于多少积分
    #     # integralPrice = (ordersObj[tempkey].priceCount - ordersObj[tempkey].couponPrice)*200
    #     # if $(className + ".integral-select").val()-0 > integralPrice
    #     #     tempIntegral = parseInt(integralPrice/2000)*2000
    #     #     $(className + ".integral-select").eq(0).val(tempIntegral)
    #     #     $(className + ".integral-money span").html tempIntegral/200

    #     # $(className + ".integral-select option").each ->
    #     #     if $(@).val()-0 > integralPrice
    #     #         $(@).attr("disabled","true")
    #     #     else
    #     #         $(@).removeAttr("disabled")

    #     if $(".integral-text strong").html() - 0 > integralPrice
    #       console.log 1
    #       $(className + ".integral-money span").html integralPrice.toFixed(2)
    #       $(className + ".integral-text em").html integralPrice.toFixed(2)
    #     else
    #       console.log 2
    #       tempPrice = $(className + ".integral-text strong").html()
    #       $(className + ".integral-money span").html tempPrice
    #       $(className + ".integral-text em").html tempPrice
    # else
    #   tempPrice = $(className + ".integral-text em").html()
    #   $(className + ".integral-money span").html tempPrice
    #   $(className + ".integral-text em").html tempPrice
        # $(className + ".integral-select option").each ->
        #     $(@).removeAttr("disabled")

    # if $(className + ".integral-select").length != 0
    #     integralPrice = $(className + ".integral-select").val()/200 - 0
    #     price -= integralPrice
    if $(".integral-text strong").html() - 0 > integralPrice
      if integralPrice <= 0
        integralPrice = 0
      $(className + ".integral-money span").html integralPrice.toFixed(2)
      $(className + ".integral-text em").html integralPrice.toFixed(2)
    else
      tempPrice = $(className + ".integral-text strong").html()
      $(className + ".integral-money span").html tempPrice
      $(className + ".integral-text em").html tempPrice
    if $(className + ".integral-box a").hasClass "checked"
      integralPrice = $(className + ".integral-money span").html() - 0
      price -= integralPrice
    else
      $(className + ".integral-money span").html(0)
    price = Math.max(price, 0)
    $(className + ".price-str").html "¥ #{price.toFixed(2)}"
    # $(className + ".give-away-str").html "¥ #{giveAway.toFixed(2)}"
    addPrice()

addPrice = ->
    priceAdd = 0
    tempCouponPrice = 0
    tempGiveawayPrice = 0
    integralPrice = 0
    discountPrice = 0
    $(".price-str").each ->
        priceAdd += parseFloat($(@).html().slice(1))
    $(".coupon_text").each ->
        tempCouponPrice += parseFloat($(@).html().slice(2))
    # $(".giveaway_text").each ->
    #     tempGiveawayPrice += parseFloat($(@).html().slice(2))
    $(".integral-money").each ->
        integralPrice += parseFloat($(@).find("span").html())
    $(".discount-price").each ->
        discountPrice += parseFloat($(@).html())
    $(".price-str-add>em").text("¥" + priceAdd.toFixed(2))
    $(".give-away-str").text("¥" + parseFloat(tempGiveawayPrice+discountPrice+tempCouponPrice+integralPrice).toFixed(2))

addPrice()


# 限制产品名称字数
$cont_title = $('.row .cont_box')
$cont_title.each( ->
    if $(this).text().length > 22
        $(this).text($(this).text().slice(0,23) + "...")
    )

# 弹出优惠券
$(".coupon").bind "click", ->
    showCoupons $(@).attr("orderId")
# 已使用的优惠券id数组
@.couponArr = []
Array.prototype.remove = (val)->
    index = @.indexOf val
    if index > -1
        @.splice index,1
# 普通优惠券计算
counponFn = (key) ->
  tempkey = "temp" + key
  className = ".order" + key + " "
  price = ordersObj[tempkey].PTPrice + ordersObj[tempkey].ZKPrice + ordersObj[tempkey].DJPrice - 0
  ordersObj[tempkey].couponPrice = price
  if price == 0
    $(className + ".coupon-title").html "<i>优惠券</i><em></em>"
    $(className + ".coupon-give-away").addClass("hidden").html ""
    $(className + ".coupon_text").html "-¥ 0"
  else
    $(className + ".coupon-title").html "优惠券"
    $(className + ".coupon-give-away").removeClass("hidden").html "节省#{price.toFixed(2)}元"
    $(className + ".coupon_text").html "-¥ #{price.toFixed(2)}"
  # $(className + ".modal").closeModal()
  updatePrice(key)
  canUseNum()
# 重置优惠券状态
couponState = ->
  $(".PT-coupon .coupon-item").show().each ->
    $(@).removeClass("used")
    tempId = $(@).attr("couponId")
    if window.couponArr.indexOf(tempId) > -1
        $(@).addClass("used")
    canUseNum()
# 给优惠券加事件
# 普通优惠券
$(document).on "click",".can-coupon  .PT-coupon .coupon-item",(e)->
    key = $(@).parents(".order-item-box").attr("key")
    tempkey = "temp" + key
    className = ".order" + key + " "
    id = $(@).attr("couponId")
    if ordersObj[tempkey].PTcouponId != id && window.couponArr.indexOf(id) != -1
      showDialog "此优惠券在其他店铺使用中"
      return
    else if ordersObj[tempkey].PTcouponId == id
      window.couponArr.remove ordersObj[tempkey].PTcouponId
      ordersObj[tempkey].PTcouponId = null
      ordersObj[tempkey].PTPrice = 0
      $(@).removeClass("used")
      counponFn(key)
      return
    $(@).addClass("used").siblings().removeClass("used")
    ordersObj[tempkey].PTPrice = $(@).find(".coupon-price").text()-0
    window.couponArr.remove ordersObj[tempkey].PTcouponId
    ordersObj[tempkey].PTcouponId = id
    window.couponArr.push id

    counponFn(key)


# 折扣优惠券
$(document).on "click",".can-coupon  .ZK-coupon .coupon-item",(e)->
    key = $(@).parents(".order-item-box").attr("key")
    tempkey = "temp" + key
    className = ".order" + key + " "
    id = $(@).attr("couponId")
    if $(@).hasClass "used"
      $(@).removeClass "used"
      window.couponArr.remove id
      ordersObj[tempkey].ZKPrice = 0
      ordersObj[tempkey].ZKcouponId = null
      counponFn(key)
      return

    useNum = $("li[couponid='"+id+"'].used").length
    time = $(@).attr("num")-0
    if useNum == time
        showDialog "此优惠券张数不够了"
        return
    if ordersObj[tempkey].ZKcouponId != id
      window.couponArr.remove ordersObj[tempkey].ZKcouponId
      ordersObj[tempkey].ZKcouponId = id
      window.couponArr.push id
      $(className + ".ZK-coupon .coupon-item").removeClass "used"

    $(@).addClass("used")
    ordersObj[tempkey].ZKPrice = $(@).attr("money")-0
    counponFn(key)

# 代金优惠券
$(document).on "click",".can-coupon  .DJ-coupon .coupon-item",(e)->
    key = $(@).parents(".order-item-box").attr("key")
    tempkey = "temp" + key
    className = ".order" + key + " "
    id = $(@).attr("couponId")
    if ordersObj[tempkey].DJcouponId != id && window.couponArr.indexOf(id) != -1
      showDialog "此优惠券在其他店铺使用中"
      return
    else if ordersObj[tempkey].DJcouponId == id
      window.couponArr.remove ordersObj[tempkey].DJcouponId
      ordersObj[tempkey].DJcouponId = null
      ordersObj[tempkey].DJPrice = 0
      $(@).removeClass("used")
      counponFn(key)
      return
    $(@).addClass("used").siblings().removeClass("used")
    ordersObj[tempkey].DJPrice = $(@).find(".coupon-price").text()-0
    window.couponArr.remove ordersObj[tempkey].DJcouponId
    ordersObj[tempkey].DJcouponId = id
    window.couponArr.push id

    counponFn(key)

$(document).on "click",".sure-btn",  ->
  $(".modal").each ->
    $(@).closeModal()


# $(document).on "click",".no-have", ->
#     key = $(@).parents(".order-item-box").attr("key")
#     tempkey = "temp" + key
#     className = ".order" + key + " "
#     console.log ordersObj[tempkey].PTcouponId
#     window.couponArr.remove ordersObj[tempkey].PTcouponId
#     ordersObj[tempkey].PTcouponId = null
#     ordersObj[tempkey].PTPrice = 0
#     counponFn(key)
#     couponState()



address = $(".address-item")
if address.length > 0
    addressCountyId = address.data("countyId")
    chosedCountyId = $.cookie("county_id")
    # console.log addressDepotId
    # console.log chosedDepotId
    if addressCountyId != chosedCountyId
        showDialog '收货地址和当前区域不匹配，商品库存可能发生变化'

$(document).on "click",".list-title>li", ->
    key = $(@).parents(".order-item-box").attr("key")
    tempkey = "temp" + key
    className = ".order" + key + " "
    $(@).addClass("active").siblings().removeClass("active")
    $(className + ".list-cont>div").eq($(@).index()).show().siblings().hide()


# 使用规则弹窗
$(document).on "click",".coupon-cont-title .closed",->
    key = $(@).parents(".order-item-box").attr("key")
    className = ".order" + key + " "
    $(className + ".coupon-rule").show()

$(".coupon-rule a").click ->
    $(".coupon-rule").hide()

# 积分按钮
# $(".integral-select").change ->
#     key = $(@).parents(".order-item-box").attr("key")
#     tempkey = "temp" + key
#     className = ".order" + key + " "
#     if $(@).val() == "0"
#         $(className + ".integral-show").hide()
#         $(className + ".integral-money span").html 0
#     else
#         $(className + ".integral-show").show()
#         $(className + ".integral-money span").html $(@).val()/200
#     updatePrice(key)
$(".integral-box a").click ->
  key = $(@).parents(".order-item-box").attr("key")
  tempkey = "temp" + key
  className = ".order" + key + " "
  canUsePrice = $(className + ".integral-text strong").html()-0
  # console.log canUsePrice
  if canUsePrice == 0
    return
  if $(@).hasClass "checked"
    $(@).removeClass "checked"
    $(className + ".integral-show").hide()
    $(className + ".integral-money span").html 0
  else
    $(@).addClass "checked"
    $(className + ".integral-show").show()
    $(className + ".integral-money span").html $(".integral-text em").html()
  updatePrice(key)

$(".integral-box").each ->
  if $(@).find("a").length > 0
    setTimeout ->
      $(".integral-box a").click()
    ,0


# 送达时间
$(".delivery").click ->
    $(".delivery-items").css({"transform":"translate3d(0,0,0)"})

$(".delivery-back").click ->
    $(".delivery-items").css({"transform":"translate3d(100%,0,0)"})

# 生成第7天的日期
timeNow = new Date($(".delivery").attr("data-server-time"))
hours = timeNow.getHours()
if hours >= 20
  days = 2
else if hours >= 14
  days = 1
  onlyPm = true
else
  days = 1
  onlyPm = false

addDate = ->
  if $(".delivery").length > 0
    timeNow = new Date($(".delivery").attr("data-server-time"))
    timeNow.setDate(timeNow.getDate()+days)
    weekdays = new Array(7)
    weekdays = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"]
    str = '<div class="delivery-item checked asquick">尽快送达</div>'
    i = 0
    while i < 7
      timeNow.setDate timeNow.getDate() + 1
      date = new Date(timeNow).Format("yyyy-MM-dd")
      month = timeNow.getMonth()+1
      day = timeNow.getDate()
      weekday = weekdays[timeNow.getDay()]
      str += """<div class="delivery-item delivery-date" data-delivery-date='#{date}'>#{month}月#{day}号(#{weekday})</div>"""
      i++
    $(".date-box").html(str)
addDate()


$(document).on "click",".select-date .delivery-item",->
    if $(@).hasClass("asquick")
      $(".select-time").hide()
      $(".select-time .delivery-time").removeClass("checked")
      $(@).addClass("checked").siblings().removeClass("checked")
    else
      $(".delivery-time").eq(0).show()
      if onlyPm and $(@).index() == 1
        $(".delivery-time").eq(0).removeClass("checked").hide()
      $(".select-time").show()
      $(@).addClass("checked").siblings().removeClass("checked")

$(document).on "click",".select-time .delivery-item",->
    $(@).addClass("checked").siblings().removeClass("checked")

# 选择确定时间
$(".delivery-sure").click ->
    if $(".asquick").hasClass("checked")
        $(".delivery .delivery-choice").html("尽快送达")
        $(".delivery").removeAttr("data-date data-time")
        $(".delivery-back").click()
        return
    else if $(".delivery-time").hasClass("checked")
        str = $(".delivery-date.checked").html()
        str += $(".delivery-time.checked").html() + "送达"
        $(".delivery").attr("data-date",$(".delivery-date.checked").attr("data-delivery-date"))
        $(".delivery").attr("data-time",$(".delivery-time.checked").attr("data-delivery-time"))
        $(".delivery .delivery-choice").html(str)
        $(".delivery-back").click()
    else
        showDialog "您还没有选择配送时间"

