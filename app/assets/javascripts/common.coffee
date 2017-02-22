doc = document.documentElement
clientWidth = Math.min(doc.clientWidth, 640)
doc.style.fontSize = 20 * (clientWidth / 640) + 'px'

$ =>
    @FastClick and @FastClick.attach(document.body)

@isAndroid = ->
    /Android/i.test(navigator.userAgent)

@isiOS = ->
    /iPhone|iPad|iPod/i.test(navigator.userAgent)

@isInApp = ->
    /jinhuobao/i.test(navigator.userAgent) or Boolean(window.Android) or (window.webkit and window.webkit.messageHandlers)

@isWechat = ->
    /MicroMessenger/i.test(navigator.userAgent)

@isTelValid = (tel) ->
    if tel.length > 11
      showDialog "手机号长度超过11位"
      return false
    else if tel.length < 11
      showDialog "手机号长度不到11位"
      return false
    if (tel and /^1\d{10}$/.test(tel))
      return true
    else
      showDialog "手机号格式不正确"
      return false
@isPhoneValid = (phone) ->
    phone and (/^\d{11}$/.test(phone) or /^\d{8}$/.test(phone))

@$input = (name) ->
    $("input[name='#{name}']")

@jumpTo = (url) ->
    location.href = url

ID = null
@delay = (run) ->
    clearTimeout ID
    ID = setTimeout ->
        run()
    , 250

Date::Format = (fmt) ->
  o =
    'M+': @getMonth() + 1
    'd+': @getDate()
    'h+': @getHours()
    'm+': @getMinutes()
    's+': @getSeconds()
    'q+': Math.floor((@getMonth() + 3) / 3)
    'S': @getMilliseconds()
  if /(y+)/.test(fmt)
    fmt = fmt.replace(RegExp.$1, (@getFullYear() + '').substr(4 - (RegExp.$1.length)))
  for k of o
    if new RegExp('(' + k + ')').test(fmt)
      fmt = fmt.replace(RegExp.$1, if RegExp.$1.length == 1 then o[k] else ('00' + o[k]).substr(('' + o[k]).length))
  fmt

@parseDate = (s, format) ->
    #"yyyy-MM-dd hh:mm:ss"
    new Date(Date.parse(s)).Format(format)

_ajax = (url, data, callback, action_method) ->
    if $.isFunction data
        callback = data
        data = {}

    dataType = null
    if action_method != "get"
        data = JSON.stringify data
        dataType = "json"

    $.ajax url,
        type: action_method
        dataType: "json"
        data: data
        contentType: 'application/json'
        success: (o) ->
            if o.error_code and o.error_code == "IsNotVerified"
                location.href = "/sign_in"
            else
                callback and callback(o)
        error: (o) ->
            console.log o
            window.hideLoading()
        complete: ->


$.extend
  getJSON: (url, data, callback ) ->
    _ajax url, data, callback, "get"

  postJSON: (url, data, callback) ->
    _ajax url, data, callback, "post"

  putJSON: (url, data, callback) ->
    _ajax url, data, callback, "put"

  patchJSON: (url, data, callback) ->
    _ajax url, data, callback, "patch"

  deleteJSON: (url, data, callback) ->
    _ajax url, data, callback, "delete"

# $.fn.extend
#   shake: ->
#     [count, distance, duration] = [2, 10, 280]
#     @.each ->
#       $(@).css("position","relative")
#       for x in [1..count]
#         $(@).animate({left:(distance*-1)}, (((duration/count)/4)))
#             .animate({left:distance}, ((duration/count)/2))
#             .animate({left:0}, (((duration/count)/4)))

$.fn.scrollTo = (target, options, callback) ->
  if typeof options == 'function' and arguments.length == 2
    callback = options
    options = target
  settings = $.extend({
    scrollTarget: target
    offsetTop: 20
    duration: 500
    easing: 'swing'
  }, options)
  @each ->
    scrollPane = $(this)
    scrollTarget = if typeof settings.scrollTarget == 'number' then settings.scrollTarget else $(settings.scrollTarget)
    scrollY = if typeof scrollTarget == 'number' then scrollTarget else scrollTarget.offset().top + scrollPane.scrollTop() - parseInt(settings.offsetTop)
    scrollPane.animate { scrollTop: scrollY }, parseInt(settings.duration), settings.easing, ->
      if typeof callback == 'function'
        callback.call this


@imgFly = (url, start, end, callback) ->
    if end == undefined
        callback and callback()
        return
    left = start.getBoundingClientRect().left
    top = start.getBoundingClientRect().top
    img = new Image()
    img.src = url
    img.className = "cloned-img"
    $("body").append(img)
    $(".cloned-img").fly
        start:
            {
                "left":left
                "top":top
            }
            # getPosition start

        end: getPosition end
        speed: 1
        onEnd: ->
            $(".cloned-img").remove()
            callback and callback()

@getPosition = (element) ->
    xPosition = 0
    yPosition = 0
    while element
        xPosition += element.offsetLeft - (element.scrollLeft) + element.clientLeft
        yPosition += element.offsetTop - (element.scrollTop) + element.clientTop
        element = element.offsetParent

    left: xPosition
    top: yPosition

@runInOrder = (li) ->
  if li.length > 0
    toRun = li.reverse().pop()
    arg = null
    if toRun instanceof Array
      [toRun, arg] = toRun
    toRun arg, ->
        if li.length > 0
            li.reverse()
            runInOrder li
#动态改变奖励的值 函数
@promotion = () ->
    $.getJSON "/carts/activity_products",(o)->
        if o.status == "ok"
            localIndex = parseFloat localStorage.getItem('Index')
            obj = o.data.carts_group
            $(obj).each (index,item) ->
                $subtotalCart = $(".price-total .subtotal").html()
                $subtotalCart = parseFloat "#{$subtotalCart}"
                if !isNaN(localIndex)
                    amountOfActivity = obj[localIndex].activities_top
                len = $(amountOfActivity).length
                $(amountOfActivity).each (index1,item1) ->
                    if $(amountOfActivity)[index1 - 1]
                        previous = $(amountOfActivity)[index1 - 1].activity_price
                    if previous == undefined
                        previous = 0
                    previous = parseFloat previous
                    price = parseFloat item1.activity_price
                    beginPrice = parseFloat amountOfActivity[0].activity_price
                    lastPrice = parseFloat amountOfActivity[len - 1].activity_price
                    if previous <= $subtotalCart < price
                        if $subtotalCart < beginPrice
                            if item1.type == 4
                                $(".statistic .discount").html("购满 <span>#{price}</span>元,赠送 <span>#{item1.activity_product}</span>")
                            else if item1.type == 2
                                $(".statistic .discount").html("购满 <span>#{price}</span>元,减免 <span>#{item1.activity_product}</span>元")
                            else
                                console.log "第一种状态"
                        else if $subtotalCart >= beginPrice
                            prevItem = amountOfActivity[index1 - 1]
                            if prevItem.type == 4
                                $(".statistic .discount").html("已购满 <span>#{amountOfActivity[index1 - 1].activity_price}</span>元,已赠送 <span>#{amountOfActivity[index1 - 1].activity_product}</span>")
                            else if prevItem.type == 2
                                $(".statistic .discount").html("已购满 <span>#{amountOfActivity[index1 - 1].activity_price}</span>元,已减免 <span>#{amountOfActivity[index1 - 1].activity_product}</span>元")
                            else
                                console.log "第二种状态"
                    else
                        if $subtotalCart >= lastPrice
                            if item1.type == 4
                                $(".statistic .discount").html("已购满 <span>#{amountOfActivity[len - 1].activity_price}</span>元,已赠送 <span>#{amountOfActivity[len-1].activity_product}</span>")
                            else if item1.type == 2
                                $(".statistic .discount").html("已购满 <span>#{amountOfActivity[len - 1].activity_price}</span>元,已减免 <span>#{amountOfActivity[len-1].activity_product}</span>元")
                            else
                                console.log "第三种状态"
                        else

                    ###
                    if previous <= $subtotalCart <= price
                        if item1[index1 - 1]
                            gived = item1[index1 - 1].activity_product
                        theDiff = parseFloat (price - $subtotalCart).toFixed(2)
                        newGift = item1.activity_product
                        beginPrice = parseFloat amountOfActivity[0].activity_price
                        if $subtotalCart <= beginPrice
                            if item1.type == 4
                                $(".statistic .discount").html("再买<span>#{theDiff}</span>元,赠送<span>#{newGift}</span>")
                            else if item1.type == 2
                                $(".statistic .discount").html("再买<span>#{theDiff}</span>元,减免<span>#{newGift}</span>")
                        else
                            if amountOfActivity[index1 - 1].type == 4
                                $(".statistic .discount").html("已赠<span>#{amountOfActivity[index1 - 1].activity_product}</span>,再买<span>#{theDiff}</span>元,换赠<span>#{newGift}</span>")
                            else if amountOfActivity[index1 - 1].type == 2
                                $(".statistic .discount").html("已减免<span>#{amountOfActivity[index1 - 1].activity_product}</span>,再买<span>#{theDiff}</span>元,换赠<span>#{newGift}</span>")
                    else
                        console.log "哈哈哈"
                    ###

class _setAmount
    add: (productId,num) ->
        $selector = $("#"+productId)
        $selectorBox = $("#"+"p-#{productId}")
        val = (parseInt($selector.val()) or 0)
        amount = 1
        if val == 0
          amount = JSON.parse($selectorBox.get(0).dataset.data).min_buy_count
        val = val + 1
        minBuyNum = $selector.parent().attr("data-min-buycount")
        maxBuyNum = $selector.parent().attr("data-max-buycount")
        if val < minBuyNum
          val = minBuyNum
        # $selector.parents(".item-console").addClass("show-console")
        # $selector.val(val).trigger("change")

        if maxBuyNum && maxBuyNum-0 != -1
          if val > maxBuyNum-0
            Materialize.toast "限购#{maxBuyNum}", 2000
            return
        $("input[data-id='"+productId+"']").val(val).parents(".item-console").addClass("show-console")
        $selector.trigger("change")
        if $selector.attr("num")-0 == 0 || $selector.attr("num") == undefined
          addToCart($("#p-#{productId}")[0],productId,val)
        else
          updateNum productId,val
        # 凑单
        num = num || 0
        if isNaN num or isFinite num
          num = 0
        num = parseFloat(num).toFixed(2)
        $subprice = $(".price-total .subtotal").html()
        $subprice = parseFloat($subprice)  + ("#{num}" - 0)*amount
        $subprice = $subprice.toFixed(2)
        if JSON.parse($selectorBox.get(0).dataset.data).stock >= val || JSON.parse($selectorBox.get(0).dataset.data).stock == undefined
          if JSON.parse($selectorBox.get(0).dataset.data).stock > 0 || JSON.parse($selectorBox.get(0).dataset.data).stock == undefined
            $(".price-total .subtotal").html "#{$subprice}"
        promotion()

    reduce: (productId,num) ->
        #动态改变奖励商品
        $selector = $("#"+productId)
        $selectorBox = $("#"+"p-#{productId}")
        val = parseInt($selector.val()) or 0
        minBuyNum = $selector.parent().attr("data-min-buycount")
        val = Math.max(val - 1, 0)
        if val < minBuyNum
          val = 0
          # $selector.parents(".item-console").removeClass("show-console")
          $("input[data-id='"+productId+"']").parents(".item-console").removeClass("show-console")
        # $selector.val(val).trigger("change")
        $("input[data-id='"+productId+"']").val(val)
        $selector.trigger("change")
        updateNum productId,val
        #凑单
        amount = 1
        if val == 0
          amount = JSON.parse($selectorBox.get(0).dataset.data).min_buy_count
          console.log amount
        num = num || 0
        if isNaN num or isFinite num
          num = 0
        num = parseFloat(num).toFixed(2)
        $subprice = $(".price-total .subtotal").html()
        $subprice = parseFloat($subprice) - ("#{num}" - 0)*amount
        $subprice = $subprice.toFixed(2)
        $(".price-total .subtotal").html "#{$subprice}"
        promotion()

@setAmount = new _setAmount

@timeOnlyOne =  true
$ ->
  @lptOn = true

$cartPrice = ->
    $(".cart-price")

$cartNum = ->
    $(".cart-num")


updateText = (price) ->
    if not price
        price = $cartPrice().text() - 0
    if price == 0
        msg = "亲，购物车是空的！要进货不？"
    # else if price < leastOrderMoney`
    #     msg = "订单不满#{leastOrderMoney}元，无法配送哦！"
    else
        msg = "一机在手，进货无忧"
    $(".cart-text").html msg

class _Cart
    getAmount: ->
        $cartNum().text() - 0

    setAmount: (o) ->
        $cartNum().html o

    getPrice: ->
        parseFloat $cartPrice().text()

    setPrice: (o) ->
        o = parseFloat o
        if isNaN o or isFinite o
            o = 0
        if o != o.toFixed(2)
            o = o.toFixed(2)
        $cartPrice().html "#{o}"
        updateText(o)

    setTip: (o) ->
        $(".shop-cart .tip").html ""

    refresh: ->
        $.getJSON "/carts/brief", (o) ->
            price = parseFloat(o.data.price).toFixed(2)
            if isNaN price or isFinite price
               price = 0
            $(".cart-price").html " #{price}"
            updateText(price)
            $(".cart-num").html o.data.num

    update: (o) ->
        $cartPrice().html " #{o.price}"
        updateText(o.price)
        $cartNum().html o.num

@Cart = new _Cart


@addToCart = (button, id, num) ->
    element = document.getElementById "p-#{id}"
    dataset = element.dataset
    num = parseInt num
    if dataset.data
        url = JSON.parse(dataset.data).cover
    else
        url = element.dataset.imageUrl
    data =
        "ProductID": id
        "Number": num

    delay =>
        if @.promise and @.promise.state() == "pending"
            return

    @.promise = $.postJSON "/carts", cart: data, (o) ->
        if o.status == "ok"
            $("input[data-id='"+id+"']").val(num).trigger("change").each ->
              $(@).attr("num",num)
            # $("#"+id).val(num).attr("num",num).trigger("change")
            # console.log(o,"购物成功",num)
            Cart.update(o.data)
            imgFly url, button, document.getElementsByClassName("cart-num")[0], ->
                _vds.push [
                    'AddToCart'
                    '添加购物车'
                ]
                _vds.push [
                    'setPS1'
                    '#{button}"'
                ]
                _vds.push [
                    'setPS2'
                    '#{id}"'
                ]
                _vds.push [
                    'setPS3'
                    '#{num}"'
                ]
                if(document.getElementsByClassName("cart-num")[0] == undefined)
                    Materialize.toast "#{name} 已添加到购物车", 2000

        else if o.message == "NoDefaultAddress"
            showFillAddress()
        else
          # $("#p-#{id} .item-console").removeClass("show-console")
          # $("#"+id).val($("#"+id).attr("num")).trigger("change")
          $("input[data-id='"+id+"']").parents(".item-console").removeClass("show-console")
          inputNum = $("#"+id).attr("num")
          $("input[data-id='"+id+"']").val(inputNum).trigger("change").each ->
            $(@).attr("num",inputNum)
          Materialize.toast o.message, 2000
    false


@updateNum = (productId, num, callback) ->
    num = parseInt num
    delay ->
        $.putJSON "/carts/#{productId}/update_num", num: num, (o) ->
            if o.status == 'ok'
              Cart.update(o.data)
              $("input[data-id='"+productId+"']").val(num).trigger("change").each ->
                $(@).attr("num",num)
              # if num-0 == 0
              #   $(".num.cart-num").html $(".num.cart-num").html()-1
              callback and callback()
            else
              oldNum = $("#"+productId).attr("num") - 0
              $("input[data-id='"+productId+"']").val(oldNum).trigger("change")
              Materialize.toast o.message, 2000

# 阻止快捷加入购物车按钮冒泡
$ ->

    $(".item-console").click (event) ->
        event.stopPropagation()



@setBackUrl = (url) ->
    $("#back").attr("href", url)

@goBack = ->
    urlHistory = JSON.parse(sessionStorage.getItem('urlHistory') or '[]')
    url = urlHistory.pop() or '/'
    if url == location.pathname + location.search
        url = urlHistory.pop() or '/'
    sessionStorage.setItem('urlHistory', JSON.stringify(urlHistory))
    setTimeout ->
      urlArr = ["/carts","/","products/list","/mine","/sign_in","/addresses/new"]
      if isInApp() && (urlArr.indexOf(url) != -1)
        try
          window.APPFn("backToHome")
        catch e
          window.location.href = url
      else
        # Turbolinks.visit(url)
        window.location.href = url
    , 0

    # if (document.referrer.indexOf("/sign_in") > 0) or (document.referrer.indexOf("/sign_up") > 0) or (document.referrer.indexOf("/tel_login") > 0)
    #     location.href = "/"
    # else
    #     history.back()

@APPFn = (fn,data) ->
  if isAndroid()
    if !data
      data = null
    return Android[fn](data);
  else if isiOS()
    if !data
      data = {}
    return window.webkit.messageHandlers[fn].postMessage(data)

@closeFillAddress = ->
    $("#fill-address").remove()

@showFillAddress = ->
    if $("#fill-address").length == 0
        html = """
        <div id="fill-address">
            <a href="javascript:closeFillAddress()" class="close"></a>
            <a href="javascript:closeFillAddress()" class="close-btn"></a>
            <a href="/addresses/new" class="link-btn"></a>
        </div>"""
        $("body").append(html)


@closeSelectAddress = =>
    closeDialog()

@showSelectAddress = ->
    yesCallback = ->
        location.href = "/location"
    options =
        yesText: '去选择'
        msg: '无法获取位置，请手动选择'
        callback: yesCallback
        isAlert: true
    showDialog options

@closeDialog = ->
    $("#show-dialog").remove()


_buildCallback = (options) ->
    opt = options
    window.yesCallback = ->
        if opt.callback
            closeDialog()
            opt.callback()
        else
            closeDialog()

    window.noCallback = ->
        if opt.cancel
            closeDialog()
            opt.cancel()
        else
            closeDialog()

_show = (options) ->
    msg = options.msg
    classStr = options.position
    if $("#show-dialog").length == 0
        buttons = """
            <a class="col s6" href="javascript:noCallback()">#{options.cancelText}</a>
            <a class="col s6 jhb-blue" href="javascript:yesCallback()">#{options.yesText}</a>
            """
            # <a class="" href="javascript:noCallback()">#{options.cancelText}</a>
            # <a class="jhb-red" href="javascript:yesCallback()">#{options.yesText}</a>


        if options.isAlert
            buttons = """
            <a class="col s12 jhb-blue" href="javascript:yesCallback()">#{options.yesText}</a>
            """
            # <a class="jhb-red" href="javascript:yesCallback()">#{options.yesText}</a>
        html = """
        <div id="show-dialog" class="#{classStr}">
            <div id="msg-box">
                <div class="caption">
                    #{msg}
                </div>
                <div class="buttom-group row">
                    #{buttons}
                </div>
            </div>
        </div>"""
        $("body").append(html)

@showDialog = (params, yesCallback, cancelCallback) ->
    options =
        cancelText: '取消'
        yesText: '确定'
        msg: ''
        callback: null
        cancel: null
        isAlert: (arguments.length == 1) and (typeof params == 'string')
        position: 'center'

    if $.isPlainObject(params)
        for k,v of params
            options[k] = v
    else
        options.msg = params
        if yesCallback
            options.callback = yesCallback
        if cancelCallback
            options.cancel = cancelCallback

    _buildCallback(options)
    _show(options)



@showPopup = (self) ->
    if not $("#modal").hasClass("popup")
        modal = """<div id="modal" class="modal bottom-sheet popup">
    <div class="modal-content" id="modal-content">
        <a title="Close" id="modal-close" href="javascript:$('#modal').closeModal();"><i class="iconfont">&#xe60a;</i></a>
        <div class="info clearfix">
            <div class="pic">
                <img alt="" class="responsive-img">
            </div>
            <div class="info-content">
                <h6 class="info-name"></h6>
                <div class="title"><span class="jhb-red price"></span>&nbsp;/<span class="unit"></span></div>

                <p>
                    <span class="min-buy" style="color: #F5A623;"></span>
                </p>
            </div>
        </div>
        <div class="slogan"></div>
        <div class="info-item spec">
            包装规格：<span class="span-box jhb-grey specifiction"></span>
        </div>
        <div class="line"></div>
        <div id="list-sub-products"></div>
        <div class="info-item amount">
            <span>数&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;量：</span>
            <div class="num-box row left">
                <a href="javascript:;" class="btn-reduce col s3">-</a>
                <input type="tel" class="col s6" value="1" id="count">
                <a href="javascript:;" class="btn-add col s3">+</a>
            </div>
        </div>
        <div class="line"></div>
        <a id="popup-confirm" href="javascript:$('#modal').closeModal();">确认</a>
    </div>
  </div>"""
        $("main").append modal
    setTimeout ->
        selected = $(self)
        if selected.find(".out-of-stock,.mask-text").length > 0
            Materialize.toast "补货中", 2000
            return
        modal = $("#modal")
        data = JSON.parse self.dataset.data
        document.getElementById("modal").dataset.data = self.dataset.data
        modal.find(".price").html "&yen;#{data.price}"
        modal.find(".info-name").html "#{data.name}"
        modal.find(".info-speci").html "#{data.specification}"
        modal.find(".unit").html data.unit
        modal.find(".originalPrice").html data.original_price
        specifiction = data.specifiction
        if specifiction
            modal.find(".spec").removeClass("hidden")
            modal.find(".specifiction").html specifiction
        else
            modal.find(".spec").addClass("hidden")
        # 最小起订数量
        minBuy = data.min_buy_count
        modal.find(".min-buy").html ""
        if minBuy > 1
            modal.find(".min-buy").html "#{minBuy}#{data.unit}起订"
        modal.find(".num-box").attr("data-min-buycount",minBuy)
        # 已购物数量
        buyNum = selected.find("input[class='number']").val()
        # console.log buyNum
        modal.find("input").val buyNum
        if buyNum-0 == 0
          $(".btn-reduce").css("color","#f0f0f0").attr("flag","false")
        else
          $(".btn-reduce").css("color","#000").attr("flag","true")
        modal.find("img").attr "src", data.cover
        # if data.max_sale_amount-0 == 0
        #     modal.find(".max-sale-amount").parent().hide()
        # else
        #     modal.find(".max-sale-amount").html data.max_sale_amount
        slogan = data.slogan
        if slogan
            modal.find(".slogan").html "<div class='info-item'>#{slogan}</div><div class='line'></div>"
        else
            modal.find(".slogan").html ""
        #  自营标签
        modal.find(".title i,.title br").remove()
        if data.third_type == 0
            modal.find(".title").prepend "<i class='text-tip'>自营</i><br>"
        sub_products = data.sub_products or []
        sub_products_str = ""
        for sub_product in sub_products
            sub_products_str += """<div class="list-sub-product">#{sub_product.name} x #{sub_product.number}#{sub_product.unit}</div>"""
        $("#list-sub-products").html sub_products_str
        $('#modal').openModal
          dismissible: true
          opacity: .5
          in_duration: 300
          out_duration: 200
          ready: ->
            modal.css("z-index", 1005)

        # 去除绑定事件
        $("#modal .iconfont,.lean-overlay,#popup-confirm").click ->
          $("#modal").unbind();


        if !flag
          selected.find(".number").change ->
            $("#modal input").val $(@).val()
            if $(@).val()-0 == 0
              $(".btn-reduce").css("color","#f0f0f0").attr("flag","false")
            else
              $(".btn-reduce").css("color","#000").attr("flag","true")
          # 加减按钮事件
          $("#modal").on "click",".btn-add", ->
            data = JSON.parse document.getElementById("modal").dataset.data
            # console.log($("#p-#{data.id} .add-item").eq(0))
            $("#p-#{data.id} .add-item").eq(0).click()

          $("#modal").on "click",".btn-reduce", ->
            if $(@).attr("flag") == "false"
              return false;
            data = JSON.parse document.getElementById("modal").dataset.data
            $("#p-#{data.id} .remove-item").eq(0).click()


          # input 输入
          $("#modal input").change ->
            data = JSON.parse document.getElementById("modal").dataset.data
            oldVal = $("#p-#{data.id} input").attr("num")-0
            newVal = parseInt($(@).val())
            newVal = !isNaN(newVal) and newVal or 1
            if newVal <= 0
              updateNum "#{data.id}",0
              $("#p-#{data.id} .item-console").removeClass("show-console")
              $("#p-#{data.id} input").val(0).trigger("change")
              return false
            minBuy = $("#modal .num-box").attr("data-min-buycount")-0
            if newVal < minBuy
              showDialog "该商品最少购买#{minBuy}件"
              $("#p-#{data.id} .item-console").addClass("show-console")
              if oldVal == 0
                addToCart  $("#p-#{data.id}")[0],"#{data.id}",minBuy
              else
                updateNum "#{data.id}",minBuy
              # $("#p-#{data.id} input").val(newVal).trigger("change")
              setTimeout ->
                  $("#show-dialog").remove()
              , 1000
            else
              if oldVal == 0
                addToCart  $("#p-#{data.id}")[0],"#{data.id}",newVal
              else
                updateNum "#{data.id}",newVal
            $("#p-#{data.id} input").parents(".item-console").addClass("show-console")
            $("#p-#{data.id} input").val($(@).val()).trigger("change")

          flag = true
    , 0

@runSlider = =>
    @swipe = new Swipe document.getElementById('slider'),
        auto: 2000
        speed: 800
        callback: (index) ->
            $(".indicator-item.active").removeClass('active')
            $(".indicators>li:nth-child(#{index+1})").addClass('active')
            true

    $(".indicator-item").click ->
        window.swipe.slide(@.dataset.index, 500)

@shareCallback = (o) ->
    alert(o)

@shareToWechat = (url, title, content, callback) =>
    imageUrl = $("#wx_pic").find("img").attr("src")
    callbackName = ''
    if callback
        callbackName = 'f' + Math.floor(Math.random()*10000001)
        window[callbackName] = callback
    if url is undefined
        url = location.href
    if title is undefined
        title = document.title
    if content is undefined
        content = $('meta[name=description]').attr('content') or '想不到的优惠，占不完的便宜'
    if isInApp()
        if isAndroid()
            return Android.toTakeWeixinShare(url, imageUrl, title, content, callbackName)
        else if isiOS()
            data =
                url: url
                imageUrl: imageUrl
                title: title
                content: content
                callback: callbackName
            return window.webkit.messageHandlers.toTakeWeixinShare.postMessage(data)
    @Materialize and @Materialize.toast('请复制网址分享给好友哦', 2000) or alert('请复制网址分享给好友')


@setTopBarColor = (color) ->
    data =
        "color": color
    try
        window.webkit.messageHandlers.setTopBarColor.postMessage data
    catch e

@jumpWithBackButton = (url) ->
    if isInApp()
        try
            if isiOS()
                data =
                    'url': url
                window.webkit.messageHandlers.jumpWithBackButton.postMessage data
            else
                Android.jumpWithBackButton(url)
        catch e
           location.href = url
    else
        location.href = url

@loginCallback = (tel, token) ->
    console.log("login #{tel} #{token}")
    if isInApp()
        try
            if isiOS()
                data =
                    'tel': tel,
                    'token': token
                window.webkit.messageHandlers.loginSuccess.postMessage data
            else
                Android.loginSuccess(tel, token)
        catch e
           console.log(e)

@logoutSuccess = () ->
    console.log('logout')
    if isInApp()
        try
            if isiOS()
                window.webkit.messageHandlers.logoutSuccess.postMessage({})
            else
                Android.logoutSuccess()
        catch e
           console.log(e)

@setCountyName = (name) ->
  element = $("#county-name")
  if name.length > 4
    name = name.slice(0,3) + "..."
  element.text name
  if name.length == 3
    element.addClass("three").removeClass("four")
  else
    element.removeClass("three").addClass("four")


@saveCountyName = (name) ->
  if name
    localStorage.setItem "county-name",name
    $.cookie "county_name",name
@getCountyName = (name) ->
  countyName = decodeURI $.cookie("county_name")
  if countyName
    localStorage.setItem("county-name",countyName)
    return countyName
  else
    return localStorage.getItem("county-name")


@setDepot = (data) ->
  for k, v of data
    $.removeCookie(k, {path: '/products'})
    $.cookie k, v, {expires: 365, path: '/'}


@setInitAddress = ->
    # $.cookie "company_id", "22294f4c-dacc-48d6-aba8-d6c8fbe8cf7e", {expires: 365, path: '/'}
    # $.cookie "depot_id", "f6d48bbd-ef85-4d70-a810-eaf327682c1b", {expires: 365, path: '/'}
    # localStorage.setItem "county-name", "东城区"
    countyName = decodeURI $.cookie("county_name")
    if countyName
      localStorage.setItem "county-name", countyName
    # localStorage.setItem "lastGeoPosition", "北京市-北京市-东城区"
    setTimeout ->
        closeSelectAddress()
        addressReady()
        # location.reload()
    , 0

@addressReady = ->
    countyName = getCountyName()
    if countyName && countyName != "undefined"
        $("#arrow-down").removeClass("hidden")
        setCountyName countyName
    else
        showSelectAddress()

    # setTimeout ->
    #     if $(".fake-search").length > 0
    #         countyName = getCountyName()
    #         $("#arrow-down").removeClass("hidden")
    #         if countyName
    #             setCountyName countyName
    #             getGeoAddress undefined, (o) ->
    #                 lastGeoPosition = localStorage.getItem "lastGeoPosition"
    #                 res = o.addressComponents
    #                 thisGeoPosition = "#{res.province}-#{res.city}-#{res.district}"
    #                 if lastGeoPosition != thisGeoPosition
    #                     if confirm("系统检测到您不在#{getCountyName()}, 是否切换到当前区域")
    #                         updateGeoPosition()
    #         else
    #             updateGeoPosition()
    # , 0


@topButtonReady = ->
    if not isInApp()
        hasClosed = sessionStorage.getItem "closeDownAppButton"
        if not hasClosed
            $("#top-down-button").removeClass("hidden")
            $("header").addClass("down-app")

        $("#top-down-button").click (e) ->
            sessionStorage.setItem "closeDownAppButton", 1
            if $(e.target).hasClass("link")
                $("#top-down-button").addClass("hidden")
                $("header").removeClass("down-app")
            else
                location.href = "/common/wechat_download"

getArugument = (s) ->
  # This function is anonymous, is executed immediately and
  # the return value is assigned to QueryString!
  query_string = {}
  query = window.location.search.substring(1)
  vars = query.split('&')
  i = 0
  while i < vars.length
    pair = vars[i].split('=')
    # If first entry with this name
    if typeof query_string[pair[0]] == 'undefined'
      query_string[pair[0]] = decodeURIComponent(pair[1])
      # If second entry with this name
    else if typeof query_string[pair[0]] == 'string'
      arr = [
        query_string[pair[0]]
        decodeURIComponent(pair[1])
      ]
      query_string[pair[0]] = arr
      # If third or later entry with this name
    else
      query_string[pair[0]].push decodeURIComponent(pair[1])
    i++
  query_string[s]

@hideLoading = ->
    $('#fancybox-loading').hide()

@showLoading = ->
    if $('#fancybox-loading').length == 0
        el = $('<div id="fancybox-loading"><div class="wrapper"><div></div></div></div>').appendTo('body')
    else
        $('#fancybox-loading').show()



# 新人赠送优惠券弹窗
@showCoupons = (value,obj) ->
    price = value.coupon_price
    newLink = "/my/coupons"
    newClass = "no-img"
    newImg = ""
    if value.link
        newLink = value.link
    if value.picture_url
        newClass=""
        newImg = """<img src="#{value.picture_url}" alt="弹窗图片"> """

    if $("#show-dialog").length == 0
        html = """
        <div id="show-dialog" class="hidden">
            <div id="new-signup" class="#{newClass}">
                <i class="closed"></i>
                <div class="price">￥#{price}</div>
                <div class="text">#{price}元新人专享优惠券已放入您的钱包</div>
                <a href="#{newLink}" class="btn"></a>
                #{newImg}
            </div>
        </div>"""
        $("body").append(html)
    $('#show-dialog').removeClass('hidden')
    $("#new-signup .closed").click ->
        $('#show-dialog').remove()
        showFn obj



# 纯图片广告弹窗
@.showImgTip = (value,obj) ->
    #首次显示
    cityId = $.cookie("city_id")
    hasShow = localStorage.getItem "showActivityPopup-" + cityId
    # nowData = new Date();
    # dataStr = nowData.getFullYear() + "-" + (nowData.getMonth() + 1) + "-" + nowData.getDate()
    # if  !(hasShow == dataStr)
    showImgFlag = sessionStorage.getItem('showImgFlag')
    if !showImgFlag
        src = value.picture_url
        href = value.link
        html = """
        <div class="activity-popup" style='display: none;'>
          <div class="mask-shadow"></div>
          <div class="popup-cont"><img src="#{src}" alt="活动广告图片"><i class="closed"></i></div>
        </div>"""
        $("body").append(html)
        $(".popup-cont img:hidden")[0].onload =  ->
          $(".activity-popup").show()
          $(".popup-cont").click (e) ->
              # localStorage.setItem "showActivityPopup-" + cityId, dataStr
              sessionStorage.setItem('showImgFlag',"true")
              if $(e.target).hasClass("closed")
                  $(".activity-popup").hide()
                  showFn obj
              else
                  if href
                      setTimeout ->
                          location.href = href
                      , 0
                  else
                      $(".activity-popup").hide()
                      showFn obj
    else
        showFn obj

#未查看优惠券优惠券弹窗
@.showNoSeeCoupon = (value,obj) ->
    couponList = value.coupons
    link = "/my/coupons"
    if value.link
        link = value.link
    listHtml = ""
    for value,i in couponList
        # console.log value
        if value.LogoUrl
            imgUrl = value.LogoUrl
        else
            imgUrl = $(".responsive-img").attr("src")
        title = value.Title
        subTitle = value.SubTitle
        priceText = ""
        if value.CouponType != 5
            price = value.Price.toString()
            if price.split('.')[1] != undefined
              priceText = '&yen;<span>' + price.split('.')[0] + '</span><i class="small-font">.' + price.split('.')[1] + '</i>'
            else
              priceText = "&yen;<span>#{price}</span>"
        else
            price = (value.CouponDiscount * 10).toFixed(1).toString()
            priceText = "<span>#{price.split('.')[0]}<i>.#{price.split('.')[1]}折</i></span>"
        if title.length > 12
            title = title.slice(0,9) + '...'
        if subTitle.length > 16
            subTitle = subTitle.slice(0,14) + '...'
        listHtml += """
              <li class="">
                <div class="coupon-cont clearfix">
                  <div class="coupon-price left">#{priceText}<div class="coupon-price-amount">满#{value.UseMoney}元使用</div></div>
                  <div class="coupon-state left">
                    <h4>#{value.TypeName}</h4>
                    <div class="endTime">有效期至#{value.EndDate}</p></div>
                  </div>
                </div>
              </li>"""
    html = """
    <div class="nosee-coupon">
        <div class="mask-shadow"></div>
        <div class="coupon-item">
          <div class="title">专享优惠券</div>
          <p class="subtitle">在"我的卡券"页面查看</p>
          <div class="cont">
            <ul class="coupon-list">
                #{listHtml}
            </ul>
          </div>
          <i class="closed"></i>
        </div>
    </div>"""

    $("body").append(html)
    setTimeout ->
      $(".nosee-coupon").show()
    ,300
    $(".nosee-coupon .closed").click ->
        $(".nosee-coupon").remove()
        showFn obj


# 执行弹窗函数
@num = 0
showFn = (obj) ->
    value = obj[@num]
    @num++
    if value
        switch value.type
            when 1 then showImgTip value,obj
            when 3
                if value.coupons && value.coupons.length > 0
                    showNoSeeCoupon value,obj
                else
                    showFn obj
            when 2 then showCoupons value,obj
    else
        @num = 0


# 判断是否弹窗
@isShow = ->
    data = "type=3"
    if location.pathname == '/'
        data = data + ",1"
    # if location.href.indexOf('showCoupons') != -1
    #     data = data + ",2"
    $.getJSON "/popup", data , (data)->
        # console.log(data)
        if data.status == "ok"
            showFn(data.data)


isShow()

$(document).on 'page:load page:restore', ->
    setTimeout ->
        isShow()
    ,0

$(document).on 'page:fetch', ->
    window.showLoading()

$(document).on 'page:receive', ->
    window.hideLoading()

# 隐藏顶部header
@hiddenNavBar = ->
  if $("header").length != 0 && !$("header").hasClass("fake-search")
    $("header").hide()
    # $("body").css("marginTop","-4.4rem")

# 保存页面浏览记录
saveURL = ->
  if window._hmt
      _hmt.push(['_trackPageview', location.pathname + location.search])
  urlHistory = JSON.parse(sessionStorage.getItem('urlHistory') or '[]')
  url = location.pathname+location.search
  if url not in ['/sign_in', '/sign_up', '/tel_login']
      index = urlHistory.indexOf(url)
      if index > -1
          urlHistory.splice(index, 1)
      urlHistory.push(url)
      sessionStorage.setItem('urlHistory', JSON.stringify(urlHistory))

saveURL()
$(document).on 'page:load page:restore', ->
    saveURL()

# 非认证用户提示弹窗
@closedCertifiedTip = ->
  $("#certified-tip").remove()
@isCerificationTip = (tipText)->
  tipHtml = """
    <div id="certified-tip">
      <div class="cerification-box">
        <h2 class="tip-text">#{tipText}</h2>
        <p>认证后享受认证红包，终身优质服务</p>
        <a href="/my/address" class="go-cerification">去认证</a><br>
        <a href="javascript:closedCertifiedTip()" class="giveUp-cerification">放弃认证</a>
      </div>
    </div>
    """
  $("body").append tipHtml
# 判断认证状态
@getCerificationStatus = (statusNum,callback)->
  $.ajax {
      type: "GET",
      url: "/addresses/return_verify_status",
      dataType: "json",
      success: (data)->
        if data.verify_status == statusNum
          callback && callback()
  }



# growing IO 数据统计 嵌入代码
_vds = _vds or []
window._vds = _vds
do ->
  _vds.push [
    'setAccountId'
    '8743a63472281a9d'
  ]
  do ->
    vds = document.createElement('script')
    vds.type = 'text/javascript'
    vds.async = true
    vds.src = (if 'https:' == document.location.protocol then 'https://' else 'http://') + 'dn-growing.qbox.me/vds.js'
    s = document.getElementsByTagName('script')[0]
    s.parentNode.insertBefore vds, s
    return
  return

# 美恰客服
((m, ei, q, i, a, j, s) ->
  m[a] = m[a] or ->
    (m[a].a = m[a].a or []).push arguments
    return
  j = ei.createElement(q)
  s = ei.getElementsByTagName(q)[0]
  j.async = true
  j.charset = 'UTF-8'
  j.src = i + '?v=' + (new Date).getUTCDate()
  s.parentNode.insertBefore j, s
  return
) window, document, 'script', '//static.meiqia.com/dist/meiqia.js', '_MEIQIA'
@_MEIQIA = _MEIQIA
@_MEIQIA 'entId', '17793'
# 在这里开启手动模式（必须紧跟美洽的嵌入代码）
# _MEIQIA('manualInit');
# 关闭邀请窗口
@_MEIQIA 'getInviting', ->
@_MEIQIA 'init'
@_MEIQIA 'withoutBtn'
# @_MEIQIA 'showPanel'
# temp = (temp) ->
#   temp 'showPanel'
# @.onlineService = ->
  # temp(_MEIQIA)
