class RenameBusinessProfileTypeColumnName < ActiveRecord::Migration
  def change
    rename_column :business_profiles, :type, :plan_type
  end
end
