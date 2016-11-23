class AddCategoriesLocaleDesc < ActiveRecord::Migration
  def change
    add_column :categories, :name_ar, :string
    add_column :categories, :name_fr, :string
  end
end
