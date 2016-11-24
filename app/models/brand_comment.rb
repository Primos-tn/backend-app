class BrandComment < ActiveRecord::Base
  belongs_to :brand,  :counter_cache => :comments_count
end
