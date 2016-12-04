class ChangeBrandStoreCountryCodeType < ActiveRecord::Migration
  def change
    change_column :brand_stores, :country_code, :string
  end
end
