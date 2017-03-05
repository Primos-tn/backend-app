class AddCollectionProductCover < ActiveRecord::Migration[5.0]
  def change
    add_column :products_collections, :cover_id, :integer
  end
end
