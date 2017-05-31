class CreateBrandFeatures < ActiveRecord::Migration[5.0]
  def change
    create_table :brand_features do |t|
      t.integer :brand_id
      t.integer :feature_id

      t.timestamps
    end
  end
end
