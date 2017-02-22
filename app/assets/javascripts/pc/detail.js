$(function(){
	var shopLenovo_detail = {};
	//图片切换
/*
使用方法示例：
var focus1 = new ShopLenovoFocusImg({boxId:"滚动盒子",childN:"子集名称",numsBox:"底部小圆点盒子",tageN:"需要生成的小圆点标签",_type:"动画模式",t:播放间隔时间,btnP:"往前按钮id",btnN:"往后按钮id",isAuto:是否自动播放});
boxId:滚动盒子id（必须传值）
childN:滚动子集名称，默认是li,也可以是类名（可以不传）
numsBox:底部小圆点盒子（可以不传）
tageN:需要生成的小圆点标签,默认是i （可以不传）
_type:展示类型，两个值 fade和 move,fade为渐变，move为滑动,默认是fade;（可以不传）
t:切换间隔时间，单位为毫秒，默认3000毫秒（可以不传）
btnP:上一屏切换按钮id（可以不传）
btnN:下一屏切换按钮id（可以不传）
isAuto:是否自动播放，默认为true（可以不传）
loop:是否不间断滚动

*/
function ShopLenovoFocusImg(o){
	this.box = $("#"+o.boxId);
	this.childN = o.childN || "li";
	this.li = this.box.find(this.childN);
	this.tagN = o.tageN || "i";
	this._type = o._type || "fade";
	this.loop = o.loop || false;
	this.v = o.v||5;
	var _html = "";
	
	this.minL = this.li.length;
	if(this.loop&&this.minL>this.v){
		//var newHtml = "";
		for(var n = 0;n<this.v;n++){
			this.box.append(this.li.eq(n).clone(true));
		};
	};
	this.li = this.box.find(this.childN);
	this.l = this.li.length;
	this.li.bind("mouseover",function(){
		clearInterval(that.timer);
	});
	this.li.bind("mouseleave",function(){
		that.autoPlay();
	});
	if(this.numBox!=false){		
		this.numBox = $("#"+o.numBox);		
		for(var i = 0;i<this.l;i++){
			_html+="<"+this.tagN+" t='"+i+"' class='ns_num"+(i+1)+"'></"+this.tagN+">";		
		};
		this.numBox.html(_html);
		this.numA = this.numBox.find(this.tagN);
	};

	o.isAuto == false ? this.isAuto = false : this.isAuto = true;	
	var that= this;
	this.moveLi = o.moveLi || false;	
	that.c = 0;
	this.timer = null;
	this.t = o.t||3000;
	if(this.moveLi){ //单个滑动
		this.w = this.li.outerWidth(true);		
		this.maxL = this.l - this.v;		
		this.box.width(this.l*this.w);
		this.l = this.maxL+1;
		
	};
	if(this._type=="move"&&!this.moveLi){		
		//alert();
		this.w = 100/this.l;
		//console.log(this.l*100);
		this.box.width(this.l*100+"%");
		this.li.width(this.w+"%");
	};
	
	if(this.numBox!=false){	
		this.numA.bind("mouseover",function(){
			clearInterval(that.timer);
			if($(this).attr("t")==that.c)return false;
			that.c = $(this).attr("t");
			that.showi(1);
		});
	};
	if(o.btnP){
		this.btnP = $("#"+o.btnP);
		if(this.li.length<4){
			this.btnP.unbind("click");
			// this.btnP.hide();
		}else{		
			this.btnP.bind("click",function(){
				clearInterval(that.timer);
				if(that.loop){
					if(that.c<=0){
						that.c = that.l - 1;	
						that.box.css({left:-that.c*that.w});
					};
					that.c--;
				}else{
					that.c >0?that.c--:that.c=that.l-1;
				};
				that.showi(1);
			});
		}
	};

	if(o.btnN){
		this.btnN = $("#"+o.btnN);
		if(this.li.length<4){
			this.btnN.unbind("click");
			// this.btnN.hide();
		}else{		
			this.btnN.bind("click",function(){
				clearInterval(that.timer);
				if(that.loop){
					//document.title= that.l-1;
					if(that.c>=that.l-1){
						that.box.css({left:0});
						that.c = 0;					
					};
					that.c++;
				}else{
					that.c <that.l?that.c++:that.c=0;			
					
				};
				
				that.showi(1);
			});
		}
	};

	this.showi();
	this.autoPlay();
};

ShopLenovoFocusImg.prototype = {
	autoPlay:function(){
		var that=this;
		if(!that.isAuto)return false;
		this.timer = setInterval(function(){
			that.c <that.l-1?that.c++:that.c=0;
			that.showi();
		},this.t);
	},
	showi:function(t){
		var that= this;
		if(this._type=="fade"){			
			this.li.fadeOut();
			this.li.removeClass("ns_on");
			this.li.eq(this.c).addClass("ns_on");
			this.li.eq(this.c).fadeIn(300,function(){
				if(t){
					that.autoPlay();
				};
			});
		}else if(this._type=="move"){
			if(this.moveLi){
				this.box.stop().animate({left:-this.w*this.c},function(){
					if(t){
						that.autoPlay();
					};
				});
			}else{
				this.box.stop().animate({left:-100*this.c+"%"},function(){
					if(t){
						that.autoPlay();
					};
				});
			};
			
		};
		if(this.numBox!=false){	
			this.numA.removeClass("ns_on");
			this.numA.eq(this.c).addClass("ns_on");
		};
	}
};
	
	
	//大广告
	var shopLenovo_detail_1 = new ShopLenovoFocusImg({boxId:"ns_scroll_box-1",btnN:"ns_scroll_box_next-1",btnP:"ns_scroll_box_pre-1",t:5000,_type:"move",moveLi:true,isAuto:false});
	var shopLenovo_detail_2 = new ShopLenovoFocusImg({boxId:"ns_scroll_box-2",btnN:"ns_scroll_box_next-2",btnP:"ns_scroll_box_pre-2",t:5000,_type:"move",moveLi:true,isAuto:false});
	var shopLenovo_detail_3 = new ShopLenovoFocusImg({boxId:"ns_scroll_box-3",btnN:"ns_scroll_box_next-3",btnP:"ns_scroll_box_pre-3",t:5000,_type:"move",moveLi:true,isAuto:false});

	

	/**/
	shopLenovo_detail.getW = function(){
        var client_h,client_w,scrollTop;
            client_h = document.documentElement.clientHeight || document.body.clientHeight;
            client_w = document.documentElement.clientWidth || document.body.clientWidth;
            scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
            return o = {w:client_w,h:client_h,s:scrollTop};
    };	



    $("#J-ns_tab-nav li a").bind("click",function(){
		var _i = $(this).attr("i");		    	
    	ns_tab_detail('J-ns_tab-nav-','J_ns_tb-Thum-',_i,4);
    	return false;
    });

	
	$("#J-ns-collcation-list .ns_add a").bind("click",function(){
		var p = $(this).parent();											
		if(p.hasClass("ns_delete")){
			$(this).parent().removeClass("ns_delete");	
		}else{
			$(this).parent().addClass("ns_delete");	
		};		
		return false;
	});

	//tab
	function ns_tab_detail(tabId,conId,n,l){	
		for(var i = 1;i<=l;i++){
			$("#"+tabId+i).removeClass("ns_on");	
			$("#"+conId+i).hide();	
		};
		$("#"+tabId+n).addClass("ns_on");	
		$("#J_ns_tb-big").hide();
		$("#J_ns_tb-Thum-3").hide();
		$("#J_ns_tb-Thum-4").hide();
		$("#J_ns_tb-Thum-1").hide();
		$("#J_ns_tb-Thum-2").hide();
		if(n==1){
			$("#J_ns_tb-Thum").show();
			$("#J_ns_tb-big").show();
			$("#J_ns_tb-Thum-1").show();
			var _src = $("#J_ns_tb-Thum-1 li").eq(0).find("a").attr("link");
			$("#J_ns_tb-Thum-1 li").removeClass("ns_on").eq(0).addClass("ns_on");
			shopLenovo_detail.loadImg(_src);		
		};
		if(n==2){
			$("#J_ns_tb-Thum").show();
			$("#J_ns_tb-Thum-2").show();	
			$("#J_ns_tb-big").show();
			var _src = $("#J_ns_tb-Thum-2 li").eq(0).find("a").attr("link");
			$("#J_ns_tb-Thum-2 li").removeClass("ns_on").eq(0).addClass("ns_on");
			shopLenovo_detail.loadImg(_src);		
		};
		if(n==3){
			$("#J_ns_tb-Thum").hide();
			$("#J_ns_tb-Thum-3").show();
			if($("#"+tabId+n).attr("isload")!="1"){
				$("#"+tabId+n).attr("isload",1);
				$("#J_ns_tb-Thum-3d").vc3dEye({
					imagePath:"images/detail/",
					totalImages:51,
					imageExtension:"png"
				});
			};
		};
		
		if(n==4){
			$("#J_ns_tb-Thum").hide();
			$("#J_ns_tb-Thum-4").show();
			if($("#"+tabId+n).attr("isload")!="1"){
				$("#"+tabId+n).attr("isload",1);			
			};		
		};
	};
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

	// form值加减
	$(".i_box .J_add").bind("click",function(){
		var oldValue=parseInt($(this).siblings(".J_input").attr("value"));
		oldValue++;
		$(this).siblings(".J_input").attr("value",oldValue);
	})
	$(".i_box .J_minus").bind("click",function(){
		var oldValue=parseInt($(this).siblings(".J_input").attr("value"));
		oldValue--;
		if(oldValue<0){
			oldValue=0;
			$(this).siblings(".J_input").attr("value","0");
		}else{
			$(this).siblings(".J_input").attr("value",oldValue);
		}		
	})
});


