updateProductItemPrice = ->
    $(".cart-product-box").each ->
            priceItem = 0
            deliverPrice = $(@).attr("deliver-price")
            # sellerName = $(@).find(".seller-title h2").text()
            $productChecked = $(@).find(".cart-product.checked")
            # mustBuyNum = $(@).attr("must-buy-num")
            # if $productChecked.length < mustBuyNum
            #     htmlStr += "<p>#{sellerName}订单不满#{mustBuyNum}件无法配送哦！</P>"
            #     flag = true
            if $productChecked.length >= 0
                $productChecked.each ->
                    input = $(@).find("input")
                    count = input.val() - 0
                    price = $(@).find(".price-num").text() - 0
                    priceItem += count * price
                if priceItem < deliverPrice
                    $(@).find(".product-item-price .price").html("小计:¥#{priceItem.toFixed(2)}").next().show()
                else
                    $(@).find(".product-item-price .price").html("小计:¥#{priceItem.toFixed(2)}").next().hide()

updateProductItemPrice()

setSellerDiscount = () ->
  updateProductItemPrice()
  $.getJSON "/carts/activity_products",(o)->
    if o.status == "ok"
      obj = o.data.carts_group
      $(obj).each (index,item) ->
        #小计金额
        #获取小计数据 需要在数据改变之后
        if $(".cart-product-box").eq(index).find(".product-item-price .price").html()
          $subtotalCart = $(".cart-product-box").eq(index).find(".product-item-price .price").html().substring(4)
        $subtotalCart = parseFloat "#{$subtotalCart}"
        amountOfActivity = obj[index].activities_top
        $(amountOfActivity).each (index1,item1) ->
          if $(amountOfActivity)[index1 - 1]
            previous = $(amountOfActivity)[index1 - 1].activity_price
          if previous == undefined
            previous = 0
          previous = parseFloat previous
          price = parseFloat item1.activity_price
          len = $(amountOfActivity).length
          beginPrice = parseFloat amountOfActivity[0].activity_price
          lastPrice = parseFloat amountOfActivity[len - 1].activity_price
          if previous <= $subtotalCart < price
            if $subtotalCart < beginPrice
              if item1.type == 4
                $(".cart-product-box").eq(index).find(".active-tag").html("满送")
                $(".cart-product-box").eq(index).find(".seller-discount").html("购满 <span>#{price}</span>元,赠送 <span>#{item1.activity_product}</span>")
              else if item1.type == 2
                $(".cart-product-box").eq(index).find(".active-tag").html("满减")
                $(".cart-product-box").eq(index).find(".seller-discount").html("购满 <span>#{price}</span>元,减免 <span>#{item1.activity_product}</span>元")
              else
                console.log "第一种状态"
            else if $subtotalCart >= beginPrice
              prevItem = amountOfActivity[index1 - 1]
              if prevItem.type == 4
                $(".cart-product-box").eq(index).find(".active-tag").html("满送")
                $(".cart-product-box").eq(index).find(".seller-discount").html("已购满 <span>#{amountOfActivity[index1 - 1].activity_price}</span>元,已赠送 <span>#{amountOfActivity[index1 - 1].activity_product}</span>")
              else if prevItem.type == 2
                $(".cart-product-box").eq(index).find(".active-tag").html("满减")
                $(".cart-product-box").eq(index).find(".seller-discount").html("已购满 <span>#{amountOfActivity[index1 - 1].activity_price}</span>元,已减免 <span>#{amountOfActivity[index1 - 1].activity_product}</span>元")
              else
                console.log "第二种状态"
          else
            if $subtotalCart >= lastPrice
              if item1.type == 4
                $(".cart-product-box").eq(index).find(".active-tag").html("满送")
                $(".cart-product-box").eq(index).find(".seller-discount").html("已购满 <span>#{amountOfActivity[len - 1].activity_price}</span>元,已赠送 <span>#{amountOfActivity[len-1].activity_product}</span>")
              else if item1.type == 2
                $(".cart-product-box").eq(index).find(".active-tag").html("满减")
                $(".cart-product-box").eq(index).find(".seller-discount").html("已购满 <span>#{amountOfActivity[len - 1].activity_price}</span>元,已减免 <span>#{amountOfActivity[len-1].activity_product}</span>元")
              else
                console.log "第三种状态"
            else


@removeCart = (id, name) ->
    showDialog {
        cancelText: '确定'
        yesText: '取消'
        msg: "删除 “#{name}” ？"
        position: "atButtom"
        cancel: ->
            $.deleteJSON "/carts/#{id}", (o) ->
                $("#product-#{id}").remove()
                # Cart.update o.data
                reCalculate()
                removeCartBox()
        callback: ->
            $("#product-#{id} input").val $("#product-#{id} input").attr("num")
    }

emptyCart = ->
  if $(".cart-product-box").length == 0
    $("main.cart").html('
            <div class="line"></div>
            <div class="no-content center-align">
              <i class="empty-img"></i>
              <span class="sp_1 jhb-grey">购物车肚子空空</span>
              <span class="sp_2 jhb-grey">挑点什么呢？</span>
              <a class="pure-button jhb-grey button-small" href="/products/list">去逛逛</a>
            </div>
        ')

removeCartBox = ->
    $(".cart-product-box").each ->
      if $(@).find(".cart-product").length == 0
        $(@).remove()
      if $(".cart-product-box").length == 0
        $("main.cart").html('
                <div class="line"></div>
                <div class="no-content center-align">
                  <i class="empty-img"></i>
                  <span class="sp_1 jhb-grey">购物车肚子空空</span>
                  <span class="sp_2 jhb-grey">挑点什么呢？</span>
                  <a class="pure-button jhb-grey button-small" href="/products/list">去逛逛</a>
                </div>
            ')

@checkOut = ->
    delay ->
        # if Cart.getPrice() < leastOrderMoney
        #     return Materialize.toast "订单不满#{leastOrderMoney}元无法配送哦！", 2000
        htmlStr = ""
        flag = false
        flagNull = true
        $(".cart-product-box").each ->
            if $(@).find(".cart-product.checked").length > 0
                flagNull = false
            else
                return
            priceTotal = 0
            deliverPrice = $(@).attr("deliver-price")
            sellerName = $(@).find(".seller-title h2").text()
            $productChecked = $(@).find(".cart-product.checked")
            $subProducts = $(@).find(".sub-cart-product")
            mustBuyNum = $(@).attr("must-buy-num")
            # if $productChecked.length < mustBuyNum && ($productChecked.length + $subProducts.length)  < (mustBuyNum - 0 + 1)
            #     htmlStr += "<p>#{sellerName}订单不满#{mustBuyNum}件无法配送哦！</P>"
            #     flag = true
            if $productChecked.length > 0
                $productChecked.each ->
                    input = $(@).find("input")
                    count = input.val() - 0
                    price = $(@).find(".price-num").text() - 0
                    priceTotal += count * price

                # if priceTotal < deliverPrice
                #     htmlStr += "<p>#{sellerName}订单不满#{deliverPrice}元无法配送哦！</p>"
                #     flag = true

        if flag == true
            # return Materialize.toast htmlStr, 2000
            showDialog {
                cancelText: '<span style="color:#4A90E2">去商品列表</span>'
                yesText: '<span style="color:#4A90E2">留在购物车</span>'
                msg: htmlStr
                cancel: ->
                    window.location.href='/products/list';
            }
            return false
        if flagNull == true
            showDialog {
                cancelText: '<span style="color:#4A90E2">去商品列表</span>'
                yesText: '<span style="color:#4A90E2">留在购物车</span>'
                msg: "请选择购买商品!"
                cancel: ->
                    window.location.href='/products/list';
            }
            return false
        list = []
        isPass = true
        $(".cart-product.checked").each ->
            self = @
            if not isVerifiedCart(self.dataset.ckey)
                isPass = false
                return false
            list.push
                "ckey": self.dataset.ckey
                "key": self.dataset.key
                "number": $(self).find("input").val()
        if isPass
            window.showLoading()
            $.postJSON "/orders", {list: list, inApp: isInApp()}, (o) ->
                window.hideLoading()
                if o.status == "ok"
                    location.href = "/order_info?id=#{o.order_group_id}"
                    #如果不够起步金额确定后跳到哪里
                    ###
                    $priceLpt = parseFloat $(".price-total .cart-price").html()
                    if parseFloat("#{$priceLpt}") < 500
                        showDialog
                            cancelText: '确定'
                            yesText: '取消'
                            msg: '订单金额不满500元'
                            position: 'atButtom'
                            cancel: ->
                                location.href = "/order_info?id=#{o.order_group_id}"
                            callback: ->

                        $("#msg-box").css("transform","translateY(0)")
                        setTimeout ->
                          $("#msg-box").css("transform","translateY(-100%)")
                        ,0
                    else
                        location.href = "/order_info?id=#{o.order_group_id}"
                    ###
                else
                    Materialize.toast o.message, 2000

    # $(".cart-product-box").each ->
    #     $(@).find(".cart-product.checked").each ->
    #         input = $(@).find("input")
    #         count = input.val() - 0
    #         price = $(@).find(".price-num").text() - 0
    #         goodsGount += 1
    #         priceTotal += count * price
    #         deliverPrice = @.parentNode.attr("deliver-price")
    #         if priceTotal < deliverPrice
    #             return Materialize.toast "订单不满#{deliverPrice}元无法配送哦！", 2000




reCalculate = ->
    updateProductItemPrice()
    delay ->
        goodsGount = 0
        priceTotal = 0
        $(".cart-product.checked").each ->
            input = $(@).find("input")
            count = input.val() - 0
            price = $(@).find(".price-num").text() - 0
            goodsGount += 1
            priceTotal += count * price
        Cart.setPrice priceTotal
        # Cart.setAmount goodsGount
        $(".ready>.cart-num").text goodsGount
        # if priceTotal < leastOrderMoney
        #     $("#shop-cart").addClass("not-ready")
        # else
        #     $("#shop-cart").removeClass("not-ready")
#凑单 || 逛逛
toGather = () ->
    $(".cart-product-box").each (index,item) ->
      $price = $(item).find(".product-item-price .price").html().substring(4)
      $price = parseFloat $price
      $.getJSON "/carts/activity_products",(o)->
        if o.status == "ok"
          contrastPrice = o.data.carts_group[index].activities_top[0].activity_price
          contrastPrice = parseFloat contrastPrice

          if $price <= contrastPrice
            $(item).find(".assem-products").html("去凑单")
          else if $price > contrastPrice
            $(item).find(".assem-products").html("去逛逛")

# toGather()

updateNumCart = (productId, callback) ->
    delay ->
        num = $("#product-#{productId} input").val() - 0
        div = $("#product-#{productId}")
        stock = div.data("stock") - 0
        $.putJSON "/carts/#{productId}/update_num", num: num, (o) ->
            if o.status == 'ok'
                # Cart.update o.data
                div.find("input").attr("num",num)
                reCalculate()
                callback and callback()
                if not isNaN(stock)
                    if num > stock
                        div.addClass("out-of-stock")
                    else
                        div.removeClass("out-of-stock")
                else
                    div.removeClass("out-of-stock")
            else
                div.find("input").val(div.find("input").attr("num"))
                Materialize.toast o.message, 2000

isVerifiedCart = (id) ->
    # console.log("购物车验证")
    div = $("#product-#{id}")
    maxSaleAmount = div.get(0).dataset.maxBuy - 0
    count = div.find("input").val()-0
    stock = div.data("stock")
    minBuy = div.data('minBuy')-0
    name = div.find('.title').text()
    if count > 0
        msg = ''
        if (stock != undefined) and count > stock
            msg = "#{name}库存不足#{count}件"
        if isLimitBuy and maxSaleAmount and count > maxSaleAmount
            msg = "#{name}限购#{maxSaleAmount}件"
        if count < minBuy
            msg = "#{name}最少购买#{minBuy}件"
        if msg
            ###
            $('html,body').animate
              scrollTop: div.offset().top-150, 'slow'
            ###
            Materialize.toast msg, 2000
            if stock is undefined
              val = maxSaleAmount
            else if maxSaleAmount == 0
              val = stock
            else
              val = Math.min(maxSaleAmount, stock)
            if count < minBuy
              val = minBuy
            #console.log val,maxSaleAmount,stock
            div.fadeOut().fadeIn().find("input").val(val)
            updateNumCart(id)
            return false
        else
            true

    true

updateCheckAllState = ->
    if $(".cart-product.checked").length == $(".cart-product").length
        $("#shop-cart").addClass("checked")
        $(".product-seller").addClass("checked")
    else
        $("#shop-cart").removeClass("checked")
        $(".cart-product:not(.checked)").siblings(".product-seller").removeClass("checked")

updateCartHaveGoods = ->
  if $(".goods") != 0
    $(".cart-product-box").each (index,item)->
      if $(item).find(".cart-product").length == 0
        $(item).remove()

@goLeft = (offset) ->
    if not offset
        offset = 1
    offsetNow = $("#order-form").css("left").slice(0,-2) - 0
    $("#order-form").velocity({"left": offsetNow - offset*screen.width })


$ ->
    updateCartHaveGoods()
    # goLeft()
    reCalculate()
    updateCheckAllState()

    $(".tool>.check-box").click ->
        id = @.parentNode.parentNode.dataset.ckey
        $tempParen = $(@.parentNode.parentNode)
        if $("#product-#{id}").toggleClass("checked").hasClass("checked")
            url = "/carts/#{id}/check"
            if $tempParen.siblings(".cart-product:not(.checked)").length == 0
                $tempParen.siblings(".product-seller").addClass("checked")
        else
            url = "/carts/#{id}/uncheck"
        $.putJSON url, (o) ->
            setSellerDiscount()
            # Cart.update o.data
            reCalculate()
        updateCheckAllState()


    $(".folding, .unfolding").click ->
        id = @.parentNode.parentNode.dataset.ckey
        div = $("#product-#{id}")
        if div.toggleClass("unfold").hasClass("unfold")
            div.find(".sub-cart-products").addClass("flex")
        else
            div.find(".sub-cart-products").removeClass("flex")

    $(".cart-product-box .number").change ->
        val = parseInt $(@).val()
        val = !isNaN(val) and val or 1
        $(@).val val

        if val <= 0
          $(@).parents(".cart-product").find(".remove").click()
          return false
        productId = @.dataset.id
        if isVerifiedCart(productId)
            updateNumCart productId
            setSellerDiscount()

    $("#shop-cart>.check-box").click ->
        cartItemCount = $(".cart-product").length
        checkedItemCount = $(".cart-product.checked").length
        if cartItemCount > 0
            reCalculate()
            if cartItemCount == checkedItemCount
                $(".cart-product").removeClass("checked")
                $("#shop-cart").removeClass("checked")
                $(".product-seller").removeClass("checked")
                $.putJSON "/carts/uncheck_all", ->

            else
                $(".check-box").parents(".cart-product").addClass("checked")
                #$(".cart-product").addClass("checked")
                $("#shop-cart").addClass("checked")
                $(".product-seller").addClass("checked")
                $.putJSON "/carts/check_all", (o) ->
                    # Cart.update o.data
            setSellerDiscount()

    $('.product-seller .check-box').click ->
        $parentNode = $(@.parentNode)
        companyId = $parentNode.attr("company-id")
        if $parentNode.toggleClass("checked").hasClass("checked")
            #console.log $parentNode.parents(".cart-product-box").find(".check-box").parents(".cart-product")
            $parentNode.siblings().addClass("checked")
            #$parentNode.parents(".cart-product-box").find(".check-box").parents(".cart-product").addClass("checked")
            $.putJSON "/carts/check_all?company_id=#{companyId}", ->

        else
            $parentNode.siblings().removeClass("checked")
            #$parentNode.parents(".cart-product-box").find(".check-box").parents(".cart-product").removeClass("checkout")
            $.putJSON "/carts/uncheck_all?company_id=#{companyId}", ->
        updateProductItemPrice()
        setSellerDiscount()
        reCalculate()
        updateCheckAllState()


$(document).on 'page:restore', ->
    location.reload()



# $("body").addClass("moveCart")
$(".remove").click(->

    setTimeout( ->
        $("#msg-box").css("transform","translateY(-100%)")
        )

    )


showMsg = (text, img_url) ->
    html = """
        <div id="show-dialog">
            <div id="discount-msg-box">
                <div class="seller-img">
                    <img src="#{img_url}" alt="">
                </div>
                <div class="msg-title">优惠信息</div>
                <div class="seller-text row">
                    #{text}
                </div>
                <i class="closed"></i>
            </div>
        </div>"""
    $("body").append(html)
    if img_url == undefined
        tempSrc = $('#wx_pic img').attr("src")
        $(".seller-img img").attr("src",tempSrc)

###
$('.seller-discount').click( ->
    showMsg(this.oldHtml,@img_url);
    $('.closed').click( ->
        $("#show-dialog").remove()
    )
)
###



# 新版优惠券弹窗
cartShowCoupons = (obj,temp) ->
    # console.log(obj)
    tempA = temp
    contStr = ""
    # test
    if obj.length != 0
        for value,i in obj
            cuponType = "通用券"
            switch value.CouponType
                when "2" then couponType = "品类券"
                when "3" then couponType = "品牌券"
                when "4" then couponType = "单品券"
                else
            contStr += """
                <li key="#{i}" couponId="#{value.ID}" couponType="#{value.CouponType}" class = "have#{value.HasCollect}">
                    <div class="cart-coupon-left">
                        <div class="cart-coupon-price"><span style="font-size:1.2rem;">&yen;</span>#{value.CouponPrice}</div>
                        <div class="cart-coupon-activity">满#{value.ActivityPrice}元使用</div>
                    </div>
                    <div class="cart-coupon-right">
                          <p class="cart-coupon-subtitle">#{value.SubTitle}</p>
                          <p class="cart-coupon-time">#{value.BeginTime}-#{value.EndTime}</p>
                          <button class="pure-button-cart">领取</button>
                          <button class="pure-button-cart">已领取</button>
                    </div>
                  </li>
              """
    else
        showDialog "暂时没有优惠券可以领取"
        $(".right .showCoupon").css("display","none")
        return
        # contStr = """
        #         <li class="no-have">
        #         <div>暂时没有优惠券</div>
        #       </li>"""

    htmlStr = """
    <div class="zhezhao">
    <div class="coupon-box">
      <span class="closed">关闭</span>
      <h3>可领优惠券</h3>
      <div class="list-box">
        <ul class="coupon-list">
          #{contStr}
        </ul>
      </div>
    </div>
  </div>"""
    $("body").append(htmlStr)
    $(".coupon-box").css "transition":"0.5s"
    $(".coupon-box").css "transform":"translateY(100%)"
    setTimeout ->
        $(".coupon-box").css "transform":"translateY(0)"
        ,20


    # 优惠券加事件
    isOK = false
    window.getCerificationStatus 2,->
      isOK = true;
    $(".coupon-list li").click ->
        # if !isOK
        #   window.isCerificationTip("认证才能领取优惠券！")
        #   return
        if $(@).hasClass "have1"
            # showDialog "该优惠券已经领取过了"
            return
        that = @
        id = $(@).attr('couponId')
        url = "/coupons/#{id}/collect"
        $.ajax {
            type: "POST",
            url: url,
            dataType: "json",
            success: (data)->
                if data.status == "ok"
                    $(that).addClass "have1"
                    temp["couponObj"][$(that).attr("key")]["HasCollect"] = 1;
                    showDialog "领取成功。"
                else
                    showDialog data.message , ->
                        window.location.reload()
            error: (e)->
              alert(e.message);
        }
     # 给弹窗上的按钮加事件
    $(document).on 'click','.zhezhao .coupon-box .closed', ->
      $(".zhezhao").remove()


$(".showCoupon").on "click", ->
    that = @
    if !@.flag
        companyId = $(@).attr("companyId")
        $.ajax {
            type: "GET",
            url: "/coupons/universal",
            dataType: "json",
            data: "company_id=#{companyId}"
            success: (data)->
                if data.status == "ok"
                    that.couponObj = data.data
                    cartShowCoupons data.data,that
                    that.flag = true

            error: (e)->
              showDialog e.message
        }
    else
        cartShowCoupons(@.couponObj,@)


# 单独的购物车方法
class _setAmountCart
    add: (selector) ->
        if selector instanceof jQuery
            $selector = selector
        else
            $selector = $(selector)
        val = (parseInt($selector.val()) or 0) + 1
        minBuyNum = $selector.parent().attr("data-min-buycount")
        if val < minBuyNum
          val = minBuyNum
        $selector.val(val).trigger("change")
        #toGather()
        #setSellerDiscount()
    reduce: (selector) ->
        # console.log("购物车-")
        if selector instanceof jQuery
            $selector = selector
        else
            $selector = $(selector)
        val = parseInt($selector.val()) or 0
        minBuyNum = $selector.parent().attr("data-min-buycount")
        id = $selector.attr("data-id")
        if val-0 <= minBuyNum && $selector.parents(".item-console").length == 0
            showDialog
              cancelText: '确定'
              yesText: '取消'
              msg: "小于最小起订量,您确定删除该商品吗?"
              position: "atButtom"
              cancel: ->
                $.deleteJSON "/carts/#{id}", (o) ->
                  $("#product-#{id}").remove()
                  reCalculate()
                  setSellerDiscount()
                  if $(".goods").length == 0
                    removeCartBox()
                  else
                    $(".cart-product-box").each ->
                      if $(@).find(".cart-product").length == 0
                        $(@).remove()
              callback: ->
                $("#product-#{id} input").val $("#product-#{id} input").attr("num")
            $("#msg-box").css("transform","translateY(0)")
            setTimeout ->
              $("#msg-box").css("transform","translateY(-100%)")
            ,0
            return
        val = Math.max(val - 1, 0)
        if val < minBuyNum
          val = minBuyNum
        $selector.val(val).trigger("change")
        #toGather()
        #setSellerDiscount()
@setAmountCart = new _setAmountCart

$ ->
  setZero = () ->
    $(".cart-product-box").each (index,item) ->
      $(item).find(".product-item-price .price").html("小计:¥0.00").next().hide()

  #批量删除商品
  $(".edit-lpt").on "click", ->
    if $(@).html() == "编辑"
      $(".price-amount").hide()
      $(".batch-delete").show()
      #所有选中按钮改为未选中状态
      cartItemCount = $(".cart-product").length
      checkedItemCount = $(".cart-product.checked").length
      if cartItemCount > 0
        #reCalculate()
        if cartItemCount >= checkedItemCount
          $(".cart-product").removeClass("checked")
          $("#shop-cart").removeClass("checked")
          $(".product-seller").removeClass("checked")
          $.putJSON "/carts/uncheck_all",(o) ->
            if o.status == 'ok'
              reCalculate()
              updateProductItemPrice()
      setZero()
      $(@).html("完成")
    else
      $(".price-amount").show()
      $(".batch-delete").hide()
      #所有选中按钮该为选中状态
      cartItemCount = $(".cart-product").length
      checkedItemCount = $(".cart-product.checked").length
      if checkedItemCount == 0 || checkedItemCount != 0
        #reCalculate()
        $(".cart-product").addClass("checked")
        $("#shop-cart").addClass("checked")
        $(".product-seller").addClass("checked")
        $.putJSON "/carts/check_all", (o) ->
          if o.status == 'ok'
            reCalculate()
            if $(".goods").length == 0
              emptyCart()
            updateProductItemPrice()
            if $(".cart-product-box").length == 0
              setSellerDiscount()
      $(@).html("编辑")
  $(".batch-delete").on "click", ->
    if $(".cart-product.checked").length == 0
      showDialog "您未选中任何商品"
    else
      showDialog
        cancelText: '取消'
        yesText: '确定'
        msg: '确定删除选中商品?'
        position: 'center'
        callback: ->
          idArr = []
          idStr = ""
          $(".cart-product.checked").each (index,item)->
            id = item.dataset.ckey
            $("#product-#{id}").remove()
            reCalculate()
            $(".cart-product-box").each ->
              if $(@).find(".cart-product").length == 0
                $(@).remove()
            if $(".goods").length == 0
              removeCartBox()
            idArr.push(id)
            idStr = idArr.join(",")
          $.deleteJSON "/carts", ids:idStr, (o) ->
            if o.status == "ok"
              console.log "删除成功"
            else
              console.log o

        cancel: ->
          $(".price-amount").show()
          $(".batch-delete").hide()
          $(@).html("编辑")

  #套餐详情
  $(".cart-product .folding").each (index,item) ->
    $(item).on "click", ->
      id = @.parentNode.dataset.ckey
      console.log id
      $div = $("#product-#{id}")
      if $(@).hasClass("on")
        $(@).removeClass("on")
        $div.find(".sub-cart-products").removeClass("flex")
      else
        $(@).addClass("on")
        $div.find(".sub-cart-products").addClass("flex")
  #满赠活动
  setSellerDiscount()

  #店铺样式控制
  $(".cart-product-box").each (index,item) ->
    $(item).find(".cart-product").each (index1,item1) ->
      if index1 == 0
        $(item1).find(".content").css("margin-top","-1px")

  #失效商品
  $(".remove").on "click", ->
    $goods = $(@).parents(".goods")
    id = $goods.get(0).dataset.ckey
    showDialog
      cancelText: '确定'
      yesText: '取消'
      msg: "确定删除该商品?"
      position: "atButtom"
      cancel: ->
        $.deleteJSON "/carts/#{id}",(o) ->
          $("#product-#{id}").remove()
          if $(".goods").length == 0
            $(".empty-box").hide()
            $(".cart-product-box").each ->
              if $(@).find(".cart-product").length == 0
                removeCartBox()
      callback: ->
        console.log "取消删除"

  #清空失效商品
  $(".empty-lpt").on "click", ->
    showDialog
      cancelText: "确定"
      yesText: "取消"
      msg: "确定清空失效商品?"
      position: "atButtom"
      cancel: ->
        str = ""
        failureIdArr = []
        $(".goods").each (index,item) ->
          failureId = item.dataset.ckey
          $("#product-#{failureId}").remove()
          failureIdArr.push(failureId)
          str = failureIdArr.join(",")
          $(".failure-list").hide()
        delay ->
          $.deleteJSON "/carts", ids:str, (o) ->
            if o.status == "ok"
              if $(".cart-product-box").length == 0
                #$(".failure-list").hide()
                $("main.cart").html('
                        <div class="line"></div>
                        <div class="no-content center-align">
                          <i class="empty-img"></i>
                          <span class="sp_1 jhb-grey">购物车肚子空空</span>
                          <span class="sp_2 jhb-grey">挑点什么呢？</span>
                          <a class="pure-button jhb-grey button-small" href="/products/list">去逛逛</a>
                        </div>
                    ')
      callback: ->

      $("#msg-box").css("transform","translateY(0)")
      setTimeout ->
        $("#msg-box").css("transform","translateY(-100%)")
      ,0

  #滚动时 店铺置顶
  $(window).scroll ->
    $(".cart-product-box").each (index,item) ->
      scrollTop = $(document.body).scrollTop()
      if $(item).offset().top < scrollTop
        $(item).find(".product-seller").css({
          "position": "fixed",
          "top": "4.4rem",
          "z-index": "9"
        })
        $(@).find(".zhanwei").show()
      else
        $(item).find(".product-seller").css({
          "position": "relative",
          "top": "0",
          "z-index": "0"
        })
        $(@).find(".zhanwei").hide()

  #去凑单
  $(".cart-product-box").each (index,item) ->
    $(@).find(".assem-products").on "click", ->
      $subprice = $(@).parents(".cart-product-box").find(".product-item-price .price").html().substring(4)
      localStorage.setItem("Index",index)
      localStorage.setItem("Subprice",$subprice)
      #localStorage.removeItem("name")








