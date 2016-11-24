class CategoryProduct < ActiveRecord::Base
  belongs_to :product
  belongs_to :category
  self.table_name = "categories_products"
end
