class RenameCommentsOnBrandToReviews < ActiveRecord::Migration[5.0]
  def change
    rename_table :brand_comments, :brand_reviews
    add_column :brand_reviews, :eval, :integer, :default => 0
  end
end
