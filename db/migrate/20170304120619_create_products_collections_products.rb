class CreateProductsCollectionsProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products_collections_products do |t|
      t.integer :products_collection_id
      t.integer :product_id

      t.timestamps
    end
  end
end
