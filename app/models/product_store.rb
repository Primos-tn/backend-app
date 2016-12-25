class ProductStore < ActiveRecord::Base
  belongs_to :Store
  belongs_to :product,   :counter_cache => :available_in_count
  validates_uniqueness_of :Store, :product
end
