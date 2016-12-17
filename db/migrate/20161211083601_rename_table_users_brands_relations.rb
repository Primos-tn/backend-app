class RenameTableUsersBrandsRelations < ActiveRecord::Migration[5.0]
  def change
    rename_table :user_brand_following_relationships, :brand_user_followers
  end
end
