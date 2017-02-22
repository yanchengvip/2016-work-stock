/* 购物车 */
window.onload=function(){
  var oBox = document.getElementById('buy_car_pro');
  var oDiv = document.getElementById('buy_car');

  oDiv.onmouseover=function(){
    move(oDiv,232,700,function(){
      oBox.style.display="block";
    });
  };

  oDiv.onmouseout=function(){
    move(oBox,206,700,function(){
      oBox.style.display="none";
    });
  };
};

/* move */
function getStyle(obj,name){
  return obj.currentStyle?obj.currentStyle[name]:getComputedStyle(obj,false)[name];
}
function move(obj,json,options){
  options=options||{};
  options.time=options.time||700;
  var start={};
  var dis={};
  for(var name in json){
    if(name=='opacity'){
      start[name]=parseFloat(getStyle(obj,name));
    }else{
      start[name]=parseInt(getStyle(obj,name));
    }
    dis[name]=json[name]-start[name];
  }
  var count = Math.round(options.time/30);
  var n=0;
  clearInterval(obj.timer);
  obj.timer=setInterval(function(){
    n++;
    
    for(var name in json){
      var cur = start[name]+dis[name]*n/count;
      if(name=='opacity'){
        obj.style.opacity=cur;
        obj.style.filter="alpha(opacity:"+cur*100+")";
      }else{
        obj.style[name]=cur+'px';
      }
    }
    if(n==count){
      clearInterval(obj.timer);
      options.fn&&options.fn();
    }
  },30);
}

