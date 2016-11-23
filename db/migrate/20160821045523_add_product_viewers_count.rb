class AddProductViewersCount < ActiveRecord::Migration
  def change
    add_column :products, :user_product_views_count, :integer, default: 0
  end
end
