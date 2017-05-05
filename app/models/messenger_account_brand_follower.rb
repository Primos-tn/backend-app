class MessengerAccountBrandFollower < ApplicationRecord
  belongs_to :brand, :counter_cache => :messenger_followers_counts
  belongs_to :messenger_account
  validates_uniqueness_of :brand_id, scope: [:messenger_account_id]
end
