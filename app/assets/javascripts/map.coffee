$ =>
  panTo = (point) ->
      map.clearOverlays()
      mk = new BMap.Marker(point)
      # map.addOverlay(mk)
      map.panTo(point)
      renderPoiByPoint(point)
  renderPoi = (data) ->
      $("#poi-items").html("")
      _ = []
      for i in data
          title = i.title
          address = i.address
          lat = i.point.lat
          lng = i.point.lng
          _.push "<div class='poi-item' lng='#{lng}' lat='#{lat}'>"
          _.push "<div class='address'>#{address}</div>"
          _.push "<div class='title'>#{title}附近</div>"
          _.push "</div>"

      $("#poi-items").html _.join("")
  # 当前位置
  renderPoiByPoint = (point) ->
      getGeoAddress point, (o) ->
          res = o.addressComponents
          window.position = [res.province, res.city, res.district]
          li = []
          li.push
              title: "[当前]#{o.business}"
              address: res.street+res.streetNumber
              point :
                lng: o.point.lng
                lat: o.point.lat
          renderPoi li.concat(o.surroundingPois)

  # 初始化地图
  map = new BMap.Map("map")
  # 显示地图
  $(".show-map").click ->

    $("body").scrollTop(0)
    $(".map-box").show()
    # 根据IP 定位城市
    getGeoPosition (res) ->
      map.centerAndZoom(new BMap.Point(res.point.lng,res.point.lat), 18)
      panTo res.point
    getLocation()
  # 解析地址
  geoc = new BMap.Geocoder()
  # 地图中心点经纬度
  map.addEventListener "dragend", ->
   center = map.getCenter()
   # console.log center
   geoc.getLocation new (BMap.Point)(center.lng, center.lat), (result) ->
    if result
      panTo result.point
      renderPoiByPoint result.point
    return


  # // 添加带有定位的导航控件
  navigationControl = new BMap.NavigationControl
    anchor: BMAP_ANCHOR_TOP_LEFT
    type: BMAP_NAVIGATION_CONTROL_LARGE
    enableGeolocation: true
  #// 添加定位控件
  map.addControl(navigationControl)
  # 定位成功事件
  geolocationControl = new BMap.GeolocationControl()
  geolocationControl.addEventListener "locationSuccess", (o) ->
      panTo o.point

  map.addControl(geolocationControl)

  # renderPoiByPoint()

  options =
      onSearchComplete: (results) ->
          point = results.getPoi(0).point
          panTo point
          renderPoiByPoint point

  local = new (BMap.LocalSearch)(map, options)

  # map.addEventListener "click", (o) ->
  #     panTo o.point
  #     renderPoiByPoint o.point



  ac = new BMap.Autocomplete
      "input": "q"
      "location" : map

  ac.addEventListener 'onconfirm', (e) ->
      $("#q").blur()
      res = e.item.value
      s = res.province + res.city + res.district + res.street + res.business
      local.search s

  # $("#poi-items").on "click", ".poi-item", ->
  #     address = $(@).find('.address').text()
  #     for i in window.position
  #         length = i.length
  #         if address.slice(0, length) == i
  #             address = address.slice(length)
  #     data =
  #         cmd: 'message'
  #         addr: window.position
  #         detail: address

  #     window.parent.postMessage JSON.stringify(data), window.parent.location.origin
   # 选择地址
  $(document).on "click", ".poi-item", ->
    address = $(@).find('.address').text()
    if address != " "
      lng = $(@).attr("lng")
      lat = $(@).attr("lat")
      $(".show-map input").val(address)
      $("input[name='user_address[Latitude]']").val lat
      $("input[name='user_address[Longitude]']").val lng
      testForm()
      $("body").scrollTop(0)
      $(".map-box").hide()
      $(".detailed-address input").focus()

  # h5定位
  getLocation = ->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition translatePoint,showError,showFn
    else
      showDialog '该浏览器不支持获取地理位置。'
    return
  # H5定位成功坐标转换
  translatePoint = (position) ->
    currentLat = position.coords.latitude
    currentLon = position.coords.longitude
    gpsPoint = new (BMap.Point)(currentLon, currentLat)
    BMap.Convertor.translate gpsPoint, 0, panTo
    return
  # H5定位失败函数
  showError = (error) ->
    switch error.code
      when error.PERMISSION_DENIED
        Materialize.toast "没用定位权限", 2000
      when error.POSITION_UNAVAILABLE
        Materialize.toast "无法获取当前位置", 2000
      when error.TIMEOUT
        Materialize.toast "定位超时", 2000
      when error.UNKNOWN_ERROR
        Materialize.toast "未知错误", 2000
  showFn = ->
    showDialog "错误"


  # $(".map-box").touchmove (e)->
  #   e.preventDefault()
  # $(".map-box").click (e)->
    # e.stopPropagation()
@closeSelf = ->
    data =
        cmd: 'close'
    window.parent.postMessage JSON.stringify(data), window.parent.location.origin
# 解析用户地址得到经纬度

do =>
# $ =>
# $(document).on 'page:load page:restore', ->
  @load_script = (xyUrl, callback) ->
    head = document.getElementsByTagName('head')[0]
    script = document.createElement('script')
    script.type = 'text/javascript'
    script.src = xyUrl
    #借鉴了jQuery的script跨域方法
    script.onload =
    script.onreadystatechange = ->
      if !@readyState or @readyState == 'loaded' or @readyState == 'complete'
        callback and callback()
        # Handle memory leak in IE
        script.onload = script.onreadystatechange = null
        if head and script.parentNode
          head.removeChild script

    # Use insertBefore instead of appendChild  to circumvent an IE6 bug.
    head.insertBefore script, head.firstChild

  translate = (point, type, callback) ->
    callbackName = 'cbk_' + Math.round(Math.random() * 10000)
    #随机函数名
    xyUrl = 'https://api.map.baidu.com/ag/coord/convert?s=1&from=' + type + '&to=4&x=' + point.lng + '&y=' + point.lat + '&callback=BMap.Convertor.' + callbackName
    #动态创建script标签
    load_script xyUrl

    BMap.Convertor[callbackName] = (xyResult) ->
      `var point`
      delete BMap.Convertor[callbackName]
      #调用完需要删除改函数
      point = new (BMap.Point)(xyResult.x, xyResult.y)
      callback and callback(point)


  window.BMap = window.BMap or {}
  BMap.Convertor = {}
  BMap.Convertor.translate = translate



@getGeoPosition = (callback) ->
  # geolocation = new BMap.Geolocation()
  # geolocation.getCurrentPosition (r) ->
    # callback and callback(r)
  $.getJSON "https://api.map.baidu.com/location/ip?ak=lhVaCHKcR1BzGRoqyGzphudBeP2de9Ic&coor=bd09ll&callback=?&s=1", (o) ->
      p = o.content.point
      data =
        point: new BMap.Point(p.x, p.y)

      callback and callback(data)



@getGeoAddress = (point, callback) ->
    geoc = new (BMap.Geocoder)
    if point is undefined
      getGeoPosition (res) ->
        geoc.getLocation res.point, (rs) ->
          callback and callback(rs)
    else
        geoc.getLocation point, (rs) ->
          callback and callback(rs)

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
    localStorage.setItem "county-name", name

@getCountyName = (name) ->
  localStorage.getItem "county-name"


@setDepot = (data) ->
  for k, v of data
    $.cookie k, v, expires: 365


@updateGeoPosition = ->
  setCountyName "定位中哈哈哈"
  getGeoAddress undefined, (o) ->
      res = o.addressComponents
      thisGeoPosition = "#{res.province}-#{res.city}-#{res.district}"
      localStorage.setItem "lastGeoPosition", thisGeoPosition
      setCountyName res.district
      data =
          province_name: res.province
          city_name: res.city
          county_name: res.district
      $.getJSON "/parse_location", data, (o) ->
          if o.status == "ok"
              saveCountyName res.district
              setDepot o.data
          else
              Materialize.toast o.message, 2000

@setInitAddress = ->
    $.cookie "company_id", "22294f4c-dacc-48d6-aba8-d6c8fbe8cf7e", expires: 365
    $.cookie "depot_id", "f6d48bbd-ef85-4d70-a810-eaf327682c1b", expires: 365
    localStorage.setItem "county-name", "东城区"
    localStorage.setItem "lastGeoPosition", "北京市-北京市-东城区"
    setTimeout ->
        closeSelectAddress()
    , 0

