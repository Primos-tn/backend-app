class AddCouponsCountsToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :coupons_counts,  :integer, default: 0

  end
end
