module Sms
  extend self

  # 融联云
  def send_check_code_0 tel
    code = generate_code tel
    if Settings.sms.enable
      result = Cloopen::SMS.deliver(tel, Settings.sms.check_code_temp, [code, Settings.sms.expire_in])
      return result.first == "000000"
    else
      return true
    end
  end

  # 阿里大于
  def send_check_code_1 tel
    code = generate_code tel
    $cache.write("#{tel}_check_code", code, :expire_in => Settings.sms.expire_in.minutes)
    if Settings.sms.enable
      result = AliDayu.sms_send(tel, {code: code, time: (Settings.sms.expire_in.minutes/60).to_s}, 'SMS_22690002', '进货宝')
      return !!(result.values.first["result"] && result.values.first["result"]["success"])
    else
      return true
    end
  end

  # 助通
  def send_check_code_2 tel
    code = generate_code tel
    if Settings.sms.enable
      content = "【进货宝】您的验证码是#{code}，在#{Settings.sms.expire_in}分钟内有效，如非本人操作请忽略笨短信。"
      tkey = Time.now.strftime("%Y%m%d%H%M%S")
      password = md5(md5("hPyh7n")+tkey)
      response = Faraday.get "http://www.yzmsms.cn/sendSmsYZM.do?username=dwzxyzm&password=#{password}&tkey=#{tkey}&mobile=#{tel}&content=#{content}&xh="
      return !!(response.body.match(Regexp.new("^1,#{Time.now.strftime("%Y%m%d")}\\d{13}")))
    else
      return true
    end
  end

  def send_check_code_s tel
    send("send_check_code_#{rand(3)}", tel)
  end

  def send_check_code_v tel
    code = generate_code tel
    $cache.write("#{tel}_check_code", code, :expire_in => Settings.sms.expire_in.minutes)
    if Settings.sms.enable
      result = AliDayu.voice_send(tel, {code: code, time: (Settings.sms.expire_in.minutes/60).to_s}, 'TTS_22710001', Settings.sms.check_voice_number)
      return !!(result.values.first["result"] && result.values.first["result"]["success"])
    else
      return true
    end
  end

  def generate_code tel
    code = (rand(9000) + 1000).to_s
    $cache.write("#{tel}_check_code", code, :expire_in => Settings.sms.expire_in.minutes)
    return code
  end

  def valid?(tel, check_code)
    return false if tel.blank? or check_code.blank?
    if Settings.sms.enable
      return $cache.read("#{tel}_check_code") == check_code
    end
    return true
  end

  def clear_check_code tel
    $cache.delete("#{tel}_check_code")
  end

  def md5 str
    Digest::MD5.hexdigest(str)
  end

end
