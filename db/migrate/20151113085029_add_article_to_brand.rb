class AddArticleToBrand < ActiveRecord::Migration
  def change
    add_column :articles, :brand_id, :integer
  end
end
