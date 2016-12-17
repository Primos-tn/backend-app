class AddBusinessProfileAddress < ActiveRecord::Migration
  def change
    add_column :business_profiles, :company_address , :string
  end
end
