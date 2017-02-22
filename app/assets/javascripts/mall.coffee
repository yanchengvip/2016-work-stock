# //= require vendors/picker

validateForm = ->
    result = true
    for i in $("input[required]")
        $this = $(i)
        val = $.trim $this.val()
        if not val
            result = false
            break

    btn = $("#exchange-btn")
    result and btn.removeClass("not-ready") or btn.addClass("not-ready")
    result

@selectCount = ->
    dialog = $("#exchange-dialog")
    if not dialog.is(":visible")
        $("#exchange-bar").find('.s6, .s12').toggle()
        dialog.css("bottom", "-20rem").show().velocity "bottom": "4.4rem"

    # else
        # showDialog '此次兑换将使用600000积分确认兑换吗?'
@addNum = (selector)->
  if selector instanceof jQuery
      $selector = selector
  else
      $selector = $(selector)
  val = (parseInt($selector.val()) or 0) + 1
  $selector.val(val).trigger("change")

@reduceNum = (selector)->
  if selector instanceof jQuery
      $selector = selector
  else
      $selector = $(selector)
  val = parseInt($selector.val()) or 0
  val = Math.max(val - 1, 0)
  $selector.val(val).trigger("change")


@exchangeNow = ->
    if $("form").length > 0
        if not validateForm()
            return
    if $("#count").val()-0 < 0
      showDialog "兑换数量异常"
      return
    useIntegral = $("#points-total").text()-0
    myIntegral = $("#my-integral").text() - 0
    if useIntegral > myIntegral
      showDialog "积分不够兑换优惠券"
      return
    data =
        'Number': $("#count").val()

    if $("form").length > 0
        data =
            'Address': $("#picker").val() + $input("detail").val()
            'Mobile': $input("Mobile").val()
            'Consignee': $input("Consignee").val()
            'Number': $("#count").val() - 0

    delay =>
        if @.promise and @.promise.state() == "pending"
            return
    @.promise = $.postJSON "/mall/#{ID}/exchange", point_order: data, (o) ->
        console.log o
        if o.status == 'ok'
            location.href = "/mall/#{o.data.id}/exchange_detail"
        else
            showDialog o.message




@hideExchange = ->
    $('#exchange-dialog').hide()
    $("#exchange-bar").find('.s6, .s12').toggle()

@showAddressForm = ->

getValues = (data) ->
    (i.name for i in data)


$ ->
    $("input").keyup ->
        validateForm()

    price = $("#points-need").text() - 0
    $("#count").change ->
        count = $(@).val() - 0
        useIntegral = count * price - 0
        maxBuyNum = $(".limit span").html() - 0 || 0
        myIntegral = $("#my-integral").text() - 0
        if useIntegral > myIntegral
          showDialog "您的积分不足"
          $(@).val count-1
          return
        else if maxBuyNum !=0 && count > maxBuyNum
          count = maxBuyNum
          $("#count").val(count)
          showDialog "不能超过最大限兑数量"
        else if count <= 0
          count = 1
          showDialog "最少兑换一张优惠券"
          $("#count").val(count)
        $("#points-total").text (price * count)


    $.getJSON "/addresses/pcc.json", (o) ->
        data = o.data
        provinces = getValues(data.provinces)

        defaultValue = []

        _getCities = (p) ->
            p = p or defaultValue[0] or provinces[0]
            for i in data.provinces
                if i.name == p
                    cities = i.cities
            cities

        getCities = (p) ->
            cities = _getCities(p)
            getValues(cities)

        getDistricts = (p, c) ->
            cities = _getCities(p)
            c = c or defaultValue[1] or cities[0].name
            for i in cities
                if i.name == c
                    counties = i.counties
            getValues(counties)

        currentProvince = provinces[0]
        currentCity = getCities()[0]
        currentDistrict = getDistricts()[0]
        defaultValue = [currentProvince, currentCity, currentDistrict]

        $('#picker').picker
            toolbarTemplate: '<div class="picker-header">
                选择收货地址
                <a href="javascript:;" class="close-picker">确定</a>
                </div>'
            # value: defaultValue
            cols: [
                {
                    textAlign: 'center'
                    values: provinces
                },
                {
                    textAlign: 'center'
                    values: getCities()
                },
                {
                    textAlign: 'center'
                    values: getDistricts()
                }]
            formatValue: ->
                [p, c, d] = arguments[2]
                arguments[2].join("")

            onChange: (picker, values) ->
                newProvince = picker.cols[0].value
                if newProvince != currentProvince
                    clearTimeout(t)
                    t = setTimeout ->
                        newCities = getCities(newProvince)
                        newCity = newCities[0]
                        newDistricts = getDistricts(newProvince, newCity)
                        picker.cols[1].replaceValues(newCities)
                        picker.cols[2].replaceValues(newDistricts)
                        currentProvince = newProvince
                        currentCity = newCity
                        picker.updateValue()
                    , 200

                newCity = picker.cols[1].value
                if newCity != currentCity
                    picker.cols[2].replaceValues(getDistricts(newProvince, newCity))
                    currentCity = newCity
                    picker.updateValue()
