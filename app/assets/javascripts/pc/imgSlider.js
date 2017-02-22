// 获取非行间样式
function getStyle(obj,name)
{
	if(obj.currentStyle){
		return obj.currentStyle[name];
	}else{
		return getComputedStyle(obj,false)[name];
	}
}
//获取class
function getByClass(oParent,sClass)
{
	var aEle=oParent.getElementsByTagName('*');
	var aResult=[];
	for(var i=0;i<aEle.length;i++){
		if(aEle[i].className==sClass){
			aResult.push(aEle[i]);
		}
	}
	return aResult;
}
//运动框架
function startMove(obj,attr,iTarget)
{
	clearInterval(obj.timer);
	obj.timer=setInterval(function(){
		var cur=0;
		if(attr=='opacity'){
			cur=Math.round(parseFloat(getStyle(obj,attr))*100);
		}else{
			cur=parseInt(getStyle(obj,attr));
		}
		var speed=(iTarget-cur)/6;
		speed=speed>0?Math.ceil(speed):Math.floor(speed);
		if(cur==iTarget){
			clearInterval(obj.timer);
		}else{
			if(attr=='opacity'){
				obj.style.filter='alpha(opacity:'+(cur+speed)+')';
				obj.style.opacity=(cur+speed)/100;
			}else{
				obj.style[attr]=cur+speed+'px';
			}
		}
	},30)
}

window.onload=function()
{
	var oDiv=document.getElementById('imgSlider');
	var oBtnPrev=getByClass(oDiv,'pro_prev')[0];
	var oBtnNext=getByClass(oDiv,'pro_next')[0];

	var oDivSmall=getByClass(oDiv,'pro_img_small')[0];
	var oUlSmall=oDivSmall.getElementsByTagName('ul')[0];
	var aLiSmall=oDivSmall.getElementsByTagName('li');

	var oUlBig=getByClass(oDiv,'pro_img_big')[0];
	var aLiBig=oUlBig.getElementsByTagName('li');

	var nowZIndex=2;
	var now=0;

	// oUlSmall.style.width=aLiSmall.length*(aLiSmall[0].offsetWidth+20)+'px';


	//大图切换
	for(var i=0;i<aLiSmall.length;i++){
		aLiSmall[i].index=i;
		aLiSmall[i].onclick=function()
		{
			if(this.index==now)return;
			now=this.index;
			imgSlider();
		}
		aLiSmall[i].onmouseover=function()
		{
			startMove(aLiSmall[now],'opacity',100);
		}
		aLiSmall.onmouseout=function()
		{
			if(this.index!=now){
				startMove(aLiSmall[now],'opacity',50);
			}			
		}
	}

	//封装一个imgSlider函数
	function imgSlider()
	{
		console.log(now);	
		console.log(aLiSmall.length-2);
		aLiBig[now].style.zIndex=nowZIndex++;

		for(var i=0;i<aLiSmall.length;i++){
			startMove(aLiSmall[i],'opacity',50);
			startMove(aLiBig[i],'opacity',0);
		}
		startMove(aLiSmall[now],'opacity',100);
		startMove(aLiBig[now],'opacity',100);

		if(aLiSmall.length<5){
			startMove(oUlSmall,'top',0);
		}else if(now==0){
			startMove(oUlSmall,'top',0);
		}else if(now==aLiSmall.length-1){
			startMove(oUlSmall,'top',-(now-2)*(aLiSmall[0].offsetHeight+30));
		}else if(now==aLiSmall.length-2){
			startMove(oUlSmall,'top',-(now-1)*(aLiSmall[0].offsetHeight+30));
		}else{
			startMove(oUlSmall,'top',-(now-1)*(aLiSmall[0].offsetHeight+30));
		}

	}

}
