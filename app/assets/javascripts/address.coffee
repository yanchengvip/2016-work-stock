# //= require vendors/picker
# //= require vendors/plupload.full.min
# //= require vendors/qiniu.min

setDefault = (addressId, callback) ->
    $.putJSON "/addresses/#{addressId}/defadd", ->
        callback and callback()

getValues = (data) ->
    (i.name for i in (data or []))

$ ->
    $("#back").click ->
        href = @.dataset.href or '/mine'
        location.href = href

    if /addresses\/(.*)(new|edit|certified)/.test(location.href)
        $.getJSON "/addresses/pcc.json", (o) ->
            data = o.data
            provinces = getValues(data.provinces)
            defaultValue = $("#picker").val().split(" ")

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
                for i in (cities or [])
                    if i.name == c
                        counties = i.counties
                getValues(counties)

            if defaultValue.length == 1 or (defaultValue[0] == '北京')
                currentProvince = provinces[0]
                currentCity = getCities()[0]
                currentDistrict = getDistricts()[0]
                defaultValue = [currentProvince, currentCity, currentDistrict]
            else
                [currentProvince, currentCity, currentDistrict] = defaultValue

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
                    $input("user_address[Province]").val p
                    $input("user_address[City]").val c
                    $input("user_address[County]").val d
                    arguments[2].join(" ")

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
    # 修改地址页面只可以选择区
    $(".edit-address #picker").click ->
      setTimeout ->
        $(".picker-items-col").eq(0).unbind("touchmove").find(".picker-item").css("color","#cfd5da")
        $(".picker-items-col").eq(1).unbind("touchmove").find(".picker-item").css("color","#cfd5da")
      ,0
    if location.href.indexOf("/my/address") > 0
        # $(".contact, .address, .address-detail").click (e) ->
        #     addressId = $(@).parent().attr("id").slice 3
        $(".address-item").click ->
            addressId = $(@).attr("id").slice 3
            if fromID
                setDefault addressId, ->
                    s =  $("#id-#{addressId}").find('.contact-address').text()
                    s = s.replace(/\s+/g, '')
                    if s
                        window.location.href = $("#back").attr("data-href")
                    else
                        showDialog '请补全省市区信息'

        if fromID
            document.getElementById('back').dataset.href = "/order_info?id=#{fromID}"
        else
            document.getElementById('back').dataset.href = "/mine"



    validateForm = ->
        result = true
        for i in $("input[required], input[hidden],select[required]")
            $this = $(i)
            val = $.trim $this.val()
            if not val
                result = false
                break

        result

    window.testForm = ->
        validateForm() and $(".address-btn,.sub-btn").addClass("main-ok") or $(".address-btn,.sub-btn").removeClass("main-ok")

    $("input").keyup ->
        testForm()

    $("#picker,select").change ->
        testForm()
    # 注册成功弹窗
    showNewSignIn = ->
      data = "type=2"
      $.getJSON "/popup",data,(data)->
        if data.data.length > 0
          value = data.data[0]
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
                      <a href="javascript:;" onclick="window.location.href='#{newLink}'" class="btn"></a>
                      #{newImg}
                  </div>
              </div>"""
              $("body").append(html)
          $('#show-dialog').removeClass('hidden')
          urlHistory = JSON.parse(sessionStorage.getItem('urlHistory') or '[]')
          urlHistory.pop()
          urlHistory.push("/")
          sessionStorage.setItem('urlHistory', JSON.stringify(urlHistory))
          $("#new-signup .closed").click ->
            window.location.href = "/"
        else
          window.location.href = "/"
    # 根据地址得到经纬度
    getGeo = (fn)->
      try
        addressStr = $("#picker").val() + $(".detailed-address input").val()
        myGeo = new BMap.Geocoder()
        myGeo.getPoint addressStr,(point)->
          if point
            $("input[name='user_address[Latitude]']").val point.lat
            $("input[name='user_address[Longitude]']").val point.lng
          else
            $("input[name='user_address[Latitude]']").val 0
            $("input[name='user_address[Longitude]']").val 0
          fn()
      catch e
        $("input[name='user_address[Latitude]']").val 0
        $("input[name='user_address[Longitude]']").val 0
        fn()

    # 新建地址提交
    saveFlag = true
    $("#new-save").click (e) ->
      e.preventDefault()
      if $(@).hasClass "main-ok"
          if saveFlag
              saveFlag = false
              if isPhoneValid($input('user_address[Mobile]').val())
                window.showLoading()
                getGeo ->
                  $.post "/addresses.json", $("form").serialize(), (o) ->
                    window.hideLoading()
                    saveFlag = true
                    if o.status != 'ok'
                      Materialize.toast o.message, 3000
                    else
                      showNewSignIn()
                        # if location.href.indexOf('newSignUp') != -1
                        #   showNewSignIn()
                        # else
                        #   location.href = "/my/address"
              else
                  saveFlag = true
                  window.hideLoading()
                  showDialog "联系方式格式有误"
          else
              showDialog "请勿重复操作"

    $("#edit-save").click (e)->
      e.preventDefault()
      if $(@).hasClass "main-ok"
          if isPhoneValid($input('user_address[Mobile]').val())
            getGeo ->
              $("form").submit()
          else
              showDialog "联系方式格式有误"
    #已认证地址点击编辑弹框
    $(".edit").click ->
        if $(@).parents(".address-item").hasClass "success"
            _this = @
            showDialog "修改已认证地址需要重新审核，确认修改？",->
                window.location.href=$(_this).attr("_href")
        else
            window.location.href=$(this).attr("_href")
    # 判断认证状态跳转
    # $(".certified-no,.certified-faild").click ->
    #     window.location.href=$(@).attr("_href")
    #删除地址判断
    $(".dele").click ->
        if $(@).prevAll(".certified").hasClass "certified-success"
            showDialog "认证过的地址不能删除"
            return
        else if $(@).prevAll(".certified").hasClass "certified-ing"
            showDialog "认证中的地址不能删除"
            return
        else
            $(@).attr "href",$(@).attr("_href")
            $(@).attr "data-method":"delete","rel":"nofollow"
            $(@).click


    $("#map-back").click ->
      $("body").scrollTop(0)
      $(".map-box").hide()

    # 选择店铺信息
    $(".store-info").click ->
      index = $(@).index()
      $(".info-cont-box").show().find(".info-cont").eq(index).show().siblings("div").hide()
    $(".info-cont-box .closed").click ->
      $(".info-cont-box").hide()
    # 具体信息
    $(".info-cont li").click ->
      className = $(@).attr("class")
      val = $(@).attr("value")
      textStr = $(@).text()
      index = $(@).parents(".info-cont").index()
      $(".store-info-box .store-info").eq(index).text(textStr).attr({"class":"store-info "+className})
      $(".info-input input").eq(index).val val
      $(".info-cont-box").hide()
      testForm()

    $('.info-input input').each ->
      val = $(@).val()
      if val || val == 0
        index = $(@).index()
        $('.info-cont').eq(index).find('li[value='+val+']').click()

    # 新建地址弹框提示
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
    _MEIQIA 'entId', '17793'
    # 在这里开启手动模式（必须紧跟美洽的嵌入代码）
    # _MEIQIA('manualInit');
    _MEIQIA 'init'
    _MEIQIA 'withoutBtn'

    $(".addresses-new").click ->
      cityID = $.cookie("city_id")
      telNum = "010-67832728"
      # switch cityID
      #   when "7f88c460-7fe7-4137-a49e-91424060eae6" then telNum="北京电话"
      #   when "2db13158-29af-42bf-82f9-38046f6a2efe" then telNum="上海电话"
      #   when "02641c41-1350-4b6a-9a04-3e1e80973df6" then telNum="天津电话"
      #   when "08b2f521-497c-4ac1-9a43-d544a7c418d5" then telNum="内蒙电话"
      tipHtml = """
        <div id="callServer-tip">
          <div class="tip-box">
            <p>联系客服为您添加新地址</p>
            <a href='javascript:_MEIQIA("showPanel")'>联系在线客服</a><br>
            <a href='tel:#{telNum}'>拨打电话#{telNum}</a>
            <i class="closed"></i>
          </div>
        </div>
        """
      $("body").append tipHtml
      $("#callServer-tip .closed").on "click", ->
        $("#callServer-tip").remove()

# 认证地址
$ ->

  auth_token = $.cookie('remember_token')
  # 有图时默认显示图片
  showImg = (str) ->
    key = $('input[name=\'' + str + '\']').val()
    if key
      $('#' + str + '-img').attr('src', 'http://7xnnlv.com1.z0.glb.clouddn.com/' + key).show().parent().addClass 'up-end'
    return
  showImg 'LicencePhotoCover'

  # 预览图片函数
  previewImage = (file, callback) ->
    #file为plupload事件监听函数参数中的file对象,callback为预览图片准备完成的回调函数
    if !file or !/image\//.test(file.type)
      return
    #确保文件是图片
    if file.type == 'image/gif'
      #gif使用FileReader进行预览,因为mOxie.Image只支持jpg和png
      fr = new (mOxie.FileReader)

      fr.onload = ->
        callback fr.result
        fr.destroy()
        fr = null
        return

      fr.readAsDataURL file.getSource()
    else
      preloader = new (mOxie.Image)

      preloader.onload = ->
        preloader.downsize 300, 300
        #先压缩一下要预览的图片,宽300，高300
        imgsrc = if preloader.type == 'image/jpeg' then preloader.getAsDataURL('image/jpeg', 80) else preloader.getAsDataURL()
        #得到图片src,实质为一个base64编码的数据
        callback and callback(imgsrc)
        #callback传入的参数为预览图片的url
        preloader.destroy()
        preloader = null
        return

      preloader.load file.getSource()
    return

  # 尝试不使用七牛jdk
  uploadImg = (token) ->
    #上传执照照片
    uploader = new (plupload.Uploader)(
      browse_button: 'fileupload-licenseimg'
      url: 'https://up.qbox.me'
      max_file_size: '10mb'
      filters: [ {
        title: 'Image files'
        extensions: 'jpg,gif,png,jpeg'
      } ]
      multipart_params: 'token': token
      init:
        FilesAdded: (uploader, files) ->
          previewImage files[0], (url) ->
            $('#LicencePhotoCover-img').attr('src': url).show()
            return
          uploader.start()
          $('#fileupload-licenseimg').attr 'class', 'img-box up-ing'
          return
        FileUploaded: (up, files, obj) ->
          $('#fileupload-licenseimg').attr 'class', 'img-box up-end'
          key = $.parseJSON(obj.response).key
          # $("#LicencePhotoCover-img").attr({"src":"http://7xnnlv.com1.z0.glb.clouddn.com/"+key}).show();
          $('input[name=\'LicencePhotoCover\']').val key
          testForm()
          return
        Error: (up, files, obj) ->
          $('#fileupload-licenseimg').attr 'class', 'img-box up-err'
          $('#LicencePhotoCover-img').hide()
          $('input[name=\'LicencePhotoCover\']').val ''
          testForm()
          return
    )
    uploader.init()
    return

  $('.sub-btn').click ->
    if $(this).hasClass('main-ok')
      tipHtml = """
      <div id="certified-tip">
        <div class="shadown"></div>
        <div class="tip-box certified-ing">
          <a href="javascript:closedCertifiedTip()" class="closed"></a>
          <div class="tip-cont">
            <div class="tip-top">
              <div class="img-box"></div>
            </div>
            <h2 class="tip-title">提交成功，审核中...</h2>
          </div>
          <div style="text-align: center;color: #8B572A;padding-top:4rem;">页面即将跳回认证前页面</div>
        </div>
      </div>
      """
      $("body").append tipHtml
      $('form').submit()
    return
  # 得到七牛的token
  getToken = ->
    $.ajax
      cache: false
      dataType: 'json'
      type: 'GET'
      url: '/common/upload_token'
      success: (message) ->
        # callback(message.uptoken)
        uploadImg message.uptoken
        return
    return
  getToken()





    # onMessage = (e) ->
    #     data = JSON.parse e.data
    #     if data.cmd == 'message'
    #         addr = data.addr
    #         $(".as-input").text addr.join(" ")
    #         $input("user_address[Province]").val addr[0]
    #         $input("user_address[City]").val addr[1]
    #         $input("user_address[County]").val addr[2]
    #         $("[name='user_address[Detailedaddress]']").val data.detail
    #         testForm()

    #     closeMap()

    # window.addEventListener "message", onMessage, false
    # $(document).on 'touchstart', (e) ->
    #     console.log "touch"



# _fillData = (url, arg, node, callback) ->
#   $.getJSON url, arg, (o) ->
#     str = "<option value='' data-id=''>请选择</option>"
#     for i in o.data
#         str += "<option value=#{i.name} data-id=#{i.id}>#{i.name}</option>"
#     node.html str
#     callback and callback()

# @select_city = (selector) ->
#     element = $(selector)
#     if element.length == 0
#         return
#     elementProvince = element.find("select.province")
#     elementCity = element.find("select.city")
#     elementDistrict = element.find("select.district")

#     _fillData '/addresses/provinces', '', elementProvince

#     elementProvince.change ->
#         val = elementProvince.find("option:selected").data("id")
#         if val
#             _fillData '/addresses/cities', "provinceID=#{val}", elementCity
#             elementDistrict.html ""

#     elementCity.change ->
#         val = elementCity.find("option:selected").data("id")
#         if val
#             _fillData "/addresses/counties", "cityID=#{val}", elementDistrict


#     setTimeout ->
#         runInOrder [
#             -> elementProvince.find("option[value='#{window.province}']").prop('selected', true).change(),
#             -> elementCity.find("option[value='#{window.city}']").prop('selected', true).change(),
#             -> elementDistrict.find("option[value='#{window.district}']").prop('selected', true)
#         ]
#     , 100



# @showMap = ->
#     if $(".page-mask-wrapper").length == 0
#         $("body").append """
#         <div class="page-mask-wrapper">
#             <iframe src="/addresses/map?key=#{}"></iframe>
#         </div>
#         """
#     return false

# @closeMap = ->
#     $(".page-mask-wrapper").remove()
