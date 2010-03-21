class Category < ActiveRecord::Base
  acts_as_tree :order => "title"
  has_many :goods
end
