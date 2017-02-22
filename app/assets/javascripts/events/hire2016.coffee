# //= require jquery2
# //= require vendors/swiper-3.3.1.jquery.min

$ ->
    $("#swiper-container").show()
    setTimeout ->
        swiper = new Swiper('#swiper-container', {
            pagination: '.swiper-pagination',
            paginationClickable: true,
            direction: 'vertical'
        })
    , 100
