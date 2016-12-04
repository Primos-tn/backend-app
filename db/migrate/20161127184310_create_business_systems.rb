class CreateBusinessSystems < ActiveRecord::Migration
  def change
    create_table :business_systems do |t|
      t.float :offer_basic_price, default: 10
      t.json :supported_countries, default: '["TN", "FR"]'
      t.integer :last_modified_by

      t.timestamps null: false
    end
  end
end
