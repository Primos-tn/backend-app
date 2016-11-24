class AddProductStoresCount < ActiveRecord::Migration
  def change
    add_column :product_stores, :available_count, :integer, :default => 0
  end
end
