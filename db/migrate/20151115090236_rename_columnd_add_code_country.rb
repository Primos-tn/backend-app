class RenameColumndAddCodeCountry < ActiveRecord::Migration
  def change
	rename_column :countries, :string, :name
	add_column :countries, :code, :string
	add_column :countries, :real_name, :string
end
end
