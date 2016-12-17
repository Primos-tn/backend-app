class CreateOfferServices < ActiveRecord::Migration[5.0]
  def change
    create_table :offer_services do |t|
      t.string :service_name
      t.integer :offer_type

      t.timestamps
    end
  end
end
