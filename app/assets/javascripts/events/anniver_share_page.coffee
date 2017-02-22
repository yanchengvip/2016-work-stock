# 分享得一百积分
@getPoints = (m) ->
  $.postJSON '/common/share_page', (o) =>
  	if o.status == 'ok'
	    data =
	        yesText: '确定'
	        msg: '恭喜获得100分享积分'
	        isAlert: true
	        callback: ->
	          window.location.href = "/"
	    showDialog data
  	else
  	  showDialog(o.message)

# 在app中不能领取优惠券
$('.anniver-container a').click (e) ->
	if isInApp()
		e.preventDefault()
		showDialog("请在分享页面领取优惠券")
