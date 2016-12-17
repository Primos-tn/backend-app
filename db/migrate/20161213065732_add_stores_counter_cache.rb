class AddStoresCounterCache < ActiveRecord::Migration[5.0]
  def change
    add_column :brands, :stores_count, :integer, :default => 0
  end
end
