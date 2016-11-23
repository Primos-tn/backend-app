class AddBrandImage < ActiveRecord::Migration
  def change
    add_column :brands, :cover, :string
  end
end
