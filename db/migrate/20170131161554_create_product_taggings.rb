class CreateProductTaggings < ActiveRecord::Migration[5.0]
  def change
    create_table :product_taggings do |t|
      t.belongs_to :product, foreign_key: true
      t.belongs_to :tag, foreign_key: true

      t.timestamps
    end
  end
end
