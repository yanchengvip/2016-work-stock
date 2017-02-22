# //= require jquery2
# //= require vendors/jquery.fullpage
# //= require vendors/velocity.min
# //= require vendors/velocity.ui


doc = document.documentElement
clientWidth = Math.min(doc.clientWidth, 640)
doc.style.fontSize = 20 * clientWidth / 640 + 'px'

@loaded = {}

@finishPage = (index) ->
    window.loaded[index] = true

@goToNext = ->
    $('#fullpage').fullpage.moveSectionDown()


$ ->
    $("#img_p1_12, #img_p2_4, #img_p3_3").click ->
        goToNext()

    $('#fullpage').fullpage
        afterLoad: (anchorLink, index) ->
            console.log "onload #{index}"

            if not window.loaded["p#{index}"]
                onLoad(index)

        onLeave: (index, nextIndex, direction) ->
            console.log "onLeave #{index}"
            if direction == "down"
                if not window.loaded["p#{index}"]
                    return false
            return true

actions =
    1: ->
        $("#p1").velocity "fadeIn", complete: ->
            finishPage("p1")
            sequence = []
            for i in [1..6]
                action =
                    e: $("#img_p1_#{i}")
                    p: "transition.bounceIn"
                    o: { duration: 500 }
                sequence.push action
            action =
                e: $("#img_p1_7")
                p: "transition.slideUpIn"
                o: { duration: 500, loop: 2 }
            sequence.push action
            for i in [8..11]
                action =
                    e: $("#img_p1_#{i}")
                    p: "transition.expandIn"
                    o: { duration: 500 }
                sequence.push action
            action =
                e: $("#img_p1_12")
                p: "transition.bounceUpIn"
                o: { duration: 500, loop: 2 }
            sequence.push action
            $.Velocity.RunSequence sequence

    2: ->
        finishPage("p2")
        sequence = []
        for i in [1..3]
            action =
                e: $("#img_p2_#{i}")
                p: "transition.slideUpIn"
                o: { duration: 500 }
            sequence.push action
        action =
            e: $("#img_p2_4")
            p: "transition.bounceUpIn"
            o: { duration: 500, loop: 2 }
        sequence.push action
        $.Velocity.RunSequence sequence

    3: ->
        finishPage("p3")
        sequence = []
        for i in [1..2]
            action =
                e: $("#img_p3_#{i}")
                p: "transition.slideUpIn"
                o: { duration: 500 }
            sequence.push action
        action =
            e: $("#img_p3_3")
            p: "transition.bounceUpIn"
            o: { duration: 500, loop: 2 }
        sequence.push action
        $.Velocity.RunSequence sequence

    4: ->
        finishPage("p4")
        sequence = []
        for i in [1..3]
            action =
                e: $("#img_p4_#{i}")
                p: "transition.slideUpIn"
                o: { duration: 500 }
            sequence.push action
        $.Velocity.RunSequence sequence

onLoad = (index) ->
    actions[index]()

