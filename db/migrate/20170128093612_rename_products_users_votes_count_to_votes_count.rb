class RenameProductsUsersVotesCountToVotesCount < ActiveRecord::Migration[5.0]
  def change
    rename_column :products, :user_product_votes_count,  :votes_count
  end
end
