class Tag < ApplicationRecord
  has_many :product_taggings
  has_many :posts, through: :product_taggings
end
