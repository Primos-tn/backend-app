class AddViewsIpAddressToProductViews < ActiveRecord::Migration[5.0]
  def change
    add_column :user_product_views, :latitude, :float
    add_column :user_product_views, :longitude, :float
  end
end
