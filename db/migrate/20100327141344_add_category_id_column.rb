class AddCategoryIdColumn < ActiveRecord::Migration
  def self.up
    add_column :goods, :category_id, :integer
  end

  def self.down
    remove_column :goods, :category_id
  end
end
