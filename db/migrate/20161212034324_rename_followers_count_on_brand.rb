class RenameFollowersCountOnBrand < ActiveRecord::Migration[5.0]
  def change
    rename_column :brands, :brand_user_followers_count, :followers_count
  end
end
