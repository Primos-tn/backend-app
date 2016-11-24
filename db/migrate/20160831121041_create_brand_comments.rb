class CreateBrandComments < ActiveRecord::Migration
  def change
    create_table :brand_comments do |t|
      t.integer :brand_id
      t.integer :author_id
      t.string :comment

      t.timestamps null: false
    end
  end
end
