class CreateProductComments < ActiveRecord::Migration
  def change
    create_table :product_comments do |t|
      t.string :comment
      t.integer :author_id
      t.integer :likes_count
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
