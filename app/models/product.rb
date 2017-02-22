# == Schema Information
=begin
Table: Products
Columns:
ID	char(36) PK
Name	varchar(100)
Code	varchar(100)
Slogan	varchar(255)
State	tinyint(3) UN
OrderBy	int(11)
Tag	int(11)
ProductGroupsID	char(36)
Show	longtext
Recommend	int(11)
Describe	longtext
Specification	varchar(255)
ProductPrice	decimal(18,4)
Unit	varchar(255)
Weight	int(11)
PhotoID	char(36)
ServicePoint	decimal(18,2)
CreateTime	datetime
CreateBy	varchar(100)
UpdateTime	datetime
UpdateBy	varchar(100)
HtmlShow	longtext
OriginalPrice	decimal(18,4)
ProductBrandName	varchar(255)
PurchasePrice	decimal(18,4)
Cover	varchar(255)
CoverQiniu	varchar(255)
MovingAverage	decimal(18,4)
Type	int(11)
ProductBrandID	char(36)
MaxSaleAmount	int(11)
Source	int(11)
OrderProductCost	decimal(18,4)
RecommendOrderBy	int(11)
MaxActivityAmount	int(11)
ActivityBeginTime	datetime
ActivityEndTime	datetime
CurrentActivityAmount	int(11)
CompanyID	char(36)
ProductInfoID	char(36)
MaxSaleAmountDay	int(11)
#
# Type = 0:普通商品,1：组合商品，2：秒杀商品，3：特价商品，4:赠品，5:抽奖奖品
=end
class Product < ActiveRecord::Base
  self.table_name = 'Products'

  #belongs_to :group, :class_name => "ProductGroup", :foreign_key => "ProductGroupsID"
  belongs_to :product_info, :foreign_key => "ProductInfoID"
  belongs_to :company, :foreign_key => "CompanyID"
  has_many  :group_products, :foreign_key => "ProductID"
  has_many  :sub_products, :through => :group_products, :source => :sub_product

  #chage by lzh
  has_many :activity_floor_products,:foreign_key => 'ProductID'
  has_many :activity_floors,through: :activity_floor_products

  has_many :carts,foreign_key: 'ProductID'
  has_many :user_coupons,foreign_key: 'ProductID'


  scope :show_recommends, ->{where(Recommend: 3).order("OrderBy")}

  delegate :Unit, :Specification, :HtmlShow, :product_imgs, :Slogan, :ProductGroupsID, :ProductBrandID, :group, to: :product_info

  def cover_url version=nil
    product_info.cover_url(version)
  end

  def product_brandname
    if (product_brand = ProductBrand.find_by(ID: self.ProductBrandID) )
      return product_brand.BrandName
    end
  end

  def stock_for depot_ids
    return nil if depot_ids.blank?
    return DepotProductStock.find_by(DepotID: depot_ids, ProductID: self.id)
  end

  def is_group_product?
    self.Type == 1
  end

  def list_attrs_json
    Jbuilder.encode do |json|
      json.id self.ID
      json.cover self.cover_url('v220')
      json.name self.Name
      if self.ProductPrice
        json.price self.ProductPrice.round(2)
      else
        json.price 0
      end
      # json.price self.ProductPrice.round(2)
      json.unit self.Unit
      json.specification self.Specification
      json.max_sale_amount self.MaxSaleAmount
      json.original_price self.OriginalPrice
      json.slogan self.Slogan if self.Slogan.present?
      json.min_buy_count self.MinBuyCount || 1
      json.sub_products(self.group_products) do |group_product|
        json.number group_product.Number
        json.name group_product.SubProductName
        json.unit group_product.sub_product.Unit
      end
    end
  end

  def increment_with_sql!(attribute, by = 1)
    raise ArgumentError("Invalid attribute: #{attribute}") unless attribute_names.include?(attribute.to_s)
    original_value_sql = "CASE WHEN #{attribute} IS NULL THEN 0 ELSE #{attribute} END"
    self.class.where(id: self.id).update_all("#{attribute} = #{original_value_sql} + #{by.to_i}")
    reload
  end

  def cart_for user
    return 0 if user.blank?
    user.cart_hash.hget(self.ID).to_i
  end

end
