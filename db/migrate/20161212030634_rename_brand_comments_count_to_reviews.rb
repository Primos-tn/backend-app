class RenameBrandCommentsCountToReviews < ActiveRecord::Migration[5.0]
  def change
    rename_column :brands, :comments_count, :reviews_count
  end
end
