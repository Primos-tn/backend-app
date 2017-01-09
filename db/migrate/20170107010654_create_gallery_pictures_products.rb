class CreateGalleryPicturesProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :gallery_pictures_products do |t|
      t.integer :picture_id
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
