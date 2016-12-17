class ChangePhoneNumbersTypeForBusiness < ActiveRecord::Migration[5.0]
  def change
    change_column :business_profiles, :business_phone, :string
  end
end
