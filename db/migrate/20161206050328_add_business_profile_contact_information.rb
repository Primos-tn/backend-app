class AddBusinessProfileContactInformation < ActiveRecord::Migration
  def change
    add_column :business_profiles, :business_phone , :integer
    add_column :business_profiles, :business_email , :string
  end
end
