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


@updatePrice = ->
  totalPrice = 0
  totalCount = 0
  for element in $(".message")
    group = $(element)
    leastOrderMoney = group.data('leastOrderMoney')
    price = 0
    count = 0
    for tr in group.find('tr')
      $tr = $(tr)
      if $tr.find("[type=checkbox]").is(":checked")
        if $tr.find(".TotalPrice").length > 0
          price += ($tr.find(".TotalPrice").text() - 0)
          count += 1
    group.find(".group-count").text(count)
    group.find(".group-price").text(price.toFixed(2))
    if price < leastOrderMoney
      group.find(".group-tip").text("（不足起送价）").parent().removeClass("red-color")
    else
      group.find(".group-tip").text("（免运费）").parent().addClass("red-color")
    totalPrice += price
    totalCount += count
  $("#TotalPrice").text totalPrice.toFixed(2)
  $("#TotalCount").text totalCount

$ ->
  updatePrice()

  $("[type=checkbox]").change ->
    updatePrice()
    # 全选按钮
  $(".input-checkall").change (event) ->
      key = $(@).data('key')
      checked = $(@).is(":checked")
      $('#cart-'+key).find("[type=checkbox]").prop("checked", checked)
      if checked
        url = "/carts/check_all"

      else
        url = "/carts/uncheck_all"
      $.putJSON url, {third_type: key},->
        updatePrice()
        checkAllCheck()

  $('#allSelect').click (e) ->
    checked = $(this).prop('checked')
    if checked
      url = '/carts/check_all'
    else
      url = '/carts/uncheck_all'
    $('.message input[type=checkbox]').prop 'checked', checked
    $.putJSON url, ->

  $('#submit').click ->
    arr = []
    errorMsg = ''
    if $("#TotalCount").text() - 0 == 0
      alert('请选择商品')
      return

    for element in $(".message")
      group = $(element)
      leastOrderMoney = group.data('leastOrderMoney')
      count = group.find(".group-count").text() - 0
      price = group.find(".group-price").text() - 0
      if count > 0
        if price < leastOrderMoney
          name = group.data('name')
          errorMsg = "#{name}不满起送价#{leastOrderMoney}"

    if errorMsg
      alert errorMsg
      return

    $('tr input:checkbox:checked').each (e, t) ->
      lowStock = $(t).next().children('.low_stocks')
      if lowStock.length > 0
        errorMsg = lowStock.prev().attr('title') + ' 库存不足'
        return false
      json = {}
      json['ckey'] = $(t).attr('ckey')
      json['key'] = $(t).attr('ekey')
      json['number'] = $($($(t).parents()[1]).siblings()[2]).find('.pro_num').val()
      arr.push json

    if errorMsg
      alert errorMsg
      return

    delay =>
      if this.promise and this.promise.state() == 'pending'
        return
      this.promise = $.postJSON '/orders', {list: arr}, (e) ->
        if e.status == 'ok'
          window.location = '/order_info?id=' + e.order_group_id
        else
          alert e.message
