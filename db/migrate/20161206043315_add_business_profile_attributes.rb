class AddBusinessProfileAttributes < ActiveRecord::Migration
  def change
    add_column :business_profiles, :company_name , :string
    add_column :business_profiles, :city , :string
    add_column :business_profiles, :post_code , :integer
    add_column :business_profiles, :country , :string
  end
end
