class Store < ActiveRecord::Base
  belongs_to :brand
  has_one :country, foreign_key: :country_code
  validates :brand, presence: true
  validates :name, presence: true
end
