class AddViewsCountToProductLaunch < ActiveRecord::Migration[5.0]
  def change
    add_column :product_launches, :views_count, :integer, default: 0
  end
end
