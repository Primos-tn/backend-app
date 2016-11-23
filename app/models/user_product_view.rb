class UserProductView < ActiveRecord::Base
  belongs_to :account
  belongs_to :product,  :counter_cache => :user_product_viewers_count
  validates_uniqueness_of :account_id, :scope => :product_id
end
