module CommonHelper
  def self.from_platform user_agent
    return 'app' if user_agent.downcase.include?('jinhuobao')
    return 'mobile' if user_agent.downcase.include?('mobile') or user_agent.downcase.include?("android") or user_agent.downcase.include?("ipad")
    return 'pc'
  end

  def from_app? user_agent
    return user_agent.downcase.include?('jinhuobao')
  end

  def from_mobile? user_agent
    return (from_app?(user_agent) or user_agent.downcase.include?('mobile') or user_agent.downcase.include?("android") or user_agent.downcase.include?("ipad"))
  end

  def self.get_order_code
    if $redis.exists("order_code_auto_incr")
      auto_incr_id = $redis.incr("order_code_auto_incr")
      return 'F'+Date.today.strftime("%y%m%d") + auto_incr_id.to_s.rjust(7, '0')
    else
      client = Mysql2::Client.new(ActiveRecord::Base.configurations[Rails.env.to_s].symbolize_keys)
      r = client.query("call PROC_NumIndent('order')")
      order_id = r.first["@indentNum"]
      $redis.set("order_code_auto_incr", order_id[8,6])
      return order_id
    end
  end
end
