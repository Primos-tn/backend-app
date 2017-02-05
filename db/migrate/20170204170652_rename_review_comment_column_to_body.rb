class RenameReviewCommentColumnToBody < ActiveRecord::Migration[5.0]
  def change
    rename_column :brand_reviews, :comment, :body
  end
end
