class AddVotesToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :user_product_votes_count, :integer, default:0
  end
end
