class MessengerAccount < ApplicationRecord
  validates :user_id, uniqueness: true
  # brands
  has_many :brands_following, class_name: MessengerAccountBrandFollower
  has_many :favorite_brands, :through => :brands_following, class_name: Brand, source: :brand
end
