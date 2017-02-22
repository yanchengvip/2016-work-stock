module Utils
  class NumberProcess
    class << self
      def number_to_cn(n)
        n = n.is_a?(String) ? n.to_i : n
        return '零' if n == 0
        result = ''
        num_cn = {1 => '一', 2 => '二', 3 => '三', 4 => '四', 5 => '五', 
                  6 => '六', 7 => '七', 8 => '八', 9 => '九', 0 => ''}
        prev_order = order(n)

        # 处理当以万或亿为单位的时候
        if n >= 100000000
          result << num(n / 100000000) << '亿'
          n = n % 100000000
          prev_order = 100000000
        end
        # 一共出现了三处这样的代码，处理当数量级差开后中间加零的情况
        result << '零' if prev_order / order(n) > 10 && n != 0
        if n >= 100000
          result << num(n / 10000) << "万"
          n = n % 10000
          prev_order = 10000
        end

        while n > 9
          the_order = order(n)
          divisor = n / the_order

          result << '零' if prev_order / the_order > 10
          # 后面的unless处理 一十 -> 十， 一十万 -> 十万的情况
          result << num_cn[divisor] unless divisor == 1 && unit(n) == '十'
          result << unit(n)

          n = n % the_order
          prev_order = the_order
        end
        result << '零' if prev_order / order(n) > 10 && n != 0
        result << num_cn[n]
      end

      def number_to_time(n)
        if n >= 3600
          hour = n / 3600
          l = n % 3600
          minute = l / 60
          second = l % 60
        elsif n < 60
          hour = 0
          minute = 0
          second = n
        else
          hour = 0
          minute = n / 60
          second = n % 60
        end
        return "#{hour.to_s.rjust(2, '0')}:#{minute.to_s.rjust(2, '0')}:#{second.to_s.rjust(2, '0')}"
      end

      private 
      def unit(n)
        %w{十 百 千 万}[n.to_s.length - 2]
      end

      # 当前数的数量级
      def order(n)
        10 ** (n.to_s.length - 1)
      end
    end
  end

  class Client
    class << self
      def poundage money
        ip = Rails.env.production? ? "http://10.26.27.185" : "http://pay.tunnel.jinhuobao.com.cn"
        res = Faraday.get("#{ip}/lfq/fee?paymoney=#{money}")
        if res.status == 200
          return res.body
        else
          return false, '内部错误'
        end
      end
    end
  end
end
