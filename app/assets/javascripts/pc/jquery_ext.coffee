_escape = (txt) ->
  $('<div/>').text(txt).html()

$.extend
  confirm: (msg, callback) ->
    msg = _escape msg
    txt = """<div style="text-align: center">
      <div style="font-size: 19px;text-align: center;white-space:nowrap;min-width: 120px;margin: 15px 20px;">
        #{msg}
      </div>
      <button style="font-size: 15px;" id="jq_confirm_btn_ok" class="pure-button pure-button-primary">
        好
      </button>
      <button style="font-size: 15px;" id="jq_confirm_btn_cancel" class="pure-button pure-button-primary">
        算了
      </button>
    </div>"""
    $.fancybox
      content: txt
      openSpeed: "fast"
      closeBtn: false
      helpers :
        overlay:
          # css:
            # 'background': 'none'
          closeClick: false
      afterShow: ->
        $("#jq_confirm_btn_ok").click ->
          callback(true)
          $.fancybox.close()
        $("#jq_confirm_btn_cancel").click ->
          callback(false)
          $.fancybox.close()

  alert: (msg, callback) ->
    msg = _escape msg
    txt = """<div style="text-align: center">
      <div style="font-size: 19px;text-align: center;white-space:nowrap;min-width: 120px;margin: 15px 20px;">
        #{msg}
      </div>
      <button style="font-size: 15px;" id="jq_alert_btn_primary" class="pure-button pure-button-primary">
        好
      </button>
    </div>"""
    $.fancybox
      content: txt
      openSpeed: "fast"
      closeBtn: false
      closeBtn: false
      helpers :
        overlay:
          # css:
            # 'background': 'none'
          closeClick: false
      afterShow: ->
        $("#jq_alert_btn_primary").click ->
          $.fancybox.close()
          callback and callback()
