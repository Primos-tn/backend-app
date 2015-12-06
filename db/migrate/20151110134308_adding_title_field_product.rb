class AddingTitleFieldProduct < ActiveRecord::Migration
  def up
   add_column :articles, :title, :string
 end
end
