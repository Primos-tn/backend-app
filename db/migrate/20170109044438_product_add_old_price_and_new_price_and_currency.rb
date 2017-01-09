class ProductAddOldPriceAndNewPriceAndCurrency < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :old_price, :float
    add_column :products, :new_price, :float
    add_column :products, :currrency, :string
  end
end
