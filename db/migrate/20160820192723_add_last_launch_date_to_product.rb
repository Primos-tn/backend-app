class AddLastLaunchDateToProduct < ActiveRecord::Migration
  def change
    add_column :products , :last_launch, :datetime
  end
end
