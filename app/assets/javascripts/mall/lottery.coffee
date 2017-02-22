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
###
map = {
  1: 0,
  2: 4,
  3: 2,
  4: 6,
  5: 1,
  6: 5
}
###
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


#   del 18e3d2a0-80b0-11e5-a948-00163e000137_lottery_number

start = ->
  if LotteryData.rolling
    return
  else
    LotteryData.rolling = true

  $.postJSON '/mall/point_lottery', (o) =>
  # setTimeout ->
    # o = {"status":"ok","data":{"id":"12a453cf-52f2-4784-aacf-0445c1b306fb","name":"进货宝15积分","type_name":"Point","points":15,"level":6}}
    if o.status == 'ok'
      prize = o.data.level
      LotteryData.prize = map[prize]
      LotteryData.callback = ->
        LotteryData.rolling = false
        LotteryData.speed = 50
        LotteryData.times = 0
        setTimeout ->
          showDialog
              msg: "恭喜您获得<br>#{o.data.name}!"
              yesText: '继续抽奖'
              cancelText: '查看详情'
              cancel: ->
                  location.href = "/mall/lottery_history"
        , 1000
      startRoll()
    else
      LotteryData.rolling = false
      showDialog(o.message)


isOK = false
window.getCerificationStatus 2,->
  isOK = true
$ ->
  lottery.init()

  $('.start').click ->
    start()
    # if isOK
    #   start()
    # else
    #   window.isCerificationTip("认证成功后才能参加抽奖");
