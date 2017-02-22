# $("form").submit (e) ->
#     e.preventDefault()
#     false

$(".btn-sign-up").click (e) ->
    e.preventDefault()
    tel = $.trim $input("user[Phone]").val()
    # 判读手机号是否已注册
    if isTelValid(tel)
      $.ajax
        type: 'Get'
        url: '/passwords/check_mobile'
        dataType: 'json'
        data: 'mobile': tel
        success: (result) ->
          if result.status != 'ok'
            # console.log result
            signUpSubmit()
          else
            options =
              cancelText: '取消'
              yesText: '<span style="color: #E62E46;">去登录</span>'
              msg: '手机号已注册,请登录'
              callback: ->
                window.location.href = "/sign_in"
              cancel: null
            showDialog options
        error: (result)->
          signUpSubmit()
    else
      showDialog "手机号格式不正确"

$(".btn-sign-in").click (e) ->
    e.preventDefault()
    signInSubmit()

$(".btn-change-pwd").click (e) ->
    e.preventDefault()
    changePwd()

$(".btn-password-new").click (e) ->
    e.preventDefault()
    pwdNew()


# 得到验证码
allowSend = true
getCodeFn = (phone)->
  if allowSend
        sendBtn = $(".get-sms-code")
        # tel = $input("user[Phone]").val()
        tel = $("#tel").val()
        data =
          tel: tel
          isVoice : phone
        if isTelValid tel
            $.post "/send_check_code.json", data, (o) ->
                if o.status == "ok"
                  sendBtn.addClass("<pure-but></pure-but>ton-disabled").removeClass("ok")
                  allowSend = false
                  setTimeout ->
                      $('[name="user[check_code]"]').focus()
                      n = 60
                      intevalId = setInterval ->
                          sendBtn.html "#{n} 秒后可重发"
                          n -= 1
                          if n == 0
                              clearInterval(intevalId)
                              sendBtn.removeClass("pure-button-disabled").html("点击发送").addClass("ok")
                              allowSend = true
                      , 1000
                  , 0
                else if o.status == "error"
                  showDialog o.message

            if phone == "true"
              showDialog "您将收到尾号3076的语音播报，请注意接听"
        else
            # Materialize.toast '手机号码格式不正确', 2000
            $('[name="user[Phone]"]').focus()
# 短信验证码
$(".get-sms-code").click (e) ->
    e.preventDefault()
    getCodeFn("false")

# 语音验证码
$(".phone-voice a").click (e)->
  e.preventDefault()
  getCodeFn("true")
validateForm = ->
    result = true
    for i in $("fieldset>input:not('.not-required')")
        $this = $(i)
        if not $this.val()
            name = $this.attr('placeholder')
            Materialize.toast "请填写#{name.slice(0, name.length-1)}", 2000
            result = false
            break
    if result
        for i in $("select")
            if not $(i).val()
                Materialize.toast "请选择省市区", 2000
                result = false
                break

    result

signUpSubmit = ->
    tel = $.trim $input("user[Phone]").val()
    userType = $("input[name='user[Type]']:checked").val()
    password = $.trim $input("user[Password]").val()
    password1 = $.trim $input("user[password_confirmation]").val()
    msg = ""
    if validateForm()
        # if not userType
        #     msg = "请选择用户类型"
        if not isTelValid(tel)
            msg = "手机号不正确"
        else if password == ""
            msg = "密码不能为空"
        # else if password != password1
        #     msg = "两次密码输入不一致"
        else if not $("#terms").prop("checked")
            msg = "必须同意协议才能注册"
        if msg
            showDialog msg
            $("form").blur()
        else
            $input('user[address[CountyID]]').val $(".district").find("option:selected").data("id")
            $.post "/sign_up.json", $("form").serialize(), (o) ->
                if o.status != 'ok'
                    showDialog o.message
                else
                    # url = o.return_to + "?newSignUp=true"
                    url = o.return_to
                    location.href = url


signInSubmit = ->
    tel = $.trim $input("session[tel]").val()
    password = $.trim $input("session[password]").val()
    if isTelValid(tel)
      # console.log isTelValid(tel)
      if not password
        showDialog "请输入密码"
      else
        $.cookie "tel", tel, expires: 365
        $.post "/sign_in.json", $("form").serialize(), (o) ->
            if o.status != 'ok'
                showDialog o.message
            else
                token = $.cookie 'remember_token'
                window.loginCallback(tel, token)
                setTimeout ->
                    location.href = o.return_to
                , 0


changePwd = ->
    oldPassword = $.trim $input("user[old_password]").val()
    password = $.trim $input("user[Password]").val()
    password1 = $.trim $input("user[password_confirmation]").val()
    msg = ""
    if not oldPassword
        msg = "请输入旧密码"
    else if not password
        msg = "请输入密码"
    else if not password1
        msg = "请输入确认密码"
    else if password != password1
        msg = "两次密码输入不一致"
    if msg
        Materialize.toast msg, 2000
    else
        $("form").submit()

pwdNew = ->
    tel = $.trim $input("user[Phone]").val()
    password = $.trim $input("user[Password]").val()
    password1 = $.trim $input("user[password_confirmation]").val()
    codeNum = $.trim $("#code").val()
    msg = ""
    if validateForm()
        if isTelValid(tel)
          if not password
            msg = "请输入密码"
          else if not password1
            msg = "请输入确认密码"
          else if password != password1
            msg = "两次密码输入不一致"
          else if codeNum == ""
            msg = "验证码为空"
          if msg
            showDialog msg
            $("form").blur()
          else
            $("form").submit()

$ ->
    $("form.login").find("[name='session[tel]']").val $.cookie("tel")
    # 加载就验证手机号
    tel = $.trim $("#tel").val()
    if tel.length == 11
      if isTelValid(tel)
        $("#getcode").addClass("ok")
    # select_city("form.sign-up")
    $("#tel").keyup ->
      tel = $.trim $("#tel").val()
      if tel.length == 11
        if isTelValid(tel)
            $("#getcode").addClass("ok")
            return false
      $("#getcode").removeClass("ok")
    $("#tel_").keyup ->
      tel = $.trim $("#tel_").val()
      if tel.length == 11
        if isTelValid(tel)
            $("#getcode").addClass("ok")
            return false
      $("#getcode").removeClass("ok")

    # 已注册用户注册时提示
    $(".registrations-tel").keyup ->
      tel = $.trim $(".registrations-tel").val()
      if tel.length == 11
        $.ajax
          type: 'Get'
          url: '/passwords/check_mobile'
          dataType: 'json'
          data: 'mobile': tel
          success: (result) ->
            if result.status == 'ok'
              options =
                cancelText: '取消'
                yesText: '<span style="color: #E62E46;">去登录</span>'
                msg: '手机号已注册,请登录'
                callback: ->
                  window.location.href = "/sign_in"
                cancel: null
              showDialog options
          error: (result)->
            console.log result

# 新版电话验证码登录
$(".new-tel-btn").click ->
    tel = $.trim $("#tel").val()
    code = $.trim $.trim $("#code").val()
    if isTelValid(tel)
      if code == ""
        showDialog "验证码为空"
      else
          # $("form").submit()
          datatObj =
              "tel": $("#tel").val()
              "check_code": $("#code").val()

          $.cookie "tel", tel, expires: 365
          $.ajax {
              cache: false,
              dataType: "json",
              type: 'POST',
              url: "/tel_login",
              data: datatObj,
              success: (message)->
                  if message.status == "ok"
                      token = $.cookie 'remember_token'
                      window.loginCallback(tel, token)
                      if message.return_to
                          location.href = message.return_to
                      else
                          setPassword()
                  else
                      showDialog message.message
              error: ->
          }



 setPassword = ()->
    $(".tel-login").hide()
    htmlStr = $('<div class="cont-box set-password" style="background-color: #fff;padding-left:1.2rem;margin-bottom: 4rem;">
                    <div class="input-box" >
                        <span>密码</span>
                        <div class="password-box">
                          <input type="password" class="" id="hide-password" name="user[Password]" placeholder="请设置密码" required>
                          <input type="text" class="" id="show-password" name="" placeholder="请设置密码" required>
                          <i id="password-btn"></i>
                        </div>
                    </div>
                    <div class="inviteCode-box input-box">
                        <span>业务码</span>
                        <input type="text" id="inviteCode" class="" name="" placeholder="业务员编码，如不确定请填0000" required>
                    </div>
                  </div>
                  <div class="btn set-password-btn">确认</div>')
      # 先注释保留  以防产品变需求
    # <div class="tel-password input-box">
    #   <span>店铺数量</span>
    #   <div class="user-type" id="num">
    #     <label for="one" class="active">一家
    #      <!-- change by lzh  -->
    #       <!-- <input id="one" checked type="radio" name="IsChain" value="0"> -->
    #       <input id="one" checked type="radio" name="IsChain" value= false >
    #       <!-- change by lzh  -->
    #     </label>
    #     <label for="more" >多家
    #       <!-- change by lzh  -->
    #       <!-- <input id="more" type="radio" name="IsChain" value="1"> -->
    #       <input id="more"  type="radio" name="IsChain" value= true >
    #       <!-- change by lzh  -->
    #     </label>
    #   </div>
    # </div>
    # <div class="tel-password input-box">
    #   <span>用户类型</span>
    #   <div class="user-type" id="type">
    #     <label for="user">个人
    #       <input id="user" type="radio" name="userType" value= "0">
    #     </label>
    #     <label for="shop" class="active">零售商
    #       <input id="shop"  checked type="radio" name="userType" value= "1" >
    #     </label>
    #     <label for="com">企业用户
    #       <input id="com" type="radio" name="userType" value= "2"  >
    #     </label>
    #   </div>
    # </div>
    $("main").append htmlStr
    $("#password-btn").click ->
      tempParent = $(@).parent()
      # console.log tempParent
      if tempParent.hasClass("show")
          tempParent.removeClass("show")
      else
          tempParent.addClass("show")
          $("#show-password").val $.trim($("#hide-password").val())
    $("#show-password").change ->
      $("#hide-password").val $.trim($("#show-password").val())
    $(".login-mode").html("设置密码").addClass("ordersHeader_title").removeClass("login-mode")
    $(".header-left").remove()
    $(".header-right").remove()
    $(".set-password-btn").click ->
        setPasswordFn()


# 设置密码按钮
setPasswordFn = ()->
    str = $.trim $("#hide-password").val()
    code = $.trim $("#inviteCode").val()
    # type= $("#type input[name='userType']:checked").val()
    # num= $("#num input[name='IsChain']:checked").val()
    if str == ""
        showDialog "密码不能为空"
        return
    datatObj =
        "Password" : str
        "SalesmanInviteCode" : code
        # "Type": type
        # "IsChain": num
    $.ajax {
        cache: false,
        dataType: "json",
        type: 'POST',
        url: "/passwords/init ",
        data: datatObj,
        success: (message)->
            console.log message
            if message.status == "ok"
                # url = message.return_to + "?showCoupons"
                # url = "/addresses/new?newSignUp=true"
                url = "/addresses/new"
                location.href = url
            else
                showDialog message.error_code
        error: ->
    }

  # 两个电话号码同步
  $("#tel").change ->
    $("#tel_").val $(@).val()
  $("#tel_").change ->
    $("#tel").val $(@).val()
  # 切换登录方式
  $(".login-mode>div").click ->
    if $(@).hasClass "active"
      return
    $(@).addClass("active").siblings().removeClass("active")
    index = $(@).index()
    $(".new-tel>div").eq(index).show().siblings().hide();
  # 两个密码同步
  $("#password-btn").click ->
    tempParent = $(@).parent()
    # console.log tempParent
    if tempParent.hasClass("show")
        tempParent.removeClass("show")
    else
        tempParent.addClass("show")
        $("#show-password").val $.trim($("#hide-password").val())
  $("#show-password").change ->
    $("#hide-password").val $.trim($("#show-password").val())



# 用户类型选择
# $(document).click ".user-type label", (e)->
#     if e.target.nodeName == "INPUT"
#         $(e.target).parent().addClass("active").siblings("label").removeClass("active")












