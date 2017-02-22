//= require jquery2
//= require jquery_ujs
# //= require common
//= require vendors/velocity.min
//= require vendors/jquery.fullpage

doc = document.documentElement
clientWidth = Math.min(doc.clientWidth, 640)
doc.style.fontSize = 20 * clientWidth / 640 + 'px'

@loaded = {}

@finishPage = (index) ->
    window.loaded[index] = true
    if index != "p7"
        $("#arrow").velocity("fadeIn").velocity("fadeOut").velocity("fadeIn").velocity("fadeOut").velocity("fadeIn", duration: "fast")

@goToNext = ->
    $('#fullpage').fullpage.moveSectionDown()

@shareNow = ->
    if isWechat()
        $(".share-tip").show()
        $(".share-tip").click ->
            $(".share-tip").hide()
    else
        shareToWechat(location.href, document.title, document.title)

@showMsg = (s) ->
    $("#msg").text(s)
    $("#pop-up").velocity("fadeIn")



@closeMsg = ->
    $("#pop-up").velocity("fadeOut")


@useNow = ->
    location.href = "/common/wechat_download"

isTelValid = (tel) ->
    tel and /1\d{10}/.test(tel)

@getCoupon = ->
    record = localStorage.getItem "women_s_day_2016"
    if record
        return showMsg('您已参加或此活动')
    tel = $("input").val()
    if isTelValid(tel)
        $.postJSON "/activity/coupon_women_day",phone: tel, (o) ->
            if o.status == 'ok'
                showMsg('恭喜您成功领取优惠券3元！')
                localStorage.setItem "women_s_day_2016", tel
            else
                showMsg(o.message)
    else
        showMsg('手机号码无效')

$ ->
    $("#pop-up").click ->
        closeMsg()

    $('#fullpage').fullpage
        afterLoad: (anchorLink, index) ->
            if not window.loaded["p#{index}"]
                onLoad(index)

            else
                if index != $(".section").length
                    $("#arrow").show()

        onLeave: (index, nextIndex, direction) ->
            if (not window.loaded["p#{index}"]) and direction == "down"
                return false
            else
                $("#arrow").hide()
                return true




onLoad = (index) ->
    $("#p#{index} .l1").velocity "fadeIn", complete: ->
        finishPage("p#{index}")
