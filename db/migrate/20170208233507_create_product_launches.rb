class CreateProductLaunches < ActiveRecord::Migration[5.0]
  def change
    create_table :product_launches do |t|
      t.integer :product_id
      t.date :launch_date

      t.timestamps
    end
  end
end
