class AddMonthFreeToProfileBusiness < ActiveRecord::Migration
  def change
    add_column :business_profiles, :has_free_account, :boolean, default: false
    add_column :business_profiles, :free_account_started_at, :datetime, default: nil
  end
end
