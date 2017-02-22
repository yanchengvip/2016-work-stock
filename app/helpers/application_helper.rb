module ApplicationHelper
  def twitterized_type(type)
    case type
      when "alert"
        "alert-warning"
      when "error"
        "alert-danger"
      when "notice"
        "alert-info"
      when "success"
        "alert-success"
      else
        type.to_s
    end
  end

  def percent_level num
    num >= 60 ? 1 : (num < 30 ? 3 : 2)
  end


  # 判断浏览器是否支持图片的webp后缀，支持则加上
  def image_webp
    request.accepts.include?("image/webp") ? '?imageView2/0/format/webp' : ''
  end

  def third_name(company)
    case company.ThirdType
    when 0
      "进货宝自营商品"
    else
      company.CompanyNameCN.to_s + "商品"
    end
  end

  #价格显示格式控制，保留小数点后两位
  def show_price(price)
    return (number_with_precision(price, :precision => 2)) if price
    return price
  end

end
