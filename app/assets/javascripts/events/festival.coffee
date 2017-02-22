# //= require jquery2
# //= require jquery_ujs
# //= require common


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
      LotteryData.prizes.push($("#wrapper .p#{i}"))

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

  $.postJSON '/activity/festival_lottery', (o) ->
    options = {
      msg: ''
      # yesText: """<span style="color:#e62e46">活动专场</span>"""
      # callback: ->
      #   location.href = "http://m.jinhuobao.com.cn/activity/dce66e84-e37b-48da-ae1d-660d9525e4a2"
    }
    if o.status == 'ok'
      result = o.point_lottery
      LotteryData.prize = result.id-1
      LotteryData.callback = ->
        LotteryData.rolling = false

        LotteryData.speed = 50
        LotteryData.times = 0

        if result.id in [5, 8]
          options.msg = "很遗憾未能中奖，明天再来试试运气吧"
        else if result.type_name == '积分'
          options.msg = "恭喜您获得#{result.points}#{result.type_name}"
          # options.cancelText = '查看积分'
          # options.cancel = ->
          #   location.href = "/mall"
        else if result.type_name == '优惠券'
          options.msg = "恭喜您获得#{ result.coupon_price }元#{ result.type_name }"
          options.cancelText = '查看优惠券'
          options.cancel = ->
            location.href = "/my/coupons"
        else
          options.msg = "恭喜您获得#{result.type_name}"

        showDialog(options)

      startRoll()
    else
      options.msg = o.message
      LotteryData.rolling = false
      showDialog(options)


$ ->
  lottery.init()

  $('#start').click ->
    d = new Date()
    month = d.getMonth()
    day = d.getDate()
    if (month + 1) <= 7
      if day <= 20
        start()
        return
    showDialog "活动已结束"


