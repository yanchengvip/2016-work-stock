# //= require vendors/wptr.1.1
# //= require vendors/hammer.2.0.4
$ ->
    runSlider()
    addressReady()
    topButtonReady()
    # setTopBarColor('#E62E46')

    # 头条信息滚动 及字数限制
    $(".headlines-cont strong").each ->
        htmlStr = $(@).html()
        if htmlStr.length > 16
            htmlStr = htmlStr.slice(0,15) + "..."

        $(@).html(htmlStr)
    tempNum = 0
    $tempUl = $(".headlines-cont ul")
    $tempUl.append($(".headlines-cont li").eq(0).clone())
    liNum = $(".headlines-cont li").length
    liHeight = $(".headlines-cont li").height()
    setInterval( ->
    		tempNum -= liHeight
    		if tempNum <= -liHeight * liNum
    			$tempUl.css("top",0)
    			tempNum = -liHeight

    		$tempUl.animate({"top":tempNum})
    	,2000)
	# 下方弹出购买框
	$("main").on "click", ".cont-item", (e) ->
        # id = $(@).attr("id").slice(2)
        $el = $(e.target)
        if $el.hasClass("buy-button") or $el.parent().hasClass("buy-button")
            addToCart($(@).find(".action")[0], id, 1)
        else if $el.parents().hasClass("item-console")

        else
            showPopup(@)




# 宫格导航字适应排列

switch $(".gg-nav").attr("data-count")
    when "4" then  $(".gg-nav").addClass("gg-four")
    when "2" then $(".gg-nav").addClass("gg-two")
$(".headlines").css("marginBottom","0.8rem").nextAll().css("marginBottom","0.8rem")



# 猜你喜欢下拉刷新
noMore = false
isLoading = false
page = 1
floorID = $(".think-love").attr("data-id")
$(document).scroll ->
    if isLoading || $(".think-love").length == 0
        return
    bodyHeight = document.documentElement.clientHeight
    thinkloveHeigh = $(".think-love").height()
    thinkloveTop = $(".think-love")[0].getBoundingClientRect().top
    if bodyHeight - thinkloveHeigh + 180 > thinkloveTop
        $(".think-love .loading-text").remove()
        if noMore
            $(".think-love").append('<p class="loading-text" style="text-align:center">没有更多商品了</p>')
            isLoading = true
        else
            isLoading = true
            $(".think-love").append('<p class="loading-text" style="text-align:center">加载中...</p>')
            getMore ->
                isLoading = false
                $(".think-love .loading-text").remove()


getMore = (fn)->
    page += 1
    url = "/home/recommend?floor_id=#{floorID}&page=#{page}"
    str = ""
    $.getJSON url, (o) ->
        cornerMark = ""
        cartNum = 0
        showConsole = ""
        minBuy = 1
        if o.data.length < 4
            noMore = true
        for item in o.data
            title = item.name
            speci = item.specification
            minBuy = item.min_buy_count || 1
            if title.length > 28
                title = title.slice(0, 25) + '..'
            if item.corner_mark
              cornerMark = "<i class='img-tip'>item.corner_mark</i>"
            if item.cart_num > 0
              cartNum = item.cart_num
              showConsole = "show-console"
            else
              cartNum = 0
              showConsole = ""
            str += """
                  <li class="cont-item" data-data='#{item.list_attrs_json}' id="p-#{item.id}">
                  <div class="item-img">
                    <img src="#{item.cover}">

                  </div>
                  <div class="item-text">
                    <div class="text-top">
                      <h3 class="text-title">#{title}</h3>
                    </div>
                    <div class="price"><strong class="red-text">¥#{item.price}<i>/#{item.unit}</i></strong>
                      <div class="item-console #{showConsole}">
                        <a href="javascript:;" onclick="setAmount.add('#{item.id}');" class="add-item">＋</a>
                        <div class="item-num" data-min-buycount="#{item.min_buy_count}">
                          <input id="#{item.id}" class="number" num="#{cartNum}" value="#{cartNum}" data-id="#{item.id}" type="num" disabled>
                        </div>
                        <a href="javascript:;" onclick="setAmount.reduce('#{item.id}')" class="remove-item">－</a>
                      </div>
                    </div>
                  </div>
                  </li>
                  """
        $(".think-love .cont-items").append(str)
        fn and fn()







# 补零
buLing = (num)->
    if(num < 10)
        return "0"+num
    else
        return num

# 秒杀时间到计时
displayTime = ->
    clock = $(".seckill-time")
    endTime = new Date($(".sckill-cont").attr("data-time"))
    now = new Date()
    leftTime = endTime.getTime() - now.getTime()
    leftTime = parseFloat(leftTime/1000)
    o = Math.floor(leftTime/3600)
    d = Math.floor(o/24)
    m = Math.floor(leftTime/60%60)
    s = Math.ceil(leftTime%60)

    if s < 0
        clock.html("结束")
        return
    else
      clock.html(buLing(o) + ":"+ buLing(m) + ":" + buLing(s) )
      setTimeout(displayTime,100)


if $(".sckill-cont")
    displayTime()
if $(".r-top p").length > 0
  pStr = $(".r-top p").eq(0).html().replace(/\s+/ig,"<br/>")
  $(".r-top p").eq(0).html(pStr)


# 周年庆时间填写
writeTime =(d,o,m,s) ->
  $(".anniver-time .day").html buLing(d||0)
  $(".anniver-time .hour").html buLing(o||0)
  $(".anniver-time .minute").html buLing(m||0)
  $(".anniver-time .second").html buLing(s||0)
# 周年庆开始倒计时

if @timeOnlyOne
  timeServer = new Date($(".time-box").attr("data-time")).getTime()

anniverStart = ->
  endTime = new Date("2016/10/16 00:00:00")
  leftTime = endTime.getTime() - timeServer
  leftTime = parseFloat(leftTime/1000)
  o = Math.floor(leftTime/60/60)
  d = Math.floor(o/24)
  h = Math.floor(leftTime/60/60 - 24*d)
  m = Math.floor(leftTime/60%60)
  s = Math.ceil(leftTime%60)
  if s < 0
    writeTime()
    return
  else
    writeTime(d,h,m,s)
    timeServer += 1000
    setTimeout(anniverStart,1000)
# 周年庆结束倒计时
# 周年庆开始倒计时
anniverEnd = ->
  endTime = new Date("2016/10/21 00:00:00")
  leftTime = endTime.getTime() - timeServer
  leftTime = parseFloat(leftTime/1000)
  o = Math.floor(leftTime/60/60)
  d = Math.floor(o/24)
  h = Math.floor(leftTime/60/60 - 24*d)
  m = Math.floor(leftTime/60%60)
  s = Math.ceil(leftTime%60)
  if s < 0
    writeTime()
    return
  else
    writeTime(d,h,m,s)
    timeServer += 1000
    setTimeout(anniverEnd,1000)


if @timeOnlyOne
  if $(".anniver-start").length != 0
    anniverStart()
  else if $(".anniver-end").length != 0
    anniverEnd()
  @timeOnlyOne = false


# 认证

$ ->
  closedCertifiedTip()
  $(".certified-box").click ->
    $("#certified-tip").remove()
    className = $(@).attr("id")
    tipTitle = ""
    tipBottom = ""
    tipBtn = ""
    tipCont = ""
    if className == "certified-ing"
      tipTitle = "审核中..."
      # tipBottom = """<div class="tip-bottom">1小时内未审核，您将获得慢必赔偿券</div>"""
      tipBtn = """<a href="javascript:closedCertifiedTip();" class="tip-btn">继续进货</a>"""
    else if className == "certified-success"
      if $(@).attr("first")
        price = $(@).attr("price")
        tipCont = """<div class="cont">&yen;#{price}</div>"""
      else
        tipCont = """<div class="cont">&nbsp;</div>"""
        className = "success-again"
      tipTitle = "恭喜，认证成功！"
      tipBtn = """<a href="javascript:closedCertifiedTip();" class="tip-btn">确定</a>"""
    else if className == "certified-faild"
      text = $(@).attr("val")
      tipTitle = "抱歉，审核未通过！"
      tipBottom = """<div class="tip-bottom">原因:<br>#{text}</div>"""
      tipBtn = """<a href="/my/address" class="tip-btn">去修改</a>"""
    tipHtml = """
      <div id="certified-tip">
        <div class="shadown"></div>
        <div class="tip-box #{className}">
          <a href="javascript:closedCertifiedTip()" class="closed"></a>
          <div class="tip-cont">
            <div class="tip-top">
              <div class="img-box"></div>
              #{tipCont}
            </div>
            <h2 class="tip-title">#{tipTitle}</h2>
            #{tipBottom}
          </div>
          #{tipBtn}
        </div>
      </div>
      """
    $("body").append tipHtml

exampleLoadingFunction = ->
  new Promise((resolve, reject) ->
    # Run some async loading code here
    if true
      $("#ptr .genericon").addClass("move")
      if location.pathname == "/"
        window.location.href = "/"
      if location.pathname == "/products/list"
        if $(".main-list-item").length != 0
          window.loadMore true,->
            $("body").attr("class","")
            $("#ptr .genericon").removeClass("move")
        else
          $("body").attr("class","")
          $("#ptr .genericon").removeClass("move")
  )


$ ->
  # 超时优惠券弹窗
  nowData = new Date();
  dataStr = nowData.getFullYear() + "-" + (nowData.getMonth() + 1) + "-" + nowData.getDate()
  expiredCoupon = localStorage.getItem "expiredCoupon"
  if  !(expiredCoupon == dataStr)
    $.getJSON "/notice/will_dated_coupons", (o)->
      if o.status == "ok" && o.data.content
        tempHtml = """
            <div class="expiredCoupon-tip">
              #{o.data.content}
            </div>
        """
        $("main.index").append tempHtml
        $(".expiredCoupon-tip").addClass("move")
        localStorage.setItem "expiredCoupon", dataStr
        setTimeout ->
          $(document).on "touchstart", ->
            $(".expiredCoupon-tip").removeClass("move")
            setTimeout ->
              $(".expiredCoupon-tip").remove()
            ,400
        ,500
