class ProductRenamePicturesToProperties < ActiveRecord::Migration[5.0]
  def change
    rename_column :products, :pictures, :properties
  end
end
