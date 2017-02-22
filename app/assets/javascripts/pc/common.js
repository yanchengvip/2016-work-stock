//= require vendors/jquery.cookie
$(function() {
    /*头部菜单浮动*/
    if ($(".main_nav_top").length > 0) {
        var navH = $(".main_nav_top").offset().top;
        $(window).scroll(function() {
            var scroH = $(this).scrollTop();
            //console.log(scroH);
            //console.log(navH);
            if (scroH > navH) {
                $(".main_nav_top").addClass('header_fixed').removeClass('header_static');
            } else if (scroH <= navH) {
                $(".main_nav_top").addClass('header_static').removeClass('header_fixed');
            }
        });
    }


    // form值加减
    $(".i_box .J_add").bind("click", function(event) {
        var oldValue = parseInt($(this).parent().find(".J_input").val());
        oldValue++;
        $(this).parent().find(".J_input").val(oldValue);
        return false;
    })
    $(".i_box .J_minus").bind("click", function(event) {
        var oldValue = parseInt($(this).parent().find(".J_input").val());
        oldValue--;
        if (oldValue < 1) {
            oldValue = 1;
        }
        $(this).parent().find(".J_input").val(oldValue);
        return false;
    })

    // 导航条背景色
    var urlstr = location.href;
    //alert((urlstr + ‘/’).indexOf($(this).attr(‘href’)));
    var urlstatus = false;
    $(".nav_title .a1").each(function() {
        if ((urlstr + '/').indexOf($(this).attr('href')) > -1 && $(this).attr('href') != "") {
            $(this).parent().addClass("back_g");
            urlstatus = true;
        } else {
            $(this).parent().removeClass("back_g");
        }
    })
    // if (!urlstatus) { $(".nav_title a").eq(0).parent().addClass("back_g"); }




    // 导航条二级菜单显示隐藏
    $('.nav_title .first').hover(function() {
          if($(this).find(".goods_box li").length != 0){
            $(this).addClass('bag');
            // $(this).find('.a1').css('color','#fff')
            $(this).find('.goods_box').slideDown(200);
          }
        },
        function() {
            $(this).removeClass('bag');
            // $(this).find('.a1').css('color','#434343')
            $(this).find('.goods_box').hide();
        })



});




// 异步 延时
var _ID = null;
this.delay = function(run) {
    clearTimeout(_ID);
    return _ID = setTimeout(function() {
        return run();
    }, 300);
};


// 截取内容
function sliceHtml(str, num) {
    if (str.length > num) {
        return str.slice(0, num) + "...";
    } else {
        return str;
    }

}

//产品模块红色条的动画效果
function moveCart(that, target, fn) {
    var $buyNum = $(that).find('.coat-buy-num');
    clearTimeout(that.timer);
    $(that).stop();
    var $tempThat = $(that);
    that.timer = setTimeout(function() {
        $tempThat.animate({ width: target }, function() {
            if (fn != undefined) {
                fn();
            }
        });
    }, 20);
}

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




function showLogin(state) {

    if($(".show-login-box").length > 0){
        return;
    }

    var htmlStr = "",
        url = "";

    var passwordBox = '<div class="test-num">' +
        '<input id="tel-codenum" type="text"  placeholder="请输入验证码" onkeydown="if(event.keyCode == 13){$(\'#login-btn\').click();}" autocomplete="off">' +
        '</div>' +
        '<div class="set-password" >' +
        '<div class="password">' +
        '<input type="" onfocus="this.type= \'password\'" id="password"  class="hide-password" placeholder="请输入密码" onkeydown="if(event.keyCode == 13){$(\'#login-btn\').click();}" autocomplete="off">' +
        '<input type="text"  class="show-password" placeholder="请输入密码" onkeydown="if(event.keyCode == 13){$(\'#login-btn\').click();}"  autocomplete="off" >' +
        '<span class="look-password"></span>' +
        '</div>' +
        '<div class="password-again">' +
        '<input type="" onfocus="this.type= \'password\'" id="password-again"  class="hide-password" placeholder="请确认密码" onkeydown="if(event.keyCode == 13){$(\'#login-btn\').click();}" autocomplete="off">' +
        '<input type="text"  class="show-password" placeholder="请确认密码" onkeydown="if(event.keyCode == 13){$(\'#login-btn\').click();}" autocomplete="off">' +
        '<span class="look-password"></span>' +
        '</div>' +
        '<p class="text-box">点击登录，即表示您同意<a href="javascript:;" onclick="showxy();" class="show-text">《进货宝用户注册协议》</a> </p>' +
        '<p class="forget-password" style="text-align:right;"><a href="javascript:;" class="show-text">忘记密码？</a> </p>' +
        '</div>';

    var otherBox = '<ul class="clearfix">' +
        '<li class="pt-login-link"><a href="javascript:;" >账号密码登录  &gt;</a></li>' +
        '<li class="phone-login-link"><a href="javascript:;" >验证码登录  &gt;</a></li>' +
        '</ul>';
    var LoginBtn = '<input type="button" id="login-btn" class="sub-btn  phone-login-btn" value="无需注册&nbsp;&nbsp;&nbsp;&nbsp;一键登录">';


    htmlStr = $('<div class="zhezhao" style="display:block;"></div>' + '<div class="show-login-box phone-login">' +
        '<h2><span class="title-text">快捷登录</span> <i class="close-login"></i></h2>' +
        '<div class="login-cont">' +
        '<form id="" action="' + url + '" accept-charset="UTF-8" method="post">' +
        '<div style="text-align: center; margin-bottom: 43px;">' +
        '<img src="http://7xshrz.com1.z0.glb.clouddn.com/assets/index/logox-cc05429b17e0e8b76f3e74e9e4865dc06ed8e589cb48a0086ac248a4c858320c.png" alt="logo"  >' +
        '<img style="margin:40px 4px 0 8px" src="http://7xshrz.com1.z0.glb.clouddn.com/assets/index/words-0b70e797884b6aec5c41a6b1f873acfb66aea0af404d7cf9e4a2fb95b00a8831.png" alt="进货无忧">' +
        '</div>' +
        '<div class="input-box">' +
        '<p class="register-link">还没账号？请<a href="javascript:;">注册</a></p>' +
        '<p class="phone-link">已有账号？请<a href="javascript:;">登录</a></p>' +
        '<div class="user-name">' +
        '<input id="tel" type="input"  placeholder="请输入手机号" onkeydown="if(event.keyCode == 13){$(\'#login-btn\').click();}"  autocomplete="off">' +
        '<em class="err-tip is-tel">手机号码有误</em>' +
        '<input type="button" id="getcode" onclick="getMobileCode()" value="获取验证码">' +
        '</div>' +
        passwordBox +
        '</div>' +
        LoginBtn +
        '<div class="other-login">' +
        otherBox +
        '</div>' +
        '</form>' +
        '</div>' +
        '<div class="login_input layer" >' +
        '<a href="javascript:;" class="btnCancel" style="padding-right:14px; width:30px;height:30px; font-size:14px;">关闭</a>' +
        '<iframe src="/common/registerxy" height="100%" width="100%">' +
        '</iframe>' +
        '</div>' +
        '</div>')

    $("body").append(htmlStr);
    $(".close-login").click(function() {
            htmlStr.remove();
        })
    // 切换普通登录按钮
    $(".pt-login-link").click(function() {
        resetTel();
        $(".title-text").text("账号密码登录");
        $(".sub-btn").removeClass("phone-login-btn register-login-btn forget-btn").addClass("pt-login-btn").val("登录");
        $(".show-login-box").removeClass("phone-login register forget").addClass("pt-login");


    })
    // 切换注册
    $(".register-link a").click(function() {
        resetTel();
        $(".title-text").text("快速注册");
        $(".sub-btn").removeClass("pt-login-btn phone-login-btn forget-btn").addClass("register-login-btn").val("注册");
        $(".show-login-box").removeClass("phone-login pt-login forget").addClass("register");
    })

    // 切换验证码登录按钮
    $(".phone-login-link,.phone-link").click(function() {
        resetTel();
        $(".title-text").text("快捷登录");
        $(".sub-btn").removeClass("pt-login-btn register-login-btn forget-btn").addClass("phone-login-btn").val("无需注册    一键登录");
        $(".show-login-box").removeClass("register pt-login forget").addClass("phone-login");
    })
    // 忘记密码切换
    $(".forget-password a").click(function(){
        resetTel();
        $(".title-text").text("忘记密码");
        $(".sub-btn").removeClass("pt-login-btn register-login-btn phone-login-btn").addClass("forget-btn").val("确定");
        $(".show-login-box").removeClass("register pt-login phone-login").addClass("forget");
    })



    // 密码显示隐藏
    $(".look-password").click(function() {
        var tempParent = $(this).parent();
        if ($(this).hasClass("show-look")) {
            $(this).removeClass("show-look");
            tempParent.find(".hide-password").show().eq(0).val(tempParent.find(".show-password").eq(0).val());
            tempParent.find(".show-password").hide();
        } else {
            $(this).addClass("show-look");
            tempParent.find(".show-password").show().eq(0).val(tempParent.find(".hide-password").eq(0).val());
            tempParent.find(".hide-password").hide();
        }
    })






}

$(document).on('keyup', '#tel', function() {
    testMobile();
});


$(document).on("click","#login-btn",function(){
    if($(this).hasClass("phone-login-btn")){
        phoneLoginCheck();
    }else if($(this).hasClass("pt-login-btn")){
        ptLoginCheck();
    }else if($(this).hasClass("register-login-btn")){
        registerCheck();
    }else if($(this).hasClass("forget-btn")){
        forgetCheck();
    }
})
// onkeydown="if(event.keyCode == 13){$('#login-btn').click();}"

// $(document).on("click", ".phone-login-btn", function() {
//     phoneLoginCheck();
// })
// $(document).on("click", ".pt-login-btn", function() {
//     ptLoginCheck();
// })
// $(document).on("click", ".register-login-btn", function() {
//     registerCheck();
// })
// $(document).on("click",".forget-btn",function(){
//     forgetCheck();
// })





function showxy() {
    center($(".layer"));
    //载入弹出窗口上的按钮事件
    $(".btnCancel").click(function() {
        $(".layer").remove();
    })
}

//初始化电话框
function resetTel() {
    $("#tel").siblings(".err-tip").css("color", "red").hide().parent().css("borderColor", "#c0c0c0");
    // $("#getcode").attr({ "disabled": "disabled" }).css({ "backgroundColor": "#E0E0E0", "color": "#606060" });
}
// 验证手机号
function testMobile() {
    if ($("#tel").val() == "") {
        $("#tel").siblings(".err-tip").show().text("手机号码为空").parent().css("borderColor", "red");
        return false;
    }
    if ((/^[1]([3578][0-9]{1})[0-9]{8}$/).test($("#tel").val()) == false) {
        $("#tel").siblings(".err-tip").show().css("color", "red").text("手机号码格式错误").parent().css("borderColor", "red");
        $("#getcode").attr({ "disabled": "disabled" }).css({ "backgroundColor": "#E0E0E0", "color": "#606060" });
        return false;
    } else {
        if ($(".show-login-box").hasClass("register")) {
            isRegister();
        }else if($(".show-login-box").hasClass("forget")){
            isChangePassword();
        } else {
            $("#tel").siblings(".err-tip").hide().parent().css("borderColor", "#c0c0c0");;
            $("#getcode").removeAttr("disabled").css({ "backgroundColor": "#E62E46", "color": "#fff" });
        }
        return true;

    }

}


// 手机号是否可以修改密码
function isChangePassword(){
    if($(".show-login-box").hasClass("forget")){

    }
    $.ajax({
        type: "Get",
        url: "/passwords/check_mobile",
        dataType: "json",
        data: { "mobile": $("#tel").val() },
        success: function(result) {
            if (result.status != "ok") {
                console.log(result);
                $("#tel").siblings(".err-tip").show().css("color", "red").text(result.message).parent().css("borderColor", "red");
                $("#getcode").attr({ "disabled": "disabled" }).css({ "backgroundColor": "#E0E0E0", "color": "#606060" });

            } else {
                canRegister = true;
                $("#tel").siblings(".err-tip").show().text("").css("color", "green").parent().css("borderColor", "#C0C0C0");
                $("#getcode").removeAttr("disabled").css({ "backgroundColor": "#E62E46", "color": "#fff" });
            }
        }
    });
}



// 获取手机验证码
function getMobileCode() {
    var mobile = $("#tel").val();
    if (mobile == "") {
        alert("请输入手机号码！");
        return false;
    } else if ($("#tel").css("borderColor") == "red") {
        alert($("#tel + em").text());
    } else {
        sendcode();
    }
}


var timer1;
var oldNum;
function sendcode() {

    $.ajax({
        cache: false,
        dataType: "json",
        data: { 'tel': $("#tel").val() },
        type: 'POST',
        url: "/send_check_code",
        success: function(e) {
            if (e.status == "ok") {
                alert('验证码发送成功');
                var date = 60;
                timer1 = setInterval(function() {
                    $("#getcode").attr({ "disabled": "disabled" }).addClass("no-use");
                    $("#getcode").val(date + "秒重新获取！");
                    date--;
                    if (date == 0) {
                        $("#getcode").removeAttr("disabled").removeClass("no-use");
                        $("#getcode").val("获取验证码");
                        clearInterval(timer1);
                    }
                }, 1000);
            } else {
                alert(e.message);

            }
        },
        error: function(e) {
            alert(e.message);
        }
    });
}


// phone-login检查
function phoneLoginCheck() {
    testMobile();
    if (!testMobile()) {
        $("#tel").focus();
        alert("手机号码有误 ");
        return false;
    }
    if ($("#tel-codenum").val() == "") {
        $("#tel-codenum").focus();
        $("#tel-codenum").parent().css("borderColor", "red");
        alert("请输入验证码");
        return false;
    }
    // console.log($("#tel").val(),$("#tel-codenum").val());
    $.ajax({
        cache: false,
        dataType: "json",
        type: 'POST',
        url: "/tel_login",
        data: { "tel": $("#tel").val(), "check_code": $("#tel-codenum").val() },
        success: function(message) {

            if (message.status == "ok") {
                if (message.return_to) {
                    location.href = message.return_to;
                } else {
                    $(".user-name,.test-num,.other-login").hide();
                    $(".set-password").show();
                    $(".sub-btn").removeClass("phone-login-btn").addClass("set-password-btn").val("设置");
                    $(".set-password-btn").click(function() {
                        setPasswordFn();
                    })
                }
            } else {
                // $(".user-name,.test-num,.other-login").hide();
                // $(".set-password").show();
                // $(".sub-btn").removeClass("phone-login-btn").addClass("set-password-btn").val("设置");
                // $(".set-password-btn").click(function(){
                //   setPasswordFn();
                // })
                alert(message.message);
            }
        }

    });
}
// 设置密码 post /passwords/init   参数 Password
function setPasswordFn() {
    if ($("#password").val() == "") {
        alert("请输入密码！");
        $("#password").focus();
        return false;
    }
    var password = $(".password input:visible").eq(0).val();
    $.ajax({
        cache: false,
        dataType: "json",
        type: 'POST',
        url: "/passwords/init",
        data: { "Password": password },
        success: function(message) {
            if (message.status == "ok") {
                alert("设置成功！");
                location.href = message.return_to;
            } else {
                console.log(message);
                alert(message.message);
            }
        }

    });
}
// pt-login检查
function ptLoginCheck() {
    testMobile();
    if (!testMobile()) {
        $("#tel").focus();
        alert("电话号码填写错误");
        return false;
    }
    if ($("#password").val() == "") {
        alert("请输入密码！");
        $("#password").focus();
        return false;
    }
    var datatObj = {
        "session": {
            "tel": $("#tel").val(),
            "password": $("#password").val()
        }
    }
    $.ajax({
        cache: false,
        dataType: "json",
        type: 'POST',
        url: "/sign_in",
        data: datatObj,
        success: function(message) {
            if (message.status == "ok") {
                location.href = message.return_to;
            } else {
                alert(message.message);
            }
        }

    });
}

// 检查手机号码是否已注册
var canRegister =false;
function isRegister() {
    $.ajax({
        type: "Get",
        url: "/check_mobile",
        dataType: "json",
        data: { "mobile": $("#tel").val() },
        success: function(result) {
            if (result.status != "ok") {
                $("#tel").siblings(".err-tip").show().css("color", "red").text(result.message).parent().css("borderColor", "red");
                $("#getcode").attr({ "disabled": "disabled" }).css({ "backgroundColor": "#E0E0E0", "color": "#606060" });

            } else {
                canRegister = true;
                $("#tel").siblings(".err-tip").show().text("手机号可以注册").css("color", "green").parent().css("borderColor", "#C0C0C0");
                $("#getcode").removeAttr("disabled").css({ "backgroundColor": "#E62E46", "color": "#fff" });
            }
        }
    });

}


// 注册检查
function registerCheck() {
    testMobile();
    if($("#tel").val() == ""){
        alert("手机号不能为空。");
        return false;
    }
    if ($("#tel-codenum").val() == "") {
        $("#tel-codenum").focus();
        $("#tel-codenum").parent().css("borderColor", "red");
        alert("请输入验证码");
        return false;
    }
    var password = $(".password input:visible").eq(0).val();

    if (password == "") {
        alert("请输入密码！");
        $(".password input:visible").focus();
        return false;
    }

    var datatObj = {
        "user": {
            "Phone": $("#tel").val(),
            "Password": password,
            "password_confirmation": password,
            "check_code": $("#tel-codenum").val(),
            "Type": 1
        }
    }
    $.ajax({
        cache: false,
        dataType: "json",
        type: 'POST',
        url: "/sign_up",
        data: datatObj,
        success: function(message) {
            if (message.status == "ok") {
                location.href = message.return_to;
            } else {
                console.log(message,382);
                alert(message.message);
            }
        }

    });

}


// 忘记密码

function forgetCheck(){
    testMobile();
    if($("#tel").val() == ""){
        alert("手机号不能为空。");
        return false;
    }
    if ($("#tel-codenum").val() == "") {
        $("#tel-codenum").focus();
        // $("#tel-codenum").parent().css("borderColor", "red");
        alert("请输入验证码");
        return false;
    }
    var password = $(".password input:visible").eq(0).val();
    var passwordAgain = $(".password-again input:visible").eq(0).val();
    if (password == "") {
        alert("请输入密码！");
        $(".password input:visible").focus();
        return false;
    }
    if(password != passwordAgain){
        alert("两次输入的密码不一致");
        $(".password input:visible").focus();
        return false;
    }

    var dataObj = {
        "user": {
            "Phone": $("#tel").val(),
            "Password": password,
            "password_confirmation": passwordAgain,
            "check_code": $("#tel-codenum").val()
        }
    }

    $.ajax({
        cache: false,
        dataType: "json",
        type: "POST",
        url: "/passwords",
        data: dataObj,
        success: function(message){
            if(message.status == "ok"){
                alert("设置成功");
                // location.href = message.return_to;
                $(".title-text").text("账号密码登录");
                $(".sub-btn").removeClass("phone-login-btn register-login-btn forget-btn").addClass("pt-login-btn").val("登录");
                $(".show-login-box").removeClass("phone-login register forget").addClass("pt-login");
                $(".show-password").hide().val("");
                $("#password,#passwordAgain").val("").show();
            }else{
                alert(message.message);
            }
        },
        error: function(message){
            alert(message.message);
        }
    })

}





















