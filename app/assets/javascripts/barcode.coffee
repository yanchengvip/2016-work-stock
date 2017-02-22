# //= require vendors/moment.js

# $(".info-wrapper p").each ->
#   str = $(@).html()
#   $(@).html moment(str).startOf('hour').fromNow()
$(".delete-icon").click ->
  if $(".no-history").length > 0
    return false
  showDialog
    'cancelText': '确定'
    'yesText': '取消'
    'msg': '确定清空历史记录吗？'
    'position': 'atButtom'
    'cancel': ->
      $(".delete-histories").click()
  setTimeout ->
    $("#msg-box").css("transform","translateY(-100%)")
  ,100


$("#back").click ->
  search = window.location.search
  if search.indexOf("MoreThanOne=true") != -1
    goBack()
  else
    if isAndroid()
       Android.scanBtnClicked()
    else if isiOS()
       window.webkit.messageHandlers.scanBtnClicked.postMessage({})
    goBack()

# 补零
buLing = (num)->
    if(num < 10)
        return "0"+num
    else
        return num

# 秒杀时间到计时
endTime = new Date $(".area.go-seckill").attr("data-time")
nowTime = new Date $(".area.go-seckill").attr("nowTime")
leftTime = endTime.getTime()-nowTime.getTime()
leftTime = parseFloat(leftTime/1000)
clock = $(".seckill-time p span")

displayTime = ->
    leftTime -=  1
    o = Math.floor(leftTime/3600)
    d = Math.floor(o/24)
    m = Math.floor(leftTime/60%60)
    s = Math.ceil(leftTime%60)
    if s < 0
        # clock.html("结束")
        return
    else
      clock.html(buLing(o) + ":"+ buLing(m) + ":" + buLing(s) )
      setTimeout(displayTime,1000)
if $(".area.go-seckill").attr("data-time")
  displayTime()
else
  $(".area-box").remove()
