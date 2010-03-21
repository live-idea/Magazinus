class Good < ActiveRecord::Base
  has_many :cart_items
  has_many :order_items
end
