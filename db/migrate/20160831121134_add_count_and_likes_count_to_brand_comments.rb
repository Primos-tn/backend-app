class AddCountAndLikesCountToBrandComments < ActiveRecord::Migration
  def change
    add_column :brands, :comments_count, :integer, :default => 0
    add_column :brand_comments, :likes_count, :integer, :default => 0
  end
end
