class Good < ActiveRecord::Base
  belongs_to  :category
  has_many :cart_items
  has_many :order_items
end
