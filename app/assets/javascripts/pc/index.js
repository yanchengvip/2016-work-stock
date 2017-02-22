//= require vendors/jquery.cookie
this.getPosition = function(element) {
  var xPosition, yPosition;
  xPosition = 0;
  yPosition = 0;
  while (element) {
    xPosition += element.offsetLeft - element.scrollLeft + element.clientLeft;
    yPosition += element.offsetTop - element.scrollTop + element.clientTop;
    element = element.offsetParent;
  }
  return {
    left: xPosition,
    top: yPosition
  };
};
$(function(){
	//导航


	//banner
    var banner_img = $(".banner_img");
    var banner_li = $(".banner_img").find("li");
    var banner_bt = $(".banner_bt");
    var banner_length = banner_li.length;
    var timer = 5000; //parseInt($("#TitleLoopTime").html() + '000');//循环播放间隔
    var ban = 0;
    banner_li.eq(ban).show();

    /*for (var i = 0; i < banner_length; i++) {
        banner_bt.append($("<li></li>"));

    }*/
    banner_bt.find("a").eq(ban).addClass("active");
    var banner_bt_w = banner_bt.width() / 2;
    banner_bt.css({ "margin-left": "-" + banner_bt_w + "px" });
    banner_img.hover(function () {
        clearInterval(play);
    }, function () {
        play = setInterval(banner_next, timer);
    })
    $(".banner_prev").click(banner_prev);
    $(".banner_next").click(banner_next);

    function banner_prev() {
        ban--;
        if (ban < 0) { ban = banner_length - 1; }
        banner_li.fadeOut(500);
        banner_bt.find("a").removeClass("active");
        banner_bt.find("a").eq(ban).addClass("active");
        banner_li.eq(ban).fadeIn(500);
    }
    function banner_next() {
        ban++;
        banner_li.fadeOut(500);
        if (ban == banner_length) { ban = 0; }
        banner_bt.find("a").removeClass("active");
        banner_bt.find("a").eq(ban).addClass("active");
        banner_li.eq(ban).fadeIn(500);
    }
    $(".banner_bt li").hover(function () {
        var banner_bt_index = $(this).index();
        clearInterval(play)
        banner_bt.find("a").removeClass("active");
        banner_bt.find("a").eq(banner_bt_index).addClass("active");
        banner_li.fadeOut(0);
        banner_li.eq(banner_bt_index).fadeIn(0);
        play = setInterval(banner_next, timer);
    })
    var play = setInterval(banner_next, timer)
	$(".banner").hover(function(){
		$(".banner_prev").stop().fadeIn(500);
		$(".banner_next").fadeIn(500);
	},function(){
		$(".banner_prev").stop().fadeOut(500);
		$(".banner_next").stop().fadeOut(500);
	})

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
    // $(".my_bao").mouseenter(function(){
    //   $(".my_bao_top").find('a').addClass('my_dv_hover');
    //   $(".text_box").css("display","block");
    //   $(".bor").css("display","block");
    // })
    // $(".my_bao").mouseleave(function(){
    //   $(".my_bao_top").find('a').removeClass('my_dv_hover');
    //   $(".text_box").css("display","none");
    //   $(".bor").css("display","none");
    // })



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
    // 扫二维码
    $(".app_down").mouseenter(function(){
      $(".code_box").css("display","block");
    })
    $(".app_down").mouseleave(function(){
      $(".code_box").css("display","none");
    })


    $.fn.numeral = function() {
        $(this).css("ime-mode", "disabled");
        this.bind("keypress",function(e) {
         var code = (e.keyCode ? e.keyCode : e.which);  //兼容火狐 IE
            if(!/msie/.test(navigator.userAgent.toLowerCase()) && (e.keyCode==0x8))  //火狐下不能使用退格键
            {
               return;
            }
            return code >= 48 && code<= 57;
        });
    };
    $(".J_input").numeral();


   /* 点击图片放大 */
    $('.tobig_tu').click(function(){
        $(this).siblings('.big_detail').fadeIn();
    })
    $('.close').click(function(){
        $(this).parent('.big_detail').fadeOut();
    })

    //导航显示隐藏
    $(".nav_category").mouseenter(function(){
      $(".nav_category_section1").css("display","block");
    })
    $(".nav_category").mouseleave(function(){
      $(".nav_category_section1").css("display","none");
    })
    //购物车显示隐藏
    $(".nav_sub .buy_car").mouseenter(function(){
      $(".buy_car_pro").css("display","block");
    })
    $(".nav_sub .buy_car").mouseleave(function(){
      $(".buy_car_pro").css("display","none");
    })

    // // 导航条二级菜单显示隐藏
    // $('.nav_title .first').hover(function(){
    //   $(this).addClass('bag');
    //   // $(this).find('.a1').css('color','#fff')
    //   $(this).find('.goods_box').slideDown(200);
    //   },
    //   function(){
    //   $(this).removeClass('bag');
    //   // $(this).find('.a1').css('color','#434343')
    //   $(this).find('.goods_box').hide();
    // })

    //轮播图

    $('.rgt-btn').click(function(){
        var oUl=$(this).parent('.lunbo').find('ul');
        var oLi=oUl.find('li');
        var len = oUl.find('li').outerWidth(true);
        if(oLi.length<=3){
            $('.lft-btn').unbind('click');
        }else{
            oUl.animate({'margin-left':-len},'slow',function(){
                oUl.find('li').eq(0).appendTo(oUl);
                oUl.css({'margin-left':0});
            });
        }
    });
    $('.lft-btn').click(function(){
        var oUl=$(this).parent('.lunbo').find('ul');
        var oLi=oUl.find('li');
        var len = oUl.find('li').outerWidth(true);
        if(oLi.length<=3){
            $('.lft-btn').unbind('click');
        }else{
            oUl.find('li:last').prependTo(oUl);
            oUl.css({'margin-left':-len});
            oUl.animate({'margin-left':0},'slow');
       }
    });

    //
    $('#selected-city').click(function(){
      if($('#city-list,.city-item').length == $('#city-list.hidden,.city-item.hidden').length){
        var cityId = localStorage.getItem("cityId")
        if(cityId==null){
          $('#city-list').removeClass('hidden');
        }else{
          $('#a'+cityId).removeClass('hidden');
        }
      }else{
        $('#city-list,.city-item').addClass('hidden');
      }


    })

    $('.sc,.region_1 li').click(function(){
      $('#city-list,.city-item').addClass('hidden');
    })

    $('.place-name>a').click(function(){
      $('#city-list, .city-item').addClass('hidden');
      var id = $(this).data('id');
      localStorage.setItem("cityId",id)
      // console.log($('#'+id).removeClass("hidden"));
      $('#a'+id).removeClass('hidden');
    })

    $('.back-btn').click(function(){
      $('.city-item,#city-list').toggleClass('hidden');
    })



    // var ul=$(".region_1 li");
    // ul.click(function(){
    //   var _this = $(this);
    //   var val=_this.text();
    //   var data = _this.find('a').data();
    //   var company = data.companyId;
    //   var depot = data.depotId;
    //   $.cookie('county', val, { expires: 365 , path: '/'});
    //   $.cookie('company_id', company, { expires: 365 , path: '/'});
    //   $.cookie('depot_id', depot, { expires: 365 , path: '/'});
    //   //alert(val);
    //   $('#selected-cont').text(val);
    //   setTimeout(window.location.reload(),0)
    // });
    // 设置当前地区
      // var cookie = $.cookie('county');
      // $('#selected-cont').html(cookie + "<b></b>");

});

var _ID = null;
this.delay = function(run) {
  clearTimeout(_ID);
  return _ID = setTimeout(function() {
    return run();
  }, 300);
};



/*  this.imgFly = function(url, start, end, callback) {
    var img;
    img = new Image();
    img.src = url;
    img.className = "cloned-img";
    $("body").append(img);
    return $(".cloned-img").fly({
      start: getPosition(start),
      end: getPosition(end),
      speed: 1,
      onEnd: function() {
        $(".cloned-img").remove();
        return callback && callback();
      }
    });
  }; */





    // 头部二级菜单的显示隐藏 公共方法
    $(".top-first-nav").mouseenter(function(){
      // $(this).children().eq(0).find("a").toggleClass("my_dv_hover");
      $(this).css("background-color","#fff");
      $(this).children(".top-second-nav").show();
      $(this).children(".bor").show();
      $(this).find("b").css("transform","rotate(180deg)")
      if($(this).find(".city-box").length != 0){
        var str = decodeURI($.cookie("cityname"));
        $(this).find(".city-box a:contains("+ str +")").click();
      }

    })
    $(".top-first-nav").mouseleave(function(){
      // $(this).children().eq(0).find("a").toggleClass("my_dv_hover");
      $(this).css("background-color","transparent");
      $(this).children(".top-second-nav"). hide();
      $(this).children(".bor").hide();
      $(this).find("b").css("transform","rotate(0)")
    })
    // 头部最后一个二级菜单靠右显示不超出
    if($(".head_top_box .right>li:last").hasClass("top-first-nav")){
      $(".head_top_box .right>li:last .text_box").css({"left":"auto","right":"-1px"});
    }


$(function(){
        // 秒杀倒计时
        function buLing(num){
          if( num < 10){
            return "0" + num;
          }else{
            return num;
          }
        }
        // 兼容new data传参数
        function NewDate(str){
          str1 = str.split(' ');
          str2 = str1[0].split('-');
          str3 = str1[1].split(':');

          var data = new Date();
          data.setUTCFullYear(str2[0],str2[1] - 1,str2[2]);
          data.setHours(str3[0]);
          data.setMinutes(str3[1],str3[2]);
          return data;
        }

        function displayTime(){
          if(leftTime < 0){

          }else{
            // var endTime = new Date($(".seckill-time").attr("data-time"));
            if($(".seckill-time").length > 0){
              var endTime = NewDate($(".seckill-time").attr("data-time"));
              // console.log(endTime);
              var now = new Date();
              var leftTime = endTime.getTime() - now.getTime();
              leftTime = parseFloat(leftTime/1000);
              var o = Math.floor(leftTime/3600)
              var d = Math.floor(o/24)
              var m = Math.floor(leftTime/60%60)
              var s = Math.ceil(leftTime%60);
              if(leftTime < 0){
                return;
              }
              $(".seckill-hour").html(buLing(o));
              $(".seckill-minute").html(buLing(m));
              $(".second").html(buLing(s));
              if(s < 0){
                return;
              }
              setTimeout(displayTime,300);
              }
          }
        }
        displayTime();

        // 图片导航 自适应
        switch($(".img-href").attr("data-count")){
          case "2":
            $(".img-href a").css({"width":"518px","height":"195px","marginRight":"40px"});
            break;
          case "4":
            $(".img-href a").css({"width":"256px","marginRight":"16px"});
            break;
          default:
            break;
        }
        // 版块主题颜色
        $(".hot-sell").each(function(){
          var color = $(this).attr("data-color");
          $(this).find(".sell-title").css("borderColor",color);
          $(this).find(".cont-nav a").css({"borderColor":color,"color":color}).mouseenter(function(){
            $(this).css({"backgroundColor":color,"color":"#fff"});
          }).mouseleave(function(){
            $(this).css({"backgroundColor":"transparent","color":color});
          })
        })


        // 楼层导航悬停效果
        $(".floor-nav a").mouseover(function(){
          $(this).find("img").hide();
          $(this).find("span").css("display","block");
        })
        $(".floor-nav a").mouseout(function(){
          $(this).find("img").show();
          $(this).find("span").hide();
        })

        // 左侧侧边栏位置 和 回到顶部显示隐藏
        $(".floor-nav").css({"margin-top":-($(".floor-nav").height()/2),"left":($(window).width() - 1080)/2 - $(".floor-nav").width() - 15});
        $(window).resize(function(){
          var floorLeft = ($(window).width() - 1080)/2 - $(".floor-nav").width() - 15;
          $(".floor-nav").css("left",floorLeft);

        })
        if($(".hot-sell")){
          $(window).scroll(function(){
            if($(".hot-sell").eq(0).offset().top - $("body").scrollTop()  < 460){
              $(".floor-nav").fadeIn("slow");
            }else{
              $(".floor-nav").fadeOut("slow");
            }
          })
        }



        // 左侧楼层导航
        $(".floor-nav a").click(function(){
          var tempId = $(this).attr("_id");
          var targerTop = $(tempId).offset().top;
          $("body").animate({"scrollTop":targerTop - 50});
        })
        // 品牌区跑马灯
        if($(".brand-box").length != 0 && $("#brand-list li").length > 4){
          var liMarginRight = parseInt($("#brand-list li").css("margin-right"));
          var brandWidth = $("#brand-list li").width() + liMarginRight;
          var leftNum = 0;
          var liNum = $("#brand-list li").length;
          for(var i = 0;i < liNum;i++){
            $("#brand-list li").eq(i).clone().appendTo($("#brand-list"));
          }
          $("#brand-list").width(brandWidth * (liNum+1) * 2);
          $(".brand-box")[0].timer = setInterval(function(){
            leftNum -= 2;
            if(leftNum < -brandWidth * liNum -   liMarginRight){
              leftNum = 0;
            }
            $("#brand-list").css({"left":leftNum});
          },30);
          $(".brand-box").mouseenter(function(){
            clearInterval(this.timer);
          })
          $(".brand-box").mouseleave(function(){
            this.timer = setInterval(function(){
              leftNum -= 2;
              if(leftNum < -brandWidth * liNum -   liMarginRight){
                leftNum = 0;
              }
              $("#brand-list").css({"left":leftNum});
            },30);
          })
        }


        // 控制热销版块圆圈内文字的显示方式及鼠标移入移出效果
        $(".nav-box a").each(function(){
          var fontNum = $(this).html().length;
          fontNum == 2 || fontNum == 3 ? $(this).css("line-height","34px") : '';
          // fontNum == 4 ? $(this).html($(this.html().slice()));
          if(fontNum == 4){
            var str = $(this).html();
            var arr = str.split("");
            arr.splice(2,0,"<br>")
            var html = arr.join("");
            $(this).html(html);
          }

        })

        // 限制标题字数
        function htmlStr(html,num){
          return html.slice(0,num) + "...";
        }
        $(".seckill-title,.sell-item-title").each(function(){
          if($(this).html().length > 25){
            var str = $(this).html();
            $(this).html(htmlStr(str,25))
          }
        })

        // 红条动画
        $(".sell-buy").mouseenter(function(){
            var $tempThat = $(this);
            moveCart(this,"100%",function(){
              $tempThat.find('.cart-buy-num').show();
            });
        });
        var oldWidth = $(".sell-buy").width();
        $(".sell-buy").mouseleave(function(){
          var $tempThat = $(this);
          $tempThat.find('.cart-buy-num').hide();
          moveCart(this,oldWidth);
        });

        // // 首次显示
        // var hasShow = sessionStorage.getItem("firstShow");
        // console.log(hasShow);
        // if(hasShow != 1){
        //   $(".first-show").show();
        //   $(".first-show .closed,.first-show .zhezhao").click(function(){
        //     $(".first-show").remove();
        //   })
        //   sessionStorage.setItem("firstShow",1)
        // }

})





























