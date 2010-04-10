class Good < ActiveRecord::Base
  belongs_to  :category
  has_many :cart_items
  has_many :order_items
  has_one  :fuimage
  accepts_nested_attributes_for :fuimage
end
