# //= require jquery2
# //= require vendors/swiper-3.3.1.jquery.min

$ ->
    $("#swiper-container").show()
    setTimeout ->
    	pageno = sessionStorage.getItem('index') || 0;
	    swiper = new Swiper('#swiper-container', {
	        pagination: '.swiper-pagination',
	        paginationClickable: true,
	        initialSlide: pageno,
	        direction: 'vertical',
	        resistanceRatio : 0,
	        onTransitionEnd: ->
	            i= $(".swiper-slide-active").index();
	            sessionStorage.setItem("index",i);
	    })
	, 100
