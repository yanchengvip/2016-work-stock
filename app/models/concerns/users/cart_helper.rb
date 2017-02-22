module Users
  module CartHelper
    extend ActiveSupport::Concern

    included do
      has_many :carts, ->{order("ThirdType, CreateTime desc")}, :foreign_key => "UserID"
    end

    def carts_group(depot_ids)
      group = Hash.new
      # self.carts.includes(:company, :product => [:product_info])
      #           .joins("inner join DepotProductStocks dps on dps.ProductID = Carts.ProductID")
      #           .where("State = 2 and DepotID in (?)", depot_ids).each do |cart|
      #   group[cart.CompanyID] = Array.new if !group[cart.CompanyID]
      #   group[cart.CompanyID] << cart
      # end
      self.carts.includes(:company, :product => [:product_info])
        .joins("inner join DepotProductStocks dps on dps.ProductID = Carts.ProductID")
        .where("DepotID in (?)", depot_ids).each do |cart|
        group[cart.CompanyID] = Array.new if !group[cart.CompanyID]
        group[cart.CompanyID] << cart
      end
      return group
    end

    def add_to_carts cart_attr, depot_ids
      product = Product.find_by(ID: cart_attr[:ProductID])
      return false, "该商品不存在" if !product

      sum, has_buy = cart_attr[:Number].to_i, 0
      cart = Cart.find_by(UserID: self.id, ProductID: cart_attr[:ProductID])
      if cart
        sum += cart.Number
        has_buy += cart.Number
      end

      #return false, "限购#{product.MaxSaleAmount}个，还能购买#{product.MaxSaleAmount - has_buy}个" if self.IsLimitBuy and sum > product.MaxSaleAmount

      if product.Type == 2
        return false, "秒杀商品不能加入购物车"
      elsif product.Type == 4
        return false, "兑换商品不能加入购物车"
      else
        if Company.need_stock?(product.CompanyID)
          stock = product.stock_for depot_ids
          return false, "该商品已下架" if product.State != 2 or !stock or stock.State != 2
          return false, "库存不足" if !stock or (stock.Stock + stock.PreSaleQuantity) <= 0
          return false, "库存不足，剩余#{stock.Stock + stock.PreSaleQuantity}个" if stock.Stock + stock.PreSaleQuantity < sum
        else
          return false, "该商品已下架" if product.State != 2 or product.SellState != 2
        end
      end

      if cart
        number = cart.Number + cart_attr[:Number].to_i
        number = product.MinBuyCount.to_i if number < product.MinBuyCount.to_i
        return cart.update_attributes(Number: number)
      end
      number = cart_attr[:Number].to_i < product.MinBuyCount.to_i ? product.MinBuyCount.to_i : cart_attr[:Number].to_i
      return true if self.carts.create(cart_attr.merge({CompanyID: product.CompanyID, ThirdType: product.ThirdType, Number: number}))
    end

    def update_carts cart, num, depot_ids
      return true if num == 0 and cart.destroy
      product = cart.product
      return false, "特殊商品不能增加数量" if product.Type.in?([2, 4])
      return false, "数量不能小于商品最少起定量 #{product.MinBuyCount.to_i}件" if num < product.MinBuyCount.to_i
      if Company.need_stock?(product.CompanyID)
        stock = product.stock_for depot_ids
        return false, "库存不足" if !stock or (stock.Stock + stock.PreSaleQuantity) <= 0
        return false, "库存不足，剩余#{stock.Stock + stock.PreSaleQuantity}个" if stock.Stock + stock.PreSaleQuantity < num
      end
      return cart.update_attributes(Number: num)
    end

    def delete_carts(ids)
      ids = ids.split(',') if ids.is_a?(String)
      carts = Cart.where(ID: ids)
      user_ids = carts.map(&:UserID)
      return false, "没有权限" if user_ids.uniq.size > 1 or user_ids.first != self.ID
      carts.destroy_all
      return true
    end

    # miao sha
    def check_carts
      self.carts.includes(:product).each do |cart|
        # cart.destroy if cart.product.Type == 2 and (cart.product.ActivityEndTime.blank? or cart.product.ActivityEndTime < Time.now)
        # 赠品
        check_lottery_products cart
      end
    end

    def cart_for_nav depot_ids, company_id, checked=false
      count, price = 0, 0
      cs = self.carts.includes(:product => [:company])
      product_stocks = DepotProductStock.where(DepotID: depot_ids, ProductID: cs.map(&:ProductID))
      product_stocks_hash = Hash[product_stocks.map { |ps| [ps.ProductID, ps] }]
      cs.each do |cart|
        product = cart.product
        if Company.need_stock?(product.CompanyID)
          stock = product_stocks_hash[cart.ProductID]
          if stock and stock.State == 2 and stock.Stock + stock.PreSaleQuantity > 0
            count += 1
            price += product.ProductPrice * cart.Number
          end
        else
          if product.SellState == 2 and (product.company.ThirdType == 3 or product.CompanyID == company_id)
            count += 1
            price += product.ProductPrice * cart.Number
          end
        end if (!checked or cart.is_checked) and product.State == 2 and ( product.Type == 2 or (product.ActivityEndTime.blank? or product.ActivityEndTime > Time.now) )
      # end if (!checked or cart.is_checked) and product.State == 2 and (product.ActivityEndTime.blank? or product.ActivityEndTime > Time.now)
      end
      return count, price.round(2)
    end

    # 删除过期的转盘抽奖赠送的产品
    def check_lottery_products cart
      if cart.product.Type == 5
        count = LotteryHistory.where('UserID = ? and Type = ? and ObjectID = ? and CreateTime > ?  and OrderID is null',self.ID,2,cart.product.ID,Time.now - 7.days).count
        # 超过7天后自动删除该赠品
        if count <= 0
          cart.destroy
        else
          cart.update_attributes(Number: count)
        end

      end
    end

  end
end
