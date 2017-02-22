//= require jquery
//= require jquery_ujs
//= require common
//= require materialize

allowSend = true
$(".pure-button").click (e) ->
    e.preventDefault()
    if allowSend
        sendBtn = $(".pure-button")
        tel = $input("Phone").val()
        if isTelValid tel
            $.post "/send_check_code.json", tel: tel, (o) ->
                sendBtn.addClass("pure-button-disabled")
                Materialize.toast '验证码已发送，请注意查收', 2000
                allowSend = false
                setTimeout ->
                    $('[name="check_code"]').focus()
                    n = 120
                    intevalId = setInterval ->
                        sendBtn.html "#{n} 秒可重发"
                        n -= 1
                        if n == 0
                            clearInterval(intevalId)
                            sendBtn.removeClass("pure-button-disabled").html "点击发送"
                            allowSend = true
                    , 1000
                , 0
        else
            Materialize.toast '手机号码格式不正确', 2000
            $('[name="user[Phone]"]').focus()

$(".cash").click (e) ->
    e.preventDefault()
    tel = $input("Phone").val()
    code = $input("check_code").val()
    if not code
        msg = "请输入验证码"
    if not isTelValid(tel)
        msg = "手机号码格式不正确"
    if msg
       Materialize.toast msg, 2000
    else
        $.postJSON "/invitations/accept", Phone: tel, check_code: code, (o) ->
            if o.status == 'ok'
                $("main").removeClass("normal").addClass("success")
            else if o.message == '验证码错误!'
                Materialize.toast '验证码错误!', 2000
            else if o.message == '您已领取奖励'
                $("main").removeClass("normal").addClass("registered")


