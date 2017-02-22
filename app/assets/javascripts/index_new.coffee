# window.$ = (s) ->
#   i = document.querySelector(s)
#   if i
#     i.css = window.getComputedStyle(i)
#   return i



# $('.top').css.height

//= require jquery2
//= require vendors/swiper-3.3.1.jquery.min
//= require vendors/velocity.min

if location.host.indexOf("www") == 0 && /mobile|android/i.test(navigator.userAgent)
  location.href = location.href.replace("www.jinhuobao", "m.jinhuobao").replace("www.jhb", "m.jhb")



swiper = new Swiper '.swiper-container',{
  pagination : '.swiper-pagination',
  direction: 'vertical',
  slidesPerView: 1,
  paginationClickable: true,
  mousewheelControl: true,
  keyboardControl : true,
  onSlideChangeEnd: (swiper) ->
      swiperStr = ".swiper" + swiper.snapIndex
      $(swiperStr).addClass("move")

  onSlideChangeStart: ->
      if swiper.snapIndex != 0
        $("#next-page a").removeClass("move")
      else
        $("#next-page a").addClass("move")

      if swiper.snapIndex == 4
        $("#next-page").hide()
      else
        $("#next-page").show()
}

# 回到顶部
$ ->
  $(window).scroll ->
    if $('body').scrollTop() > 800
      $('#to-top').addClass("show-top")
    else
      $('#to-top').removeClass("show-top")
    return
  #当点击跳转链接后，回到页面顶部位置
  $('#to-top').click ->
    $('body,html').animate { scrollTop: 0 }, 600
    false
    return

  $(".second a").each ->
    nameStr = window.location.pathname
    if nameStr.indexOf($(this).attr("href")) > -1
      $(".second a").removeClass("active")
      $(this).addClass("active")
      $(".second").show()

  # 分页
  # $(".pagination span").each ->
  #   if $(@).find("a").length == 0
  #     $(@).addClass("active")
  #     return false


