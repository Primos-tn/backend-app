class CreateUserProductVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :user_product_votes do |t|
      t.integer :account_id
      t.integer :product_id

      t.timestamps
    end
  end
end
