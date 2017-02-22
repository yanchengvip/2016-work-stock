$(function(){    
    $('.rgt-btn').click(function(){
        var oUl=$(this).siblings('.lunbo-box').find('ul');
        var len = oUl.find('li').outerWidth(true);
        oUl.animate({'margin-left':-len},'slow',function(){
            oUl.find('li').eq(0).appendTo(oUl);
            oUl.css({'margin-left':0});
        });
    });
    $('.lft-btn').click(function(){
        var oUl=$(this).siblings('.lunbo-box').find('ul');
        var len = oUl.find('li').outerWidth(true);
        oUl.find('li:last').prependTo(oUl);
        oUl.css({'margin-left':-len});
        oUl.animate({'margin-left':0},'slow');
    });
    var timer=setInterval(function(){
        $('.rgt-btn').click();
    },4000);
    $('.solution_list').hover(function(){
        clearInterval(timer);
    },function(){
        timer=setInterval(function(){
            $('.rgt-btn').click();
        },4000);
    })        
})

    