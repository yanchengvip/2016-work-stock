# == Schema Information
#
# Table name: DepotProductStocks
#
#  ID          :string(36)       default(""), not null, primary key
#  DepotID     :string(36)       default(""), not null
#  ProductID   :string(36)       default(""), not null
#  ProductCode :string(255)
#  Stock       :integer          not null
#  CreateTime  :datetime
#  CreateBy    :string(100)
#  UpdateTime  :datetime
#  UpdateBy    :string(100)
#

class DepotProductStock < ActiveRecord::Base
  self.table_name = 'DepotProductStocks'

  belongs_to :product, :foreign_key => "ProductID"

  def increment_with_sql!(attribute, by = 1)
    raise ArgumentError("Invalid attribute: #{attribute}") unless attribute_names.include?(attribute.to_s)
    original_value_sql = "CASE WHEN #{attribute} IS NULL THEN 0 ELSE #{attribute} END"
    self.class.where(id: self.id).update_all("#{attribute} = #{original_value_sql} + #{by.to_i}")
    reload
  end

  def self.stocks_for product_ids, depot_ids
    return {} if depot_ids.blank?
    product_stocks = DepotProductStock.includes(:product).where(DepotID: depot_ids, ProductID: product_ids, State: 2)
    # product_stocks = DepotProductStock.includes(:product).where(DepotID: depot_ids, ProductID: product_ids)
    return Hash[product_stocks.map{|ps| [ps.ProductID, ps]}]
  end
end
