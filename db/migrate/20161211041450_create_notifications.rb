class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :to_user
      t.string :type
      t.boolean :seen, default: false
      t.json :info

      t.timestamps
    end
  end
end
