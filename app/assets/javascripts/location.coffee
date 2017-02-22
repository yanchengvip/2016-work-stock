$ ->
  # 只显示地址包含的区
  # showFn = (id)->
  #   $(".location-county-wrapper  a[data-county-id='#{id}']")
  #   .parent().removeClass("hide")
  #   .parent().removeClass("hide")
  #   .prev().removeClass("hide")
  # showFn("174f7d04-ca93-4d69-b20d-ed2607db419c")
  # showFn("d75cf525-4083-47df-9791-ba35a77287d7")
  # $(".location-city[class*='hide']").remove()
  # $(".location-counties[class*='hide']").remove()
  # $(".location-county-wrapper[class*='hide']").remove()

  # geoData = null
  countyName = null
  # $(".location-city>a").click ->
  #     $('.arrow.top').not(@).toggleClass("top down").parent().next().slideToggle()
  #     $(@).toggleClass("top down")
  #     $(@).parent().next().slideToggle()

  # getGeoAddress undefined, (o) =>
  #     res = o.addressComponents
  #     $(".location-text").text res.district
  #     countyName = res.district
  #     geoData =
  #         province_name: res.province
  #         city_name: res.city
  #         county_name: res.district

  # $(".location-text").click =>
  #     if geoData
  #         $.getJSON "/parse_location", geoData, (o) ->
  #             if o.status == "ok"
  #                 setDepot o.data
  #                 saveCountyName countyName
  #                 setTimeout ->
  #                     location.href = "/"
  #                 , 0
  #             else
  #                 Materialize.toast o.message, 2000

  $(".location-county-item").click ->
      name = $.trim($(@).text())
      saveCountyName name
      dataset = @.dataset
      data =
          county_id: dataset.countyId
          company_id: dataset.companyId
          city_id: dataset.cityId
      setDepot data
      setTimeout ->
          window.location.href = window.returnTo or document.referrer or "/"
      , 0


  window.showLoading()
  $.getJSON '//api.map.baidu.com/location/ip?ak=I4ES6vHxqwV4TpIFSmGzfbGW&coor=bd09ll&callback=?', (o) ->
      window.hideLoading()
      city =  o.content.address_detail.city
      matched = false
      for i in $(".location-city>a")
          if i.innerHTML == city
              matched = true
              $(i).click()
              break
      if not matched
          $(".location-city>a:first").click()

