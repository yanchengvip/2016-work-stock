// 点击显示大图
$(function(){
    $('.tobig_tu').click(function(){
        $(this).siblings('.big_detail').fadeIn();
    })
    $('.close').click(function(){
        $(this).parent('.big_detail').fadeOut();
    })

    // 点击选中	
	$('.click_add').bind("click",function(){        
        $(this).addClass('now').siblings().removeClass('now');
    })
    $('.click_add1').bind("click",function(){        
        if($(this).hasClass('now')){
        	$(this).removeClass('now');        	
        	$(this).parent('.pro_treasure').siblings('.pro_pay').find('.pay_fenqi').hide().siblings('.pay_tocar').show();
        }else{
        	$(this).addClass('now').siblings().removeClass('now');
        	$(this).parent('.pro_treasure').siblings('.pro_pay').find('.pay_fenqi').show().siblings('.pay_tocar').hide();
        }
        
    })

    $('#toggleclass a').click(function(){
    	$(this).toggleClass('on');
    })

    $('#buy span').click(function(){
    	$(this).addClass('now').siblings.removeClass();
    })


})

