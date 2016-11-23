class AddProductsCounter < ActiveRecord::Migration
  def change
    add_column :products, :available_in_count, :integer, :default => 0
  end
end
