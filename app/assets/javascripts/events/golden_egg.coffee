# //= require vendors/jquery.newsTicker.min
$ ->
  # 中奖信息获取
  $screen = $('#info_ul')
  $.getJSON '/activity/golden_egg_screen', (o) =>
    if o.status == 'ok'
      prize_datas = o.data
      str = ""
      for prize_data in prize_datas
        str += '''<li><span class="tel">'''+prize_data.tel+'''</span><span class="verb">砸中</span><span class="reward">'''+prize_data.prize+'''</span></li>'''
      $screen.append str
      # 中奖信息轮播
      $infoUlLiH = $('#info_ul li').eq(0).height()
      $('#info_ul').newsTicker
        row_height: $infoUlLiH
        max_rows: 4
        speed: 600
        direction: 'up'
        duration: 1300
        autostart: 1
        pauseOnHover: 0
      
  $hammer = $('.hammer')
  $egg = $('.egg')
  $egglie = $('.egg-liehen')
  $eggbroke = $('.egg-broke')
  times = 0
  $eggwrapper = $('.egg-wrapper')
  prizename = 
    0: '日用品品类3元券'
    1: '食品品类5元券'
    2: '1018代金券'
    3: '大卫之选咖啡'
    4: '港澳三日游'
    5: '乐视电视机'
    6: '苹果7'
    7: '再接再励'
  #砸蛋 
  breakEgg = ->
    $hammer.removeClass('shake').addClass 'rotate30'
    setTimeout (->
      $hammer.removeClass 'rotate30'
      return
    ), 300
    $egg.next().css 'display', 'block'
    $egg.remove()
    setTimeout (->
      $hammer.addClass 'rotate30'
      return
    ), 900
    return
  # 关闭提示框
  closeWindow = ->
    $('.shadow').css 'display', 'none'
    return
  # 
  $eggwrapper.on 'click', ->
    $('.chance span').text '0'
    if $egg.length == 0 or times > 0
      return false
    times++
    breakEgg()
    setTimeout (->
      $.postJSON '/activity/golden_egg_lottery', (o) =>
        if o.status == 'ok'
          number = o.data.gift_id
          if number >= 0 and number <= 6
            $egglie.remove()
            $eggbroke.addClass 'win'
            text = prizename[number]
            classStr = "prize" + number
            html = '<div class="popup " id="havePrize">
                    <div class="prize-img"></div>
                    <p class="prize-tip">恭喜您，砸中三等奖：</p>
                    <p class="prize-detail"></p>
                    <a href="javascript:;" class="btn close">关闭</a><a href="/activity/golden_egg_history" class="btn sure">查看</a>
                    </div>'
            $('.shadow').html html
            $('#havePrize .prize-img').addClass classStr
            $('#havePrize .prize-detail').text text
            setTimeout (->
              $('.shadow').css 'display', 'block'
              $('#havePrize').addClass 'popup-win'
              $eggbroke.removeClass('win').addClass 'lose'
              return
            ), 1000
          else
            $egglie.remove()
            $eggbroke.addClass 'win'
            html = '<div class="popup " id="noPrize">
                    <p class="tip">很遗憾>_<，没有砸中</p>
                    <p class="detail">明天再来</p>
                    <a href="javascript:;" class="closebtn">知道啦</a>
                    </div>'
            $('.shadow').html html
            setTimeout (->
              $('.shadow').css 'display', 'block'
              $('#noPrize').addClass 'popup-lose'
              $eggbroke.removeClass('win').addClass 'lose'
              return
            ), 1000
          return
        else
          showDialog(o.message)
    ), 1150
    return
  # 中奖信息轮滚
  
  # 关闭窗口
  $(document).on 'click', '.closebtn,.close', ->
    closeWindow()
    return
  return
