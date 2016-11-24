class AddProductWhishersCount < ActiveRecord::Migration
  def change
    add_column :products, :user_product_wishes_count, :integer, default: 0
  end
end
