// JavaScript Document
$(function(){
	//注册显示与隐藏
	$(".my_dv").mouseenter(function(){
	  $(".my_top").find('a').addClass('my_dv_hover');
	  $(".dv_box").css("display","block");
	  $(".border").css("display","block");  
	})
	$(".my_dv").mouseleave(function(){
	  $(".my_top").find('a').removeClass('my_dv_hover');
	  $(".dv_box").css("display","none");
	  $(".border").css("display","none");	
	})
    //我的进货宝显示与隐藏
	$(".my_bao").mouseenter(function(){
	  $(".my_bao_top").find('a').addClass('my_dv_hover');
	  $(".text_box").css("display","block");
	  $(".bor").css("display","block");  
	})
	$(".my_bao").mouseleave(function(){
	  $(".my_bao_top").find('a').removeClass('my_dv_hover');
	  $(".text_box").css("display","none");
	  $(".bor").css("display","none");	
	})
    //客服服务显示与隐藏
	$(".service").mouseenter(function(){
	  $(".service_top").find('a').addClass('my_dv_hover');
	  $(".service_box").css("display","block");
	  $(".borde").css("display","block");  
	})
	$(".service").mouseleave(function(){
	  $(".service_top").find('a').removeClass('my_dv_hover');
	  $(".service_box").css("display","none");
	  $(".borde").css("display","none");	
	})
    //收藏夹显示与隐藏
	$(".collect").mouseenter(function(){
	  $(".collect_top").find('a').addClass('my_dv_hover');
	  $(".car_box").css("display","block");
	  $(".bord").css("display","block"); 
	  $(".collent_a").find("i").addClass('btn_t');
	})
	$(".collect").mouseleave(function(){
	  $(".collect_top").find('a').removeClass('my_dv_hover');
	  $(".car_box").css("display","none");
	  $(".bord").css("display","none");
	  $(".collent_a").find("i").removeClass('btn_t');	
	})
    //消息显示与隐藏
	$(".news").mouseenter(function(){
	  $(".news_top").find('a').addClass('my_dv_hover');
	  $(".news_box").css("display","block");
	  $(".borde").css("display","block"); 
	})
	$(".news").mouseleave(function(){
	  $(".news_top").find('a').removeClass('my_dv_hover');
	  $(".news_box").css("display","none");
	  $(".borde").css("display","none");	
	})
    //食品类
	$(".nav_category_item_first").mouseenter(function(){
	  $(this).find('h3').addClass('red');
	  $(this).find('h3').find('span').addClass('icon');
	  $(".product_list").css("display","block");
	  $(".nav_category_item_first").css("background","#fff");
	  $(".red_border ").css("display","block");
	})
	$(".nav_category_item_first").mouseleave(function(){
	  $(this).find('h3').removeClass('red');
	  $(this).find('h3').find('span').removeClass('icon');
	  $(".product_list").css("display","none");
	  $(".nav_category_item_first").css("background","#e7375a"); 
	  $(".red_border ").css("display","none");
	})
    //日用品显示
	$(".nav_category_item_second").mouseenter(function(){
	  $(this).find('h3').addClass('red');
	  $(this).find('h3').find('span').addClass('icon');
	  $(".product_list_b").css("display","block");
	  $(".nav_category_item_second").css("background","#fff");
	  $(".red_border_b ").css("display","block");
	})
	$(".nav_category_item_second").mouseleave(function(){
	  $(this).find('h3').removeClass('red');
	  $(this).find('h3').find('span').removeClass('icon');
	  $(".product_list_b").css("display","none");
	  $(".nav_category_item_second").css("background","#ba5bdd"); 
	  $(".red_border_b").css("display","none");
	})
	//消息更多与收起
	$('.buy_pro').find('img').hide().slice(0,3).show();
	$('.showmore').toggle(function(){
		$(this).find('i').html('收起');
		$(this).siblings('img').show();
	},function(){
		$(this).find('i').html('●●●');
		$(this).siblings('img').hide().slice(0,3).show();
	});
})