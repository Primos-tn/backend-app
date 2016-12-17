class AddProductsCounterCache < ActiveRecord::Migration[5.0]
  def change
    add_column :brands, :products_count, :integer, :default => 0
  end
end
