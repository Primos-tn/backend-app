class CreateUserProductShares < ActiveRecord::Migration
  def change
    create_table :user_product_shares do |t|

      t.integer :account_id
      t.integer :product_id
      t.json :data
      t.timestamps null: false
    end
  end
end
