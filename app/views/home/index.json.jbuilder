json.status 'ok'
unread_notices = Notification.where(UserID: current_user.ID,IsRead: false)
json.unread_notices_num  unread_notices.length
json.cart_for_nav current_user.cart_for_nav(session[:depot_ids],session[:company_id]).first
json.is_limit_buy current_user.IsLimitBuy
if current_user.unused_coupons(params[:page]) && (dating_coupons_num = current_user.unused_coupons(params[:page]).where("EndDate < ? ", Time.now + 3.days).length) != 0
  json.dating_coupons_num dating_coupons_num
end

json.floors(@floors) do |floor|
  floor_layout_type = floor.LayoutType
  floor_items = floor.floor_items

  json.floor_layout_type floor_layout_type
  json.squareworkshop floor.Squareworkshop

  json.floor_items do
    json.array! floor_items.each_with_index.to_a do |item,index|
      json.href  item.recommend_link || item.LinkUrl
      json.sub_title  item.SubTitle
      json.title item.Title
      case floor_layout_type
        when 0,3
          json.image  item.cover_url
        when 1
          json.image  item.cover_url
        when 2
          if index ==  0
            product = item.rush_products(session[:depot_ids]).where("ActivityBeginTime > ?", Time.now).order("ActivityBeginTime").first
            product_current = item.rush_products(session[:depot_ids]).where("ActivityBeginTime < ? and ActivityBeginTime > ?", Time.now, Date.today).order("ActivityBeginTime").last
            product_current ||= product
            if product_current
              json.buy_status buy_status = (product_current.CurrentActivityAmount.to_i < product_current.MaxActivityAmount.to_i ? "seckill-ing" : "seckill-end")
              if product
                json.next_activity_beign_time product.ActivityBeginTime
              end
              json.activity_beign_time product_current.ActivityBeginTime
              json.activity_end_time product_current.ActivityEndTime
              json.image product_current.cover_url
            end
          else
            json.image  item.products(session[:depot_ids]).first.try(:cover_url)
          end
        when 4,5
          json.image  item.cover_url('v400')
          if floor_layout_type == 4
            item_products = (item.products(session[:depot_ids]).first(8))
            cover_url_type = 'v220'
          else
            item_products = (floor.floor_item and floor.floor_item.products(session[:depot_ids]).first(6))
            cover_url_type = 'v400'
          end
          json.products (item_products) do |product|
            json.id product.ID
            json.list_attrs_json product.list_attrs_json
            json.product_image  product.cover_url(cover_url_type)
            json.corner_mark  product.CornerMark
            json.name product.Name
            json.product_price product.ProductPrice
            json.unit  product.Unit
            json.cart_num product.cart_for(current_user)
            json.min_buy_count product.MinBuyCount
          end if item_products
      end
    end
  end
end

