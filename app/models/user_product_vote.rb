class UserProductVote < ApplicationRecord
  belongs_to :account, optional: true
  belongs_to :product, :counter_cache => :user_product_votes_count
  validates_uniqueness_of :product_id, scope: [:account_id]
end
