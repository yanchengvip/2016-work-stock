# $('ul.tabs').tabs()
if window.fromID
    $(".coupon-item").click ->
        coupon = $('<div>').append($(@).clone()).html()
        sessionStorage.setItem "coupon", coupon
        history.back()

# else
#     setBackUrl "/mine"

# $(".list-title li").click ->
#     $(@).

$ ->


    # $(".list-title li").click ->
    #     $(".all-coupons ul").eq($(@).index()).show().siblings().hide()
    # searchStr = window.location.search;
    # if searchStr.indexOf(0) != -1
    #   $(".list-title a").removeClass("active").eq(0).addClass("active")
    # else if searchStr.indexOf(1) != -1
    #   $(".list-title a").removeClass("active").eq(1).addClass("active")
    # else if searchStr.indexOf(2) != -1
    #   $(".list-title a").removeClass("active").eq(2).addClass("active")
    # else
    #   $(".list-title a").removeClass("active").eq(0).addClass("active")

    # 优惠券跳转
    $(document).on "click",".can-coupon li",->
        couponCity = $(@).attr("data-city-id");
        cookieCity = $.cookie('city_id')
        if couponCity == "" || couponCity.indexOf(cookieCity) > -1
            window.location.href = $(@).attr("_href")
        else
            showDialog "当前区域与优惠券区域不一致，如需使用优惠券请到首页进行区域切换。" , ->
                window.location.href = "/"
    $("#coupon-code").keyup ->
      val = $(@).val()
      if val.length == 8
        $(".exchange-btn").addClass("isOK")
      else
        $(".exchange-btn").removeClass("isOK")

    @submitExchange = ->
        if $(".exchange-btn").hasClass("isOK")
          val = $("#coupon-code").val()
          if not val
              Materialize.toast "请输入兑换码", 2000
          else
              delay =>
                  if @.promise and @.promise.state() == "pending"
                      return

                  @.promise = $.postJSON "/my/exchange_coupon", coupon_code: val, (o)->
                      if o.status == 'ok'
                          # Materialize.toast "兑换成功！", 2000, '', ->
                            showDialog
                              cancelText: '<span style="color:#4A90E2">兑换下一张</span>'
                              yesText: '<span style="color:#4A90E2">去查看</span>'
                              msg: '商品兑换成功'
                              callback: ->
                                window.location.href = "/carts"
                              cancel: ->
                                $("#coupon-code").val("")
                                $(".exchange-btn").removeClass("isOK")


                          # location.href = '/my/coupons'
                      else
                          showDialog o.message
        else
          showDialog "兑换码无效"




    # console.log $(".can-coupon li ")
    # $(".can-coupon li .can-use-coupon-detail").each (index,item) ->
    #   $(item).on 'click', (event)->
    #     console.log 1
    #     event.stopPropagation()
    #     parent = $(@).parents("li")
    #     if parent.hasClass("coupon-wallet-detail")
    #       parent.removeClass("coupon-wallet-detail")
    #     else
    #       parent.addClass("coupon-wallet-detail")

    # 比较时间的方法
    #返回0 当前时间不在范围内
    #返回-1 time在当前时间前num天内
    #返回1 当前时间在num内到time
    compareTime = (time,num)->
      nowTime = new Date().getTime()
      targetTime = new Date(time).getTime()
      dayNum = parseInt(Math.abs(nowTime - targetTime ) / 1000 / 60 / 60 /24)
      if dayNum > num
        return 0
      else if nowTime > targetTime && dayNum <= num
        return -1
      else if nowTime < targetTime && dayNum <= num
        return 1


    # 优惠券
    couponTypeUrl = 0
    couponPage = 1
    couponLoad = false
    couponHasMore = true
    getCouponsFn = (firstTime,callback)->
      if firstTime
        $("#coupons-box").html("")
        couponPage = 0
        couponHasMore = true
        className = ""
        couponLoad = true
        switch couponTypeUrl
          when 0 then className="can-coupon"
          when 1 then className="used-coupon"
          when 2 then className="expired-coupon"
      couponPage += 1
      $.getJSON "/my/coupons",  {type:couponTypeUrl;page:couponPage},(o)->
        # console.log o
        if o.status == "ok"
          couponLoad = false
          htmlStr=""
          if o.data.coupons .length == 0
            couponHasMore = false
          for item in o.data.coupons
            # console.log item
            tempStr = ""
            timeState = ""
            couponID = item.id
            couponType = item.type
            couponStatus = item.status
            endDate = item.end_date
            price = item.price
            startDate = item.start_date
            couponSubTitle = item.sub_title
            couponTitle = item.title
            couponTypeName = item.type_name
            couponUseUrl = item.use_url
            couponCity = item.cities
            useTime = "有效期至#{endDate}"
            if compareTime(startDate,2) == -1
              timeState = "new"
            if compareTime(endDate,1) == 1
              timeState = "old"
            if couponType == 5
              price = item.discount.toString()
              if price.split('.')[1] != undefined
                couponPrice = '<i class="big">' + price.split('.')[0] + '</i><i class="small-font">.' + price.split('.')[1] + '</i><span>折</span>'
              else
                couponPrice = item.discount+"<span>折</span>"
              couponCount = "<span class='use-times right'>#{item.count}</span>"
            else
              price = item.price.toString()
              if price.split('.')[1] != undefined
                couponPrice = '<span>&yen;</span><i class="big">' + price.split('.')[0] + '</i><i class="small-font">.' + price.split('.')[1] + '</i>'
              else
                couponPrice = "<span>&yen;</span>"+item.price
              couponCount = ""
            switch couponTypeUrl
              when 0
                # className="can-coupon"
                tempStr = """
                  <li data-id=#{couponID} class="bg#{couponType} state#{couponStatus}" data-city-id="#{couponCity}" _href="#{couponUseUrl}">
                """
                useTime = "#{startDate}-#{endDate}"
              when 1
                # className="used-coupon"
                tempStr ="""
                  <li data-id="#{couponID}">
                """
              when 2
                # className="expired-coupon"
                tempStr = """
                  <li data-id="#{couponID}" class="state#{couponStatus}">
                """


            htmlStr += """
                #{tempStr}
                <div class="coupon-type-name clearfix">#{couponTypeName}</div>
                <div class="clearfix">
                      <div class="coupon-price">#{couponPrice}<div class="coupon-price-amount">满#{item.use_money}元使用</div></div>
                      <div class="coupon-content">
                        <span class="cont #{timeState}">#{couponTitle}</span><br>
                        <div class="time">
                          #{useTime}
                          #{couponCount}
                          <em class="can-use-coupon-detail">详情</em><em class="expired-text-timeout">已冻结</em><em class="expired-text-timeend">已过期</em>
                        </div>
                      </div>
                      <div class="coupon-detail">#{couponSubTitle}</div>
                  </div>
                </li>"""

          if htmlStr == "" && couponTypeUrl == 0 && firstTime
            noCouponHtml = """
              <div class="no-content center-align">
                <div class="noCoupon-img">
                </div>
                <span class="sp_1">您暂时还没有优惠券</span>
                <span class="sp_2">去领券中心看看</span>

                <button class="pure-button" onclick="window.location='/coupons'">立即前往</button>
              </div>
            """
            $(".all-coupons").append noCouponHtml
          else
            $(".no-content").remove()

          if firstTime
            $("#coupons-box").attr("class",className+" coupon-list").html htmlStr
          else
            $("#coupons-box").append htmlStr
          callback and callback()






    $(".list-title li").click ->
      if $(@).find("a").hasClass "active" && ("#coupons-box li").length != 0
        return
      couponTypeUrl = $(@).index()
      getCouponsFn true

    $(".list-title li:first-child").click()
    $('ul.tabs').tabs()
    # 优惠券点击详情
    $(document).on "click",".can-coupon li .can-use-coupon-detail",(event)->
      event.stopPropagation()
      parent = $(@).parents("li")
      if parent.hasClass("coupon-wallet-detail")
        parent.removeClass("coupon-wallet-detail")
      else
        parent.addClass("coupon-wallet-detail")

    $(document).on 'page:load page:restore page:receive', ->
      $(".list-title li:first-child").click()
      $('ul.tabs').tabs()
      # 优惠券点击详情
      $(document).on "click",".can-coupon li .can-use-coupon-detail",(event)->
        event.stopPropagation()
        parent = $(@).parents("li")
        if parent.hasClass("coupon-wallet-detail")
          parent.removeClass("coupon-wallet-detail")
        else
          parent.addClass("coupon-wallet-detail")

    $(document).scroll ->
        if couponLoad
            return
        scrollTop = $("#coupons-box").scrollTop()
        scrolled = $("#coupons-box").height() + scrollTop
        docHeight = $("#coupons-box")[0].scrollHeight
        if scrolled + 40 > docHeight
            if couponHasMore
                couponLoad = true
                $("#coupons-box").append('<li class="padding load-more">加载中...</li>')

                getCouponsFn false, ->
                    couponLoad = false
                    $("#coupons-box .load-more").remove()
            else
                # if scrollTop > lastScrollTop
                window.loading = true
                setTimeout ->
                # Materialize.toast "没有更多了", 2000, "", ->
                    lastScrollTop = scrollTop
                    couponLoad = false
                , 2000
