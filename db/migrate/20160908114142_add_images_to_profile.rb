class AddImagesToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :pictures, :json
  end
end
