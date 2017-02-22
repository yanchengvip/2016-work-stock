function getStyle(obj,name){
	return (obj.currentStyle || getComputedStyle(obj,false))[name];
}
function move(obj,json,options){
	//默认值
	options=options || {};
	options.time=options.time || 700;
	options.type=options.type || 'ease-out';
	
	clearInterval(obj.timer);
	
	var count=Math.round(options.time/30);
	
	var start={};
	var dis={};
	for(var name in json){
		start[name]=parseFloat(getStyle(obj,name));
		//处理样式默认没有给值
		if(isNaN(start[name])){
			switch(name){
				case 'width':
					start[name]=obj.offsetWidth;
					break;
				case 'height':
					start[name]=obj.offsetHeight;
					break;
				case 'left':
					start[name]=obj.offsetLeft;
					break;
				case 'top':	
					start[name]=obj.offsetTop;
					break;	
			}
		}
		dis[name]=json[name]-start[name]
	}
	
	var n=0;
	obj.timer=setInterval(function(){
		n++;
		
		for(var name in json){
			switch(options.type){
				case 'linear':
					var a=n/count;
					var cur=start[name]+dis[name]*a;
					break;
				case 'ease-in':
					var a=n/count;
					var cur=start[name]+dis[name]*Math.pow(a,3);
					break;
				case 'ease-out':
					var a=1-n/count;
					var cur=start[name]+dis[name]*(1-Math.pow(a,3));
					break;
			}
			
			if(name=='opacity'){
				obj.style.opacity=cur;
				obj.style.filter='alpha(opacity:'+cur*100+')';
			}else{
				obj.style[name]=cur+'px';
			}
		}
		
		if(n==count){
			clearInterval(obj.timer);	
			options.fn && options.fn();
		}
	},30);
}


function hoverDir(obj,ev){
	var w=obj.offsetWidth;
	var h=obj.offsetHeight;
	
	var x=obj.offsetLeft+w/2-ev.clientX;
	var y=obj.offsetTop+h/2-ev.clientY;
	
	return Math.round((Math.atan2(y,x)*180/Math.PI+180)/90)%4;
}
window.onload=function(){
	var oUl=document.getElementById('ul1');
	var aLi=oUl.children;
	var aEm=oUl.getElementsByClassName('red_border');
	
	for(var i=0; i<aLi.length; i++){
		aLi[i].index=i;
		aLi[i].onmouseover=function(ev){
			var oEvent=ev || event;
			var n=hoverDir(this,oEvent);
			
			var from=oEvent.fromElement || oEvent.relatedTarget;
			if(this.contains(from))return;
			
			var oEm=aEm[this.index];
			
			switch(n){
				case 0:
					oEm.style.left='600px';
					oEm.style.top=0;
					break;
				case 1:
					oEm.style.left=0;
					oEm.style.top='436px';
					break;
				case 2:
					oEm.style.left='-600px';
					oEm.style.top=0;
					break;
				case 3:
					oEm.style.left=0;
					oEm.style.top='-436px';
					break;
			}
			
			move(oEm,{left:0, top:0});
		};
		
		aLi[i].onmouseout=function(ev){
			var oEvent=ev || event;
			var n=hoverDir(this,oEvent);
			var to=oEvent.toElement || oEvent.relatedTarget;
			if(this.contains(to))return;
			
			var oEm=aEm[this.index];
			switch(n){
				case 0:
					move(oEm,{left:600,top:0});
					break;
				case 1:
					move(oEm,{left:0,top:436});
					break;
				case 2:
					move(oEm,{left:-600,top:0});
					break;
				case 3:
					move(oEm,{left:0,top:-436});
					break;
			}
		};
	}
};









