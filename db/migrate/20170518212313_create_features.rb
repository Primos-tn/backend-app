class CreateFeatures < ActiveRecord::Migration[5.0]
  def change
    create_table :features do |t|
      t.string :name
      t.string :name_ar
      t.string :name_fr
      t.string :icon

      t.timestamps
    end
  end
end
