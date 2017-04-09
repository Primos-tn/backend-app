class AddLaunchIntervalToProductLaunch < ActiveRecord::Migration[5.0]
  def change
    add_column :product_launches, :start_at, :time
    add_column :product_launches, :end_at, :time
  end
end
