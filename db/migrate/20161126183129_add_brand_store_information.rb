class AddBrandStoreInformation < ActiveRecord::Migration
  def change
    add_column :brand_stores, :city, :string
    add_column :brand_stores, :country_code, :integer
    add_column :brand_stores, :address, :string
    add_column :brand_stores, :zip_code, :string
  end
end
