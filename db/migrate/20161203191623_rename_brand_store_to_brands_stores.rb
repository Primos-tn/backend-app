class RenameBrandStoreToBrandsStores < ActiveRecord::Migration
  def change
    rename_table :brand_stores, :brands_stores
  end
end
