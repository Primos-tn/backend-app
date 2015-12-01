class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.time :created
      t.integer :creator

      t.timestamps null: false
    end
  end
end
