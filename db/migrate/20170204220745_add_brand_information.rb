class AddBrandInformation < ActiveRecord::Migration[5.0]
  def change
    add_column :brands, :fb_link, :string
    add_column :brands, :tw_link, :string
    add_column :brands, :ln_link, :string
    add_column :brands, :address, :string
    add_column :brands, :creation_date, :date
    add_column :brands, :category_id, :integer

  end
end
