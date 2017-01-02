class ProductStore < ActiveRecord::Base
  belongs_to :store
  belongs_to :product,   :counter_cache => :available_in_count
  validates_uniqueness_of :store, scope: :product
end
