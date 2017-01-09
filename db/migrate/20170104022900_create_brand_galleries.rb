class CreateBrandGalleries < ActiveRecord::Migration[5.0]
  def change
    create_table :brand_galleries do |t|
      t.integer :brand_id
      t.string :name
      t.string :file

      t.timestamps
    end
  end
end
