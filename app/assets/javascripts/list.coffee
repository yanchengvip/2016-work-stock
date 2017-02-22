# //= require vendors/wptr.1.1
# //= require vendors/hammer.2.0.4
$ ->
  addressReady()
  topButtonReady()
  hHeader = $("header").height()
  hAd = $("#main-list-ad").height()
  hFooter = $("footer").height()
  $("main,#main-list-categories, #main-list-page").height($(window).height() - hHeader - hAd - hFooter - 2)
  lastURL = null
  oldURL = null
  pageNo = 0
  hasMore = true
  hasHash = false
  brandArr = []
  sortStr = ''
  brandStr = ''

  triggerHash = location.hash.slice(1) || window.lastHash
  hasHash = window.lastHash || (location.hash.length > 0)
  $(".big-category>a").click ->
      id = @.dataset.id
      # $(@).parent().siblings().removeClass("on").addClass("off")
      $(".small-categories:not(.c-#{@.dataset.id})").hide()
      # $(@).parent().toggleClass("on off")
      if !$(@).parent().hasClass("active")
        $(".big-category.active").removeClass("active closed")
      else
        $(@).parent().addClass("closed").removeClass("active")
      if $(".c-#{@.dataset.id}").toggle().is(":visible")
          $(".big-category").removeClass("closed")
          $(@).parent().addClass("active")
          if $(".c-#{@.dataset.id}").find(".main-list-category-item.active").length == 0
            temp = @
            if !hasHash
              setTimeout ->
                 $(temp).parent().next().find("a").eq(0).click()
              , 0
            hasHash = false

  loading = false
  lastScrollTop = 0
  $(".main-list-items").scroll ->
      if loading
          return
      scrollTop = $(".main-list-items").scrollTop()
      scrolled = $(".main-list-items").height() + scrollTop
      docHeight = $(".main-list-items")[0].scrollHeight
      if scrolled + 40 > docHeight
          if hasMore
              loading = true
              $(".main-list-items").append('<div class="padding load-more">加载中...</div>')

              window.loadMore false, ->
                  loading = false
                  $(".load-more").remove()
          else
              if scrollTop > lastScrollTop
                  window.loading = true
                  setTimeout ->
                  # Materialize.toast "没有更多了", 2000, "", ->
                      lastScrollTop = scrollTop
                      loading = false
                  , 2000

  window.loadMore = (firstTime, callback) ->
      if firstTime
          pageNo = 0
          hasMore = true
      pageNo += 1
      if brandArr.length != 0
        brandStr = "&brand_id="+brandArr.join(",")
      else
        brandStr = ""
      url = "#{lastURL}&page=#{pageNo}"+brandStr+sortStr
      result = ''
      window.showLoading()
      $.getJSON url, (o) =>
          window.hideLoading()
          if o.data.products.length == 0
              hasMore = false
          for item in o.data.products
              outOfStockStr = ''
              originalPrice = """ <del class="jhb-grey"></del>"""
              minBugNum = ''
              showConsole = ""
              if item.cart_num > 0
                showConsole = "show-console"
              imgTip = ''
              textTip = ''
              if item.original_price and item.type != 0
                originalPrice = """ <del class="jhb-grey">￥#{item.original_price}/#{item.unit}</del>"""
              if item.stock <= 0
                  outOfStockStr = '<div class="cover out-of-stock">补货中</div>'
              if item.corner_mark
                  imgTip = """ <i class="img-tip">#{item.corner_mark}</i>"""
              if item.third_type == 0
                  textTip = """ <i class="text-tip">自营</i>"""
              title = item.name
              if title.length > 27
                  title = title.slice(0, 25) + '..'
              if item.min_buy_count > 1
                  minBugNum = """<span style="position: absolute;right:3rem;color:#F5A623;">#{item.min_buy_count}#{item.unit}起订</span>"""
              result += """
              <div class="main-list-item" data-data='#{JSON.stringify(item)}' id="p-#{item.id}">
                  <div class="img">
                      <img src="#{item.cover}">
                      #{outOfStockStr}
                      #{imgTip}
                  </div>
                  <div class="info">
                    <div class="title">#{textTip}<span>#{title}</span></div>
                    <div class="info-wrapper">
                      #{originalPrice}
                      <div class="price-line"><span class="price">￥#{item.price}</span>/#{item.unit}#{minBugNum}

                      </div>

                        <div class="item-console #{showConsole}">
                          <a href="javascript:;" onclick="setAmount.add('#{item.id}','#{item.price}')" class="add-item">＋</a>
                          <div class="item-num" data-min-buycount="#{item.min_buy_count}">
                            <input id="#{item.id}" class="number" data-id="#{item.id}" type="num" num="#{item.cart_num}" value="#{item.cart_num}" disabled>
                          </div>
                          <a href="javascript:;" onclick="setAmount.reduce('#{item.id}','#{item.price}')" class="remove-item">－</a>
                        </div>
                      </div>
                    </div>
                  </div>
              </div>"""

          if result == "" and firstTime
              result = """
                <div class="no-list-item">抱歉，没有找到这个品牌下的商品</div>
                  """
          if firstTime
              $(".main-list-items").html(result)
              callback and callback()
          else
              setTimeout ->
                  $(".main-list-items").append(result)
                  callback and callback()
              , 250

  $(".main-list-category-item:not(.big-category)>a").click ->
      id = @.dataset.id
      location.hash = window.lastHash = $(@).attr("data-id")

      url = "/products?sid=#{id}"
      lastURL = url
      oldURL = url
      self = @
      brandArr = []
      sortStr = ''
      $(".screen-box a").removeClass("check")
      $(".brand").removeClass("open")
      $(".brand span").html "全部"
      $(".sales soan").html "默认"
      $(".brand-shadow").removeClass("show")
      # 加载产品
      window.loadMore true, ->
          $(".main-list-category-item:not(.big-category).active").removeClass("active")
          $(self).parent().addClass("active")
          $(".main-list-items").scrollTop(0)
          # $("#main-list-current-title").text $(self).text()
      # 加载品牌列表
      $.getJSON "/products/return_brand.json?sid=#{id}",(o)->
        if o.status == "ok"
          listStr = ""
          for item in o.data.product_brands
            listStr += """
            <li data-id='#{item.id}'>#{item.product_brand}</li>
            """
          if listStr == ""
            listStr = """
            <li>暂无品牌分类</li>
            """
          $(".brand-list").html listStr
        else
          $(".brand-list").html ""

  # 根据哈希值选择点击按钮 默认第一个
  setTimeout ->
      if hasHash == false
          $(".main-list-category-item:first>a").click()
          # $(".small-categories").eq(0).find(".main-list-category-item:first>a").click()
      else
          # console.log(triggerHash)
          str = "a[data-id=" + triggerHash  + "]:hidden"
          $triggerA = $(str)
          $triggerParent = $triggerA.parent().parent().prev().find("a").eq(0)
          $triggerParent.click()
          setTimeout ->
             $triggerA.click()
          , 0
  , 0


  # 阻止冒泡
  $(".item-console").click (event) ->
      event.stopPropagation()


  # 判断选择品牌的数量 加状态
  brandState = (brandArr)->
    if brandArr.length == 0
      $(".brand").removeClass("check")
      $(".brand span").html "全部"
    else
      $(".brand").addClass("check")
      str = $(".brand-list li[data-id='"+brandArr[0]+"']").text()
      if brandArr.length == 1
        $(".brand span").html str
      else
        $(".brand span").html str+"等"

  # 点击品牌
  $(".brand").click ->
    $(".brand-list li").removeClass("check")
    $(".brand-list li").each ->
      id = @.dataset.id
      if brandArr.indexOf(id) != -1
        $(@).addClass("check")
    brandState(brandArr)
    $(".brand-shadow").toggleClass("show")
    $(@).toggleClass("open")
    # if $(".brand-shadow").hasClass("show")
    #   $(@).addClass("open")
    # else
    #   $(@).removeClass("open")
  # 点击排序
  $(".sales").click ->
    if $(this).hasClass("check")
      $(this).removeClass("check")
      $(".sales span").html "默认"
      sortStr = ""
    else
      $(this).addClass("check")
      $(".sales span").html "销量"
      sortStr = "&sort=desc"
    loadMore true
    $(".brand-shadow").removeClass("show")

  # 点击确定时判断品牌数组是否相等的方法
  isEquals = (a,b)->
    return JSON.stringify(a.sort()) == JSON.stringify(b.sort())
  # 点击确定
  $(".sure").click ->
    # brandArr = []
    newBrnandArr = []
    $(".brand-list li").each ->
      if $(@).hasClass("check")
        # brandArr.push @.dataset.id
        newBrnandArr.push @.dataset.id
    if isEquals(newBrnandArr,brandArr)
      $(".brand-shadow").removeClass("show")
    else
      brandArr = newBrnandArr
      brandState(brandArr)
      loadMore true
      $(".brand-shadow").removeClass("show")
    $(".brand").removeClass("open")
  # 点击全部
  $(".all").click ->
    $(".brand-list li").removeClass("check")
    $(".brand-shadow").removeClass("show")
    $(".brand").removeClass("open")
    if brandArr.length != 0
      brandArr = []
      brandState(brandArr)
      lastURL = oldURL
      $(".main-list-items").scrollTop(0)
      loadMore true
  # 点击品牌列表
  $(document).off("click")
  $(document).on "click",".brand-list li[data-id]", ->
    if $(this).hasClass("check")
      $(this).removeClass("check")
    else
      $(this).addClass("check")
    return false

  $(".brand-shadow .shadow").click ->
    $(".brand-shadow").removeClass("show")
    $(".brand").removeClass("open")

# 下拉刷新
# window.onload = ->
#   WebPullToRefresh.init loadingFunction: exampleLoadingFunction

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

# $(document).on 'page:load', ->
#   setTimeout ->
#     WebPullToRefresh.init loadingFunction: exampleLoadingFunction
#   ,0

$ ->
  if localStorage
    $subtotal = parseFloat localStorage.getItem("Subprice")
    $(".price-total .subtotal").html($subtotal)

  promotion()

