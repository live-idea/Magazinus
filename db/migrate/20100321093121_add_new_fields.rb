class AddNewFields < ActiveRecord::Migration
  def self.up
    add_column :goods, :name, :string
    add_column :goods, :price, :decimal
    add_column :goods, :cart_item_id, :integer
    add_column :carts, :cart_item, :integer
    add_column :cart_items, :cart_id, :integer
    add_column :cart_items, :quality, :integer
    add_column :cart_items, :good_id, :integer
    add_column :orders, :status, :string
    add_column :orders, :order_item_id, :integer
    add_column :order_items, :good_id, :integer
    add_column :order_items, :order_id, :integer
  end

  def self.down
    remove_column :goods, :name
    remove_column :goods, :price
    remove_column :goods, :cart_item_id
    remove_column :carts, :cart_item
    remove_column :cart_items, :cart_id
    remove_column :cart_items, :quality
    remove_column :cart_items, :good_id
    remove_column :orders, :status
    remove_column :orders, :order_item_id
    remove_column :order_items, :good_id
    remove_column :order_items, :order_id

  end
end
