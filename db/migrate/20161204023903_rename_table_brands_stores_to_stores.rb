class RenameTableBrandsStoresToStores < ActiveRecord::Migration
  def change
    rename_table :brands_stores, :stores
  end
end
