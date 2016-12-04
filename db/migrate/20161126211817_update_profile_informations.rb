class UpdateProfileInformations < ActiveRecord::Migration
  def change
    rename_column :profiles, :telephone, :phone
    add_column :profiles, :address, :string
  end
end
