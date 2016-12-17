class AddBusinessProfilePending < ActiveRecord::Migration
  def change
    add_column :business_profiles, :pending , :boolean, default: true
  end
end
