module Stock
  module Qiniu
    def self.upload_token
      uptoken = $cache.read("stock-img:upload_token")
      if uptoken.blank?
        put_policy = ::Qiniu::Auth::PutPolicy.new("jinhuobao")
        uptoken = ::Qiniu::Auth.generate_uptoken(put_policy)
        $cache.write("stock-img:upload_token", uptoken, expires_in: 30.minutes)
      end
      return uptoken
    end
  end
end
