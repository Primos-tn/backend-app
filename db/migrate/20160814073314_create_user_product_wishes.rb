class CreateUserProductWishes < ActiveRecord::Migration
  def change
    create_table :user_product_wishes do |t|
      t.integer :account_id
      t.integer :product_id
      t.timestamps null: false
    end
  end
end
