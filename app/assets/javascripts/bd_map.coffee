do =>
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
    xyUrl = 'http://api.map.baidu.com/ag/coord/convert?from=' + type + '&to=4&x=' + point.lng + '&y=' + point.lat + '&callback=BMap.Convertor.' + callbackName
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
  $.getJSON "http://api.map.baidu.com/location/ip?ak=I4ES6vHxqwV4TpIFSmGzfbGW&coor=bd09ll&callback=?", (o) ->
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

