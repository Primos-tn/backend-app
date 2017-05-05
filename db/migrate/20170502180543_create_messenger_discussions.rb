class CreateMessengerDiscussions < ActiveRecord::Migration[5.0]
  def change
    create_table :messenger_discussions do |t|
      t.integer :user_id
      t.string :body

      t.timestamps
    end
  end
end
