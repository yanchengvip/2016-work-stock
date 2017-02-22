//= require jquery
//= require common
//= require vendors/velocity.min
//= require vendors/jquery.fullpage

@loaded = {}

@finishPage = (index) ->
    window.loaded[index] = true
    if index != "p8"
        $("#arrow").velocity("fadeIn").velocity("fadeOut").velocity("fadeIn").velocity("fadeOut").velocity("fadeIn", duration: "fast")

@goToNext = ->
    $('#fullpage').fullpage.moveSectionDown()

@share = ->
    $(".share-tip").show()
    $(".share-tip").click ->
        $(".share-tip").hide()


$(document).ready ->
    $("#audio").click ->
        audio = $("#audio").find("audio")[0]
        if audio.paused
            $(@).removeClass("mute").addClass("play")
            audio.play()
        else
            $(@).removeClass("play").addClass("mute")
            audio.pause()

    $('#fullpage').fullpage
        afterLoad: (anchorLink, index) ->
            if not window.loaded["p#{index}"]
                Actions[index]()
            else
                if index != 8
                    $("#arrow").show()

        onLeave: (index, nextIndex, direction) ->
            if (not window.loaded["p#{index}"]) and direction == "down"
                return false
            else
                $("#arrow").hide()
                return true

Actions =
    1: ->
        $("#p1").click ->
            $("#p1 .l2").velocity "fadeIn", complete: ->
                $("#p1 .l3, #p1 .l4, #p1 .l15").velocity "fadeIn", "duration": "slow", complete: ->
                    $("#p1 .l6").velocity {"margin-left": 0}, "duration": "slow", complete: ->
                        # $("#p1 .l6").velocity("fadeIn").velocity {"scale": "1"}, duration: "slow", complete: ->
                            $("#p1 .l7").velocity("fadeIn")
            $("#p1").off("click")

        $("#p1 .l7").click ->
            $("#p1 .l8, #p1 .l9, #p1 .l10").velocity "fadeIn", duration: "slow", complete: ->
                    $("#audio").show().find("audio")[0].play()
                    $("#p1 .l7").off("click")
                    finishPage("p1")

        $("#p1 .l10").click ->
            goToNext()

    2: ->
        $("#p2 .l1").velocity {"margin-top": 0}, "duration": "slow", complete: ->
        $("#p2 .l2").velocity "fadeIn", "duration": "slow", complete: ->
            $("#p2 .l3").velocity {"margin-top": 0}, "duration": 600, complete: ->
            $("#p2 .l4").velocity "fadeIn", "duration": 1300, complete: ->
                    finishPage("p2")

    3: ->
        $("#p3 .l1").velocity "margin-top": 0, complete: ->
        $("#p3 .l2").velocity "fadeIn", complete: ->
            $("#p3 .l3").velocity "fadeIn", duration: "fast", complete: ->
                $("#p3 .l4").velocity {"margin-left": 0}, duration: 1500, complete: ->
                        finishPage("p3")

    4: ->
        $("#p4 .l1").velocity {"margin-top": 0}, "duration": "slow", complete: ->
        $("#p4 .l2").velocity("fadeIn", "duration": "slow").velocity {"diplay": "none"}, complete: ->
            $("#p4 .l3, #p4 .l4, #p4 .l6, #p4 .l7").velocity "fadeIn", "duration": "slow", complete: ->
                    $("#p4 .l5").velocity {"margin-top": 0}, "duration": "slow", complete: ->
                            finishPage("p4")
    5: ->
        $("#p5 .l1").velocity "margin-top": 0, complete: ->
            $("#p5 .l2").velocity "fadeIn", duration: "fast", complete: ->
                $("#p5 .l2>img").velocity {rotateZ: "180deg"}, complete: ->
                    $("#p5 .l3, #p5 .l4").velocity "fadeIn", complete: ->
                        $("#p5 .l5, #p5 .l6").velocity "fadeIn", complete: ->
                            finishPage("p5")

    6: ->
        $("#p6 .l1").velocity "fadeIn", complete: ->
            $("#p6 .l2, #p6 .l3").velocity {"margin-left": 0}, complete: ->
                $("#p6 .l4, #p6 .l5, #p6 .l6").velocity "fadeIn", complete: ->
                    finishPage("p6")
                    setInterval ->
                        $("#p6 .l6").velocity({translateZ: 0, rotateY: "-160deg"}, duration: 1500).velocity({translateZ: 0, rotateY: "0"}, duration: 1500).velocity({translateZ: 0, rotateY: "160deg"}, duration: 1500).velocity({translateZ: 0, rotateY: "0"}, duration: 1500)
                    , 300

    7: ->
        finishPage("p7")

    8: ->
        finishPage("p8")

