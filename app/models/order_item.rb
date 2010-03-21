class OrderItem < ActiveRecord::Base
  belongs_to :orders
  belongs_to :goods
end
