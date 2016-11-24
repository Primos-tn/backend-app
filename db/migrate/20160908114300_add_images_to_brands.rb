class AddImagesToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :picture, :json
  end
end
