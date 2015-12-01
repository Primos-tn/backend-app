class ChangeColumnName < ActiveRecord::Migration
  def up
   change_column :articles, :created, :datetime
 end

 def down
   change_column :articles, :created, :time
 end
end
