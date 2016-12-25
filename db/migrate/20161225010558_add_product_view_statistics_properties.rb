class AddProductViewStatisticsProperties < ActiveRecord::Migration[5.0]
  def change
    add_column :user_product_views, :ip_address, :inet
    add_column :user_product_views, :count, :integer, default: 0
  end
end
