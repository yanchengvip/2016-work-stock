$ ->
    $("main").on "click", ".activity-item, .main-list-item", (e) ->
        id = $(@).attr("id").slice(2)
        $el = $(e.target)
        if $el.hasClass("buy-button") or $el.parent().hasClass("buy-button")
            addToCart($(@).find(".action")[0], id, 1)
        else if $el.parents().hasClass("item-console")
            # return false
        else
            showPopup(@)

    # $("main").on "click", "#popup-confirm", ->
    #     console.log(1)
    #     data = JSON.parse document.getElementById("modal").dataset.data
    #     count = $("#count").val() - 0
    #     maxSaleAmount = data.maxSaleAmount - 0
    #     if count > 0
    #         if isLimitBuy and count > maxSaleAmount
    #             Materialize.toast "本商品限购数量 #{maxSaleAmount}", 2000
    #         else
    #             $('#modal').closeModal()
    #             productId = data.id
    #             addToCart $("#p-#{productId}").find(".action")[0], productId, count
