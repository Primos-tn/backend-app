class CreateProductCoupons < ActiveRecord::Migration
  def change
    create_table :product_coupons do |t|
      t.integer :product_id
      t.string :value
      t.datetime :expires

      t.timestamps null: false
    end
  end
end
