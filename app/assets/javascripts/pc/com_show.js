// JavaScript Document

$(function(){
	$('.com_show').click(function(){
		var show=$(this).parents('.frist').siblings('.second');
		if($(show).css('display')=='none'){
			$(show).css('display','block');
		}else{
			$(show).css('display','none');
		}
	})

	// 点击选中	
	$('.click_add').bind("click",function(){        
        $(this).addClass('now').siblings().removeClass('now');
    })

    // 显示隐藏
    $(".business_l").mouseenter(function(){
      $(".hover_content").css("display","block");
    })
    $(".business_l").mouseleave(function(){
      $(".hover_content").css("display","none");   
    })

    $(".business_z").mouseenter(function(){
      $(".hover_content2").css("display","block");
    })
    $(".business_z").mouseleave(function(){
      $(".hover_content2").css("display","none");   
    })

    $(".business_r").mouseenter(function(){
      $(".hover_content3").css("display","block");
    })
    $(".business_r").mouseleave(function(){
      $(".hover_content3").css("display","none");   
    })
})
