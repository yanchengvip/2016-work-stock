$(function() {
    var isOpen = 0;
    ////全局变量，判断是否已经打开弹出框
    //$(".add_new").click(function() {
    //    //$(".box-mask").css({"display":"block"});
    //    $(".zhezhao").fadeIn(500);
    //    center($(".layer"));
    //    //载入弹出窗口上的按钮事件
    //    checkEvent($(this).parent(), $(".btnSure"), $(".btnCancel"));
    //});
    
});
function center(obj) {
        //obj这个参数是弹出框的整个对象
        var screenWidth = $(window).width(), screenHeigth = $(window).height();
        //获取屏幕宽高
        var scollTop = $(document).scrollTop();
        //当前窗口距离页面顶部的距离
        var objLeft = (screenWidth - obj.width()) / 2;
        ///弹出框距离左侧距离
        var objTop = (screenHeigth - obj.height()) / 2 + scollTop;
        ///弹出框距离顶部的距离
        obj.css({
            left:objLeft + "px",
            top:objTop + "px"
        });
        obj.fadeIn(500);
        //弹出框淡入
        isOpen = 1;
        //弹出框打开后这个变量置1 说明弹出框是打开装填
        //当窗口大小发生改变时
        $(window).resize(function() {
            //只有isOpen状态下才执行
            if (isOpen == 1) {
                //重新获取数据
                screenWidth = $(window).width();
                screenHeigth = $(window).height();
                var scollTop = $(document).scrollTop();
                objLeft = (screenWidth - obj.width()) / 2;
                var objTop = (screenHeigth - obj.height()) / 2 + scollTop;
                obj.css({
                    left:objLeft + "px",
                    top:objTop + "px"
                });
                obj.fadeIn(500);
            }
        });
        //当滚动条发生改变的时候
        $(window).scroll(function() {
            if (isOpen == 1) {
                //重新获取数据
                screenWidth = $(window).width();
                screenHeigth = $(window).height();
                var scollTop = $(document).scrollTop();
                objLeft = (screenWidth - obj.width()) / 2;
                var objTop = (screenHeigth - obj.height()) / 2 + scollTop;
                obj.css({
                    left:objLeft + "px",
                    top:objTop + "px"
                });
                obj.fadeIn(500);
            }
        });
    }
    //导入两个按钮事件 obj整个页面的内容对象，obj1为确认按钮，obj2为取消按钮
    function checkEvent(obj, obj1, obj2) {
        //确认后删除页面所有东西       
        obj1.click(function() {
            //移除所有父标签内容
            // obj.remove();
            //调用closed关闭弹出框
            closed($(".zhezhao"), $(".layer"));
            closed($(".zhezhao"), $(".switch_layer"));
        });
        //取消按钮事件
        obj2.click(function() {
            //调用closed关闭弹出框
            closed($(".zhezhao"), $(".layer"));
            closed($(".zhezhao"), $(".switch_layer"));
        });
    }
    //关闭弹出窗口事件
    function closed(obj1, obj2) {
        obj1.fadeOut(500);
        obj2.fadeOut(500);
        isOpen = 0;
    }