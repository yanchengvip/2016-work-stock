 /* 吸顶条 */
/*$.fn.topSuction = function(option) {
    option = option || {}
    var fixCls = option.fixCls || 'fixed'
    var fixedFunc = option.fixedFunc
    var resetFunc = option.resetFunc
 
    var $self = this
    var $win  = $(window)
    if (!$self.length) return
 
    var offset = $self.offset()
    var fTop   = offset.top
    var fLeft  = offset.left
 
    // 暂存
    $self.data('def', offset)
    $win.resize(function() {
        $self.data('def', $self.offset())
    })
 
    $win.scroll(function() {
        var dTop = $(document).scrollTop()
        if (fTop < dTop) {
            $self.addClass(fixCls)
            if (fixedFunc) {
                fixedFunc.call($self, fTop)
            }
        } else {
            $self.removeClass(fixCls)
            if (resetFunc) {
                resetFunc.call($self, fTop)
            }
        }
    })
};*/
/*window.onload=function(){
	var oDiv1 = document.getElementById('ceiling');
	var oDiv2 = document.getElementById('ceiling_02');
	window.onscroll=function(){
		var t = oDiv1.offsetTop||oDiv2.offsetTop;
		var scrollTop = document.documentElement.scrollTop||document.body.scrollTop;
		if(scrollTop>t){
			oDiv1.style.position="fixed";
			oDiv2.style.display='block';
		}else{
			oDiv1.style.position="";
			oDiv2.style.display="none";
		}
	};
};*/



