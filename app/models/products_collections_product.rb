class ProductsCollectionsProduct < ApplicationRecord
  belongs_to :products_collection
  belongs_to :product
  validates_uniqueness_of :products_collection, scope: :product
end
