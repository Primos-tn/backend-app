class AddBrandFollwersCounterCache < ActiveRecord::Migration
  def change
    add_column :brands, :brand_users_followers_count, :integer, default: 0
  end
end
