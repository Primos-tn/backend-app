class AddProductsSizeToProductsCollection < ActiveRecord::Migration[5.0]
  def change
    add_column :products_collections, :product_size, :integer, default: 0
  end
end
