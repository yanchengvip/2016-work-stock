class ProductRecommendInfoDetail < ActiveRecord::Base
  self.table_name = 'ProductRecommendInfoDetails'

  belongs_to :product, :foreign_key => 'ProductID'
end
