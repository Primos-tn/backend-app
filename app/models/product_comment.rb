class ProductComment < ActiveRecord::Base
  belongs_to :product,  :counter_cache => :comments_count
  belongs_to :account
end
