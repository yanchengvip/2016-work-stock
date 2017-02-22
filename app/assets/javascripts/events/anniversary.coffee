#周年庆倒计时提示
$ =>
  endTime = new Date("2016/10/16 00:00:00")
  now = new Date($(".countdown .time-box").attr("data-time"))
  if now > endTime
    $(".countdown-title").html "距离周年庆结束还剩"
    $(".countdown").get(0).classList.remove("anniver-start")
    $(".countdown").get(0).classList.add("anniver-end")
  else
    if now < endTime
      $(".countdown-title").html "距离周年庆开启还剩"

$ ->
  toTwo = (num) ->
    num = if num < 10 then "0" + num else num
    return num.toString().split("")

 #周年庆时间填写
  writeTime = (d,o,m,s) ->
    $(".day em").eq(0).html toTwo(d||0)[0]
    $(".day em").eq(1).html toTwo(d||0)[1]
    $(".hour em").eq(0).html toTwo(o||0)[0]
    $(".hour em").eq(1).html toTwo(o||0)[1]
    $(".minute em").eq(0).html toTwo(m||0)[0]
    $(".minute em").eq(1).html toTwo(m||0)[1]
    $(".second em").eq(0).html toTwo(s||0)[0]
    $(".second em").eq(1).html toTwo(s||0)[1]


  #周年庆开启倒计时
  if true
    currentTime = new Date($(".countdown .time-box").attr("data-time")).getTime()
  anniverStart = ->
    endTime = new Date("2016/10/16 00:00:00")
    leftTime = endTime.getTime() - currentTime
    leftTime = parseFloat(leftTime/1000)
    o = Math.floor(leftTime/60/60)
    d = Math.floor(o/24)
    h = Math.floor(leftTime/60/60 - 24*d)
    m = Math.floor(leftTime/60%60)
    s = Math.ceil(leftTime%60)
    if s < 0
      writeTime()
      return
    else
      writeTime(d,h,m,s)
      currentTime += 1000
      setTimeout(anniverStart,1000)
  #周年庆结束倒计时
  anniverEnd = ->
    endTime = new Date("2016/10/21 00:00:00")
    leftTime = endTime.getTime() - currentTime
    leftTime = parseFloat(leftTime/1000)
    o = Math.floor(leftTime/60/60)
    d = Math.floor(o/24)
    h = Math.floor(leftTime/60/60 - 24*d)
    m = Math.floor(leftTime/60%60)
    s = Math.ceil(leftTime%60)
    if s < 0
      writeTime()
      return
    else
      writeTime(d,h,m,s)
      currentTime += 1000
      setTimeout(anniverEnd,1000)
  if @lptOn
    if $(".anniver-start").length != 0
      anniverStart()
    else if $(".anniver-end").length != 0
      anniverEnd()
    @lptOn = false

#分会场入口 & 预热
$ ->
  $(".nav-list a").each (index,item) ->
    $index = $(".nav-list a.on").index()
    $(@).click ->
      if $index < $(@).index()
        showDialog "该活动还未开始"
      else if $index > $(@).index()
        showDialog "对不起,该活动已结束"
#抽奖规则
$ ->
  $(".rule").click ->
    $(".popup-box").show()

  $(".popup-box .close").click ->
    $(".popup-box").hide()

#周年庆大转盘
LotteryData = {
  current: -1 #当前位置
  count: 0 #奖品数,包括空奖
  speed: 50
  times: 0 #已转过的次数
  cycle: 64 #至少转动次数
  prize: 0 #中奖位置默认值 0-7
  prizes: [] #存储奖品格子
  callback: null,
  rolling: false
}

map = {
  0: 5,
  1: 1,
  2: 6,
  3: 2,
  4: 3,
  5: 7,
  6: 0,
  7: 4
}
prizeList = {
  0: "恭喜您获得 iphone 6s",
  1: "恭喜您获得 30积分",
  2: "恭喜您获得 1000积分",
  3: "抱歉，相信幸运会降临",
  4: "恭喜您获得 红牛一箱",
  5: "恭喜您获得 15积分",
  6: "恭喜您获得 400积分",
  7: "抱歉，相信幸运会降临"
}
class Lottery
  init: ->
    # prizes = []
    # for i in $('.prize')
    #   $el = $(i)
    #   if $el.data('index')
    #     prizes.push($el)
    # prizes.sort((a, b) -> a.data('index')-0 > b.data('index')-0)
    # LotteryData.prizes = prizes
    for i in [1..8]
      LotteryData.prizes.push($(".wrapper .p#{i}"))

  roll: ->
    LotteryData.current += 1
    if LotteryData.current > 7
      LotteryData.current = 0
    last = LotteryData.current - 1
    if last < 0
      last = 7
    LotteryData.prizes[last].removeClass('on')
    LotteryData.prizes[LotteryData.current].addClass('on')

  stop: ->
    clearTimeout(LotteryData.timer)


lottery = new Lottery()

startRoll = ->
  LotteryData.times += 1
  lottery.roll()
  if LotteryData.times > LotteryData.cycle + 8 and LotteryData.prize == LotteryData.current
    clearTimeout(LotteryData.timer)
    LotteryData.callback and LotteryData.callback()
  else
    if LotteryData.times >= LotteryData.cycle
      LotteryData.speed += 40
    LotteryData.timer = setTimeout(startRoll, LotteryData.speed)



start = ->
  if LotteryData.rolling
    return
  else
    LotteryData.rolling = true

  $.postJSON '/activity/anniversary_lottery', (o) =>
    if o.status == 'ok'
      prize = o.data.gift_id
      LotteryData.prize = map[prize]
      LotteryData.callback = ->
        LotteryData.rolling = false
        LotteryData.speed = 50
        LotteryData.times = 0
        setTimeout ->
          showDialog
              msg: "#{ prizeList[LotteryData.prize] } !"
              yesText: '确定'
              cancelText: '查看详情'
              callback: ->
                $(".row .prize").each ->
                  @.classList.remove("on")
              cancel: ->
                  location.href = "/mall/lottery_history"
        , 1000
      startRoll()
    else
      LotteryData.rolling = false
      showDialog(o.message)


$ ->
  lottery.init()

  $('#start').click ->
    start()
   ###
   #d = new Date()
    d = new Date($(".countdown .time-box").attr("data-time"))
    month = d.getMonth()
    day = d.getDate()
    console.log d
    if (month + 1) == 10
      if day < 15
        showDialog "精彩活动马上开启"
      else if day > 20
        showDialog "活动已结束"
      else
        start()
    else if (month + 1) < 10
      showDialog "活动未开启"
    else if (month + 1) > 10
      showDialog "活动已结束，请关注我们的其他活动"
   ### 



# 罗列优惠券
$ ->
  $(".coupon-lpt .item").click ->
   #获取服务端数据
    $that = $(@)
    url = "/coupons/#{$that.attr("data-id")}/collect"

    $.postJSON url, (o) =>
      if o.status == "ok"
        showDialog "领取成功"
      else
        showDialog o.message

     #window.location.reload()

#返回顶部
$ ->
  $backTop = $(".back-to-top")
  height = $(window).height()
  $(document).scroll ->
    top = $(document).scrollTop()
    if top > height
      $backTop.show()
    else
      $backTop.hide()

  $backTop.click ->
    $(document).scrollTop(0)

#吸顶
$ ->
  $navBar = $('.m-nav-wrap')[0]
  headerTop = parseInt($('header').css("height"))
  if $navBar
    navBarTop = $navBar.offsetTop
  $(document).scroll ->
    scrollTop = $(document.body).scrollTop()
    if navBarTop <= scrollTop
      $(".m-nav-stickytabs").css({"position":"fixed","top":"4.4rem"})
    else
      $(".m-nav-stickytabs").css({"position":"relative","top":"0"})

#改变锚点
$ ->
  $(".nav-box .tab , .shadow-nav li").click ->
      index = $(@).index()
      target = $(location.hash)
      if true
        #top = target.offset().top - $(document).scrollTop()
        topTarget = $(".item-box").eq(index).offset().top
        $("html,body").animate({scrollTop: topTarget - 100},300)


$ ->
  $(".item-console").click (event) ->
    event.stopPropagation()

