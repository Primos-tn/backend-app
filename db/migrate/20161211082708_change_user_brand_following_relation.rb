class ChangeUserBrandFollowingRelation < ActiveRecord::Migration[5.0]

  def change
    rename_column :brands, :brand_users_followers_count, :brand_user_followers_count
  end

end
