class BrandStore < ActiveRecord::Base
  belongs_to :brand
  validates :brand, presence: true
  validates :name, presence: true
end
