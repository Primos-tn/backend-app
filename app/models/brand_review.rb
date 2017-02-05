class BrandReview < ActiveRecord::Base
  belongs_to :brand,  :counter_cache => :reviews_count
  belongs_to :account, :foreign_key => 'author_id'
  validates_uniqueness_of :account, scope: [:brand]
end
