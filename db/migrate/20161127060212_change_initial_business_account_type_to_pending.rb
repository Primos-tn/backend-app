class ChangeInitialBusinessAccountTypeToPending < ActiveRecord::Migration
  def change
    change_column :business_profiles, :type, :integer, default: 0
  end
end
