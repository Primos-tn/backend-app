class AddBrandMessengerFollowerCountCache < ActiveRecord::Migration[5.0]
  def change
    add_column :brands, :messenger_followers_count, :integer
  end
end
