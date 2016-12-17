class CreateMobileDeviceTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :mobile_device_tokens do |t|
      t.integer :user
      t.string :type
      t.string :expires
      t.string :uuid
      t.json :info

      t.timestamps
    end
  end
end
