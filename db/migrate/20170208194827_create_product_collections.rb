class CreateProductCollections < ActiveRecord::Migration[5.0]
  def change
    create_table :products_collections do |t|
      t.string :name
      t.integer :brand_id
      t.datetime :last_launch

      t.timestamps
    end
    add_index :products_collections, :brand_id
  end
end
