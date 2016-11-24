class AddCommentCountToProduct < ActiveRecord::Migration
  def change
    add_column :products, :comments_count, :integer, :default => 0
  end
end
