class CreateDashboardBrandsStores < ActiveRecord::Migration
  def change
    create_table :brands_stores do |t|
      t.string :name
      t.integer :brand_id
      t.point :position
      t.timestamps null: false
    end
  end
end
