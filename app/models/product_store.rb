class ProductStore < ActiveRecord::Base
  belongs_to :BrandStore
  belongs_to :product,   :counter_cache => :available_in_count
  validates_uniqueness_of :BrandStore, :product
end
