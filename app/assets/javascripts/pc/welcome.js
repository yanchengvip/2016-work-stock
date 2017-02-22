// JavaScript Document
//= require jquery
//= require vendors/jquery.cookie
if (location.host.indexOf("www") === 0 && /mobile|android/i.test(navigator.userAgent)) {
  location.href = "http://m.jinhuobao.com.cn";
};
$(function(){
	$('#choice').click(function(){
		$('.show').css('display','block');
	})

	$('.city-choice').click(function(){
		var id = $(this).data('id')
		localStorage.setItem("cityId",id)
		$(".show").hide();
		$('#show_'+id).css('display','block');
	})


	$('.place').click(function(){
		/*var id = $(this).parent('.show_2').data('id');*/
		// $('#show_1,#show_2,#show_3').css('display','none');
		$('.show_2').css('display','none');
		$('.show').show();
	})

	$('.county-item').click(function(){
		var company = $(this).data('company-id');
		var countyId = $(this).data('county-id');
		var county = $(this).text();
		var cityId = $(this).data('city-id');
	  var cityname = $('.show_2:visible').find(".place").text();

	    $.cookie('company_id', company, { expires: 365, path: '/'});

	    $.cookie('county_id', countyId, { expires: 365, path: '/'});

	    $.cookie('city_id', cityId, { expires: 365, path: '/'});

	    $.cookie('county', county, { expires: 365, path: '/'});

	    $.cookie('cityname', cityname, { expires: 365, path: '/'});

	    location.href='/';
	})

	var showHeight = $('.show').height();
	$('.show_2').css({"height":showHeight});




})

