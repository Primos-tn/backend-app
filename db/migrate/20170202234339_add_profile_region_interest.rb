class AddProfileRegionInterest < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :region_interest, :json
  end
end
