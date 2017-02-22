//= require jquery2
//= require jquery_ujs
//= require common
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

@showClose = ->
    $("#pop-up").addClass("close").velocity("fadeIn")


@showSuccess = (price) ->
    $(".price-text").html(price)
    $("#pop-up").addClass("success").velocity("fadeIn")

@showFail = (price) ->
    $(".price-text").html(price)
    $("#pop-up").addClass("fail").velocity("fadeIn")

@closePopup = ->
    $("#pop-up").removeClass("close success fail").hide()


@useNow = ->
    location.href = "/common/wechat_download"

$(document).ready ->
    $("main").on "click", "#pop-up.close", ->
        closePopup()
        $("input").focus()

    $('#fullpage').fullpage
        afterLoad: (anchorLink, index) ->
            if not window.loaded["p#{index}"]
                if index == 1
                    Actions.init ->
                        onLoad(1)
                else if index <= 5
                    onLoad(index)
                else
                    Actions[index]()

            else
                if index != $(".section").length
                    $("#arrow").show()

        onLeave: (index, nextIndex, direction) ->
            if (not window.loaded["p#{index}"]) and direction == "down"
                return false
            else
                $("#arrow").hide()
                return true

    $("a.button").click ->
        # alert "活动已结束"
        record = localStorage.getItem "new_year_2016"
        if record
            return showFail(record.split("-")[1])
        tel = $("input").val()
        if isTelValid(tel)
            $.postJSON "/activity/coupon_lottery",phone: tel, (o) ->
                if o.status == 'ok'
                    showSuccess(o.data.coupon_price)
                    localStorage.setItem "new_year_2016", "#{tel}-#{o.data.coupon_price}"
                else
                    showFail(o.data.coupon_price)
        else
            showClose()


animationConfig =
    1: "left"
    2: "bottom"
    3: "right"
    4: "right"
    5: "left"


onLoad = (index) ->
    $("#p#{index} .l1").css("margin-top", $(window).height() + 1).show()
    imgPosition = animationConfig[index]
    if imgPosition == 'left'
        start = "margin-left": "-20rem"
        end = "margin-left": 0
    else if imgPosition == "bottom"
        start = "margin-top": "20rem"
        end = "margin-top": 0
    else
        start = "margin-left": "20rem"
        end = "margin-left": 0
    $("#p#{index} .l2").css(start).show()
    setTimeout ->
        $("#p#{index} .l1").velocity {"margin-top": 0}, "duration": "normal", complete: ->
                $("#p#{index} .l2").velocity end, complete: ->
                    finishPage("p#{index}")
    , 0


Actions =
    init: (callback) ->
        $("#p1 .l5").velocity "fadeIn", complete: ->
            $("#p1 .l5").click ->
                $("#p1 .l5").velocity "fadeOut", complete: ->
                    $("#p1 .l3, #p1 .l4").velocity "fadeIn", duration: 1000, complete: ->
                        $("#p1 .l4").velocity {"margin-top": -$(window).height()}, "duration": 3000
                        $("#p1 .l3").velocity {"margin-top": $(window).height()}, "duration": 3000, complete: ->
                                $('#fullpage').addClass "started"
                                $("#p1 .l3, #p1 .l4").remove()
                                $("#back").show()
                                callback()

    6: ->
        $("#p6 .l1, #p6 .l2").velocity "fadeIn", complete: ->
            finishPage("p6")
            # alert "活动已结束"
            record = localStorage.getItem "new_year_2016"
            if record
                showFail(record.split("-")[1])
