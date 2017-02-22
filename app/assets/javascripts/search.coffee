$("main").on "click", ".keyword-item, .search-item", ->
    $("input").val $.trim($(@).text())
    that = @;
    setTimeout ->
        # $(".btn-submit").click()
        Turbolinks.visit("/products?q="+$.trim($(that).text()))
    , 0

$(".btn-submit").click ->
    Turbolinks.visit("/products?q="+$.trim($("input").val()))
    # $("form").submit()


$("form").submit ->
    s = $.trim($("input").val())
    if s
        li = getHistoryLi()
        while li.indexOf(s) > -1
            index = li.indexOf(s)
            li.splice(index, 1)
        li.push(s)
        localStorage.setItem "history", JSON.stringify(li)
    true

$(".clean-history").click ->
    localStorage.removeItem "history"
    $(".search-item").remove()

getHistoryLi = ->
    li = localStorage.getItem "history"
    if li
        li = JSON.parse li
    else
        li = []
    li



$ ->
    container = $("#history-search")
    for i in getHistoryLi().reverse()
        container.append """<a href="javascript:;" class="search-item">#{i}</a>"""
    # setTopBarColor('#ffffff')

