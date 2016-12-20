class AddIconClassNameToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :icon_class_name, :string
  end
end
