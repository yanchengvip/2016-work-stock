class HFloorItem < ActiveRecord::Base
  self.table_name = 'hflooritems'

  has_many :floor_item_products, ->{order("Sort")}, foreign_key: "HFloorItemID", class_name: "HFloorItemProduct"
  has_many :item_products, through: :floor_item_products, source: :product

  has_many :floor_item_groups, ->{order("Sort")}, foreign_key: "HFloorItemID", class_name: "HFloorItemGroup"
  has_many :product_groups, through: :floor_item_groups, source: :product_group

  has_many :floor_item_brands, ->{order("Sort")}, foreign_key: "HFloorItemID", class_name: "HFloorItemBrand"
  has_many :product_brands, through: :floor_item_brands, source: :product_brand

  def products(depot_ids, company_id=nil)
    _joins, _conditions, _values = [], [], []
    _conditions << "Products.State = 2 and (ActivityBeginTime is null or (ActivityBeginTime <= ? and ActivityEndTime > ?))"
    _values << Time.now << Time.now
    if company_id and Company.need_stock?(company_id)
      _joins << "left join DepotProductStocks dps on dps.ProductID = Products.ID"
      _conditions << "dps.DepotID in (?) and dps.State = 2 and dps.Stock + dps.PreSaleQuantity > 0"
      _values << depot_ids
    else
      _conditions << "SellState = 2"
    end
    if self.ProductRecommendInfoID.present?
      _joins << "left join productrecommendinfodetails prid on prid.ProductID = Products.ID"
      _conditions << "prid.ProductRecommendInfoID = ?"
      _values << self.ProductRecommendInfoID
      Product.includes(:product_info, :group_products => [:sub_product => [:product_info]])
        .joins(_joins.join(" ")).where(_conditions.join(" and "), *_values).order("prid.OrderBy")
    else
      self.item_products.includes(:product_info, :group_products => [:sub_product => [:product_info]])
        .joins(_joins.join(" ")).where(_conditions.join(" and "), *_values)
    end
  end

  def rush_products(depot_ids, company_id=nil)
    _joins, _conditions, _values = [], [], []
    _conditions << "Products.State = 2"
    if company_id and Company.need_stock?(company_id)
      _joins << "left join DepotProductStocks dps on dps.ProductID = Products.ID"
      _conditions << "dps.DepotID in (?) and dps.State = 2 and dps.Stock + dps.PreSaleQuantity > 0"
      _values << depot_ids
    else
      _conditions << "SellState = 2"
    end
    if self.ProductRecommendInfoID.present?
      _joins << "left join productrecommendinfodetails prid on prid.ProductID = Products.ID"
      _conditions << "prid.ProductRecommendInfoID = ?"
      _values << self.ProductRecommendInfoID
      Product.includes(:product_info, :group_products => [:sub_product => [:product_info]])
        .joins(_joins.join(" ")).where(_conditions.join(" and "), *_values).order("prid.OrderBy")
    else
      self.item_products.includes(:product_info, :group_products => [:sub_product => [:product_info]])
        .joins(_joins.join(" ")).where(_conditions.join(" and "), *_values)
    end
  end

  def cover_url version=nil
    if self.PictureQiNiu.present?
      url = Settings.qiniu_base_url + self.PictureQiNiu
      return url + "-" + version if version.in?(%w(v100 v150 v220 v400))
      return url
    end
    return ''
  end

  def recommend_link
    return "/activity/#{self.ProductRecommendInfoID}" if self.ProductRecommendInfoID.present?
    return nil
  end
end
