class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :string

      t.timestamps null: false
    end
  end
end
