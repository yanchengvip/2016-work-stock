// 帮助中心显示隐藏
$(function(){
	$('.center_show').click(function(){
		if($(this).siblings('.center_hide').css('display')=='none'){
			$(this).siblings('.center_hide').css('display','block');
			$(this).find('em').removeClass('add');
		}else{
			$(this).siblings('.center_hide').css('display','none');
			$(this).find('em').addClass('add');
		};		
	});
})