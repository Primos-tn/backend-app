class AddProductsCollectionIdToProductLaunch < ActiveRecord::Migration[5.0]
  def change
    add_column :product_launches, :products_collection_id, :integer
  end
end
