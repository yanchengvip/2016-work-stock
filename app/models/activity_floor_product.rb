class ActivityFloorProduct < ActiveRecord::Base

#   Could not find the source association(s) "product" or :products in model ActivityFloorProduct. Try 'has_many
# :products, :through => :activity_floor_products, :source => <name>'. Is it one of activity_floor?


  belongs_to :activity_floor, :foreign_key => 'ActivityFloorID'
  belongs_to :product, :foreign_key => 'ProductID'

end


