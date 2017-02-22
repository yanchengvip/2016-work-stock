# == Schema Information
#
# Table name: Carts
#
#  ID         :string(36)       default(""), not null, primary key
#  Number     :integer          not null
#  CreateTime :datetime
#  CreateBy   :string(100)
#  UpdateTime :datetime
#  UpdateBy   :string(100)
#  ProductID  :string(36)
#  UserID     :string(36)
#

class Cart < ActiveRecord::Base
  self.table_name = 'Carts'
  include UUIDHelper

  belongs_to  :user, :foreign_key => "UserID"
  belongs_to  :product, :foreign_key => "ProductID"
  belongs_to  :company, :foreign_key => "CompanyID"
  has_many :user_coupons,through: :product,foreign_key: 'ProductID'
  after_save    :update_redis
  after_destroy :delete_redis

  #after_save    :calculate
  #after_destroy :calculate

  private
  def calculate
    carts = self.user.carts.includes(:product).to_a
    self.user.cart_num = carts.count
    self.user.cart_price = carts.inject(0){|r, cart| r + cart.product.ProductPrice * cart.Number}
    self.user.cart_num_checked = carts.inject(0){|r, cart| cart.is_checked? ? r + 1 : r}
    self.user.cart_price_checked = carts.inject(0){|r, cart| cart.is_checked? ? r + cart.product.ProductPrice * cart.Number : r}
  end

  def update_redis
    self.user.cart_hash.store(self.ProductID, self.Number)
  end

  def delete_redis
    self.user.cart_hash.delete(self.ProductID)
  end

end
