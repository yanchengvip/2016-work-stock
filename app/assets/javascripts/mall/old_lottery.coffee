# //= require vendors/winwheel
# //= require vendors/TweenMax.min

screenWidth = window.screen.width
$("#canvas").attr("width", screenWidth-20)
$("#canvas").attr("height", screenWidth-20)
$("#prize-pointer").css("left", screenWidth/2-23)


@roling = false
n = 6
data = null

init = =>
    @myWheel = new Winwheel(
      numSegments: 6
      rotationAngle: -30
      innerRadius: 48
      outerRadius: 150
      segments: [
        {
          'fillStyle': '#c0392a'
          'text': '1000元'
        }
        {
          'fillStyle': '#c0392a'
          'text': '500元'
        }
        {
          'fillStyle': '#c0392a'
          'text': '5元'
          'textColor': 'red'
        }
        {
          'fillStyle': '#c0392a'
          'text': '2元'
        }
        {
          'fillStyle': '#c0392a'
          'text': '30积分'
        }
        {
          'fillStyle': '#c0392a'
          'text': '15积分'
        }
      ]
      'animation':
        'type': 'spinToStop'
        'duration': 5
        'spins': 8
        'callbackFinished' : 'stopCallback()')

run = =>
    @roling = true
    init()
    $.postJSON '/mall/point_lottery', (o) =>
        if o.status == 'ok'
            data = o.data
            prize = o.data.level
            myWheel.animation.stopAngle = 360/n*prize-360/n/2
            myWheel.startAnimation()

        else
            showDialog o.message
            @roling = false


$ =>
    init()
    @stopCallback = =>
        prize = data.level
        myWheel.animation.stopAngle = 360/n*prize-360/n/2
        # if prize == 6
        #     showDialog
        #         msg: '很可惜没中奖<br>再抽一次试试手气吧!'
        #         yesText: '试试手气'
        #         cancelText: '以后再来'
        #         callback: ->
        #           $("#canvas").trigger("click")
        # else
        showDialog
            msg: "恭喜您获得<br>#{data.name}!"
            yesText: '继续抽奖'
            cancelText: '查看详情'
            cancel: ->
                location.href = "/mall/lottery_history"

        @roling = false

    $("#canvas").click =>
        if @roling
            return
        else
            # showDialog '此次抽奖将使用20积分<br>确认抽奖吗?', run
            run()




