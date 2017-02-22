$('.category .tab').click ->
    $list = $("##{@.dataset.id}")
    if @.classList.contains "active"
        @.classList.remove "active"
        if $list.css("display") == "none"
            $list.show()
        else
            $list.hide()
    else
        @.classList.add "active"
        $(@).siblings().removeClass("active")
        $list.siblings(".category-list").hide()
        $list.show()



# 详细信息的标题不能超过20个字

$title = $('.word .title span')
$title.each(->
    # console.log($(this).text())
    if $(this).text().length > 20
        $(this).text($(this).text().slice(0,21) + "...")
    if $(this).text().slice(0,1) == "【"
        $(this).css("text-indent","-0.7rem")
    )

# 尝试写吸顶效果动画
$category = $('.category');
categoryTop = parseInt($category.css("top"));
flag = true
$(window).scroll ->
    scrollTop = $(document.body).scrollTop();
    if  scrollTop > 200 && flag == true
        $category.animate({top:0},200)
        flag = false
    else if parseInt($category.css("top")) == 0 && scrollTop < categoryTop  && flag == false
        console.log("xiao yu 100le")
        $category.animate({top:categoryTop},200)
        flag = true
# 顶部搜索框点击跳到搜索页面
$(".search-input>div").css({"width":"100%","height":"100%","transform":"translateY(-100%)"}).click(->
        window.location.href = "/products/search";
    )

$(".list_c").on "click",".list-item", ->
  showPopup(@)
# 阻止冒泡
$(".list_c").on "click",".item-console",(event) ->
  event.stopPropagation()
# 搜索产品页下拉刷新
noMore = false
isLoading = false
page = 1
# floorID = $(".think-love").attr("data-id")
$(document).scroll ->
  if isLoading || $(".list_c").length == 0
      return
  bodyHeight = document.documentElement.clientHeight
  thinkloveHeigh = $(".list_c").height()
  thinkloveTop = $(".list_c")[0].getBoundingClientRect().top
  if bodyHeight - thinkloveHeigh + 180 > thinkloveTop
      $(".list_c .loading-text").remove()
      if noMore
          $(".list_c").append('<p class="loading-text" style="text-align:center;padding: 1rem;">没有更多商品了</p>')
          isLoading = true
      else
          isLoading = true
          $(".list_c").append('<p class="loading-text" style="text-align:center;padding: 1rem;">加载中...</p>')
          getMore ->
              isLoading = false
              $(".list_c .loading-text").remove()

getMore = (fn)->
  page += 1
  url = window.location.pathname + window.location.search + "&page=#{page}"
  str = ""
  $.getJSON url, (o) ->

    if o.data.products.length < 20
        noMore = true
    for item in o.data.products
        cornerMark = ""
        cartNum = 0
        showConsole = ""
        stockHtml =""
        cornerMarkHtml = ""
        type=""
        minBuyHtml = ""
        oldPriceHtml = ""
        title = item.name
        speci = item.specification
        minBuy = item.min_buy_count || 1
        stock = item.stock
        thirdType = item.third_type
        jsonStr = JSON.stringify(item)
        oldPrice = item.original_price
        if title.length > 25
            title = title.slice(0, 22) + '..'
        if item.corner_mark
          stockHtml = "<i class='img-tip' style='font-size:0.9rem;'>#{item.corner_mark}</i>"
        if item.cart_num > 0
          cartNum = item.cart_num
          showConsole = "show-console"
        else
          cartNum = 0
          showConsole = ""
        if stock <= 0
          stockHtml = "<div class='cover'>补货中</div>"
        if thirdType == 0
          type = "<i class='text-tip'>自营</i>"
        if minBuy > 1
          minBuyHtml = """<span style="font-size:1.2rem; float: right; margin-right: 3rem; margin-top: 0.1rem; color:#F5A623;">#{minBuy}#{item.unit}起订</span>"""
        if oldPrice
          oldPriceHtml = """&yen;#{oldPrice}/#{item.unit}"""
        str += """
              <div class="list-item" id="p-#{item.id}" data-data='#{jsonStr}'  data-image-url="#{item.cover}" data-name="#{item.name}">
                <div class="padding">
                  <a href="javascript:;">
                    <img src="#{item.cover}" alt="">
                    #{stockHtml}
                    #{cornerMarkHtml}
                  </a>
                  <div class="desc clearfix" style="position: relative;">
                    <div class="word left">
                      <div class='title'>
                        #{type}
                        <span>#{title}</span>
                      </div>
                      <div style="position: relative;">
                        <span class="price-market">
                          #{oldPriceHtml}
                        </span><br>
                        <div class="price">&yen;#{item.price}<i>/#{item.unit}</i>
                          #{minBuyHtml}
                        </div>
                        <div class="item-console #{showConsole}">
                          <a href="javascript:;" onclick="setAmount.add('#{item.id}')" class="add-item">＋</a>
                          <div class="item-num" data-min-buycount="#{minBuy}">
                            <input id="#{item.id}" class="number" num="#{cartNum}" value="#{cartNum}" data-id="#{item.id}" type="num" disabled>
                          </div>
                          <a href="javascript:;" onclick="setAmount.reduce('#{item.id}')" class="remove-item">－</a>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              """
      $(".list_c").append(str)
      fn and fn()
