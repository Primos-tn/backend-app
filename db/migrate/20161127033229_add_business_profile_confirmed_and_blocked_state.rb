class AddBusinessProfileConfirmedAndBlockedState < ActiveRecord::Migration
  def change
    add_column :business_profiles, :is_confirmed, :boolean, default:false
    add_column :business_profiles, :is_blocked, :boolean, default:false
  end
end
