class CreateSystemConfigurations < ActiveRecord::Migration
  def change
    create_table :system_configurations do |t|
      t.json :supported_languages, default: '["ar", "en", "fr"]'
      t.json :crash_mails_alert, default: '[]'
      t.integer :last_modified_by
      t.timestamps null: false
    end
  end
end
