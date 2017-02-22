# //= require jquery2
# //= require vendors/jquery.fullpage
# //= require vendors/velocity.min
# //= require vendors/velocity.ui
# //= require common

doc = document.documentElement
clientWidth = Math.min(doc.clientWidth, 640)
doc.style.fontSize = 20 * clientWidth / 640 + 'px'


@loaded = {}

@finishPage = (index) ->
    window.loaded[index] = true
    setTimeout ->
        goToNext()
    , 500

goToNext = ->
    $('#fullpage').fullpage.moveSectionDown()

$ ->
    $('#fullpage').fullpage
        onLeave: (index, nextIndex, direction) ->
            if direction == "down"
                if not window.loaded["p#{index}"]
                    return false
            return true

    $("img.opt").click ->
        src = @.src
        q = @.dataset.q
        root = @.parentNode
        if root.classList.contains("part")
            root = root.parentNode
        for i in $(".opt.checked")
            if i.dataset.q == q
                i.classList.remove("checked")
                i.src = i.src.replace("/b/", "/a/")
        @.classList.add("checked")
        @.src = src.replace("/a/", "/b/")
        finishPage(root.parentNode.id)

    $("#submit").click ->
        if $(".opt.checked").length == 4
            result = {}
            for i in $(".opt.checked")
                data = i.dataset
                result[data.q] = data.v
            # console.log result
            if localStorage.getItem "my_store"
                showDialog "您已参与过本次活动，谢谢！"
            else
                localStorage.setItem 'my_store', json_result
                tel = prompt('请输入联系方式以参加抽奖')
                if tel
                    result['tel'] = tel
                json_result =  JSON.stringify(result)
                $.postJSON '/activity/survey', {'data': json_result}, (o) ->
                    showDialog("提交成功，感谢您的参与！")

        else
            showDialog("请完成所有选项")

