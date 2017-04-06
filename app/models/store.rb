class Store < ActiveRecord::Base
  belongs_to :brand, :counter_cache => :stores_count


  validates :brand, presence: true
  validates :name, presence: true
  validates :country_code, presence: true
  validates :zip_code, presence: true
  validates :address, presence: true
  validates :city, presence: true

  geocoded_by :get_full_address
  after_validation :geocode, if: :latitude_longitude_blank?


  has_many :product_stores
  has_many :products, through: :product_stores

  private

  def latitude_longitude_blank?
    latitude.blank? || longitude.blank?
  end

  def get_full_address
    country = Country.find_by_code(self.country_code).name
    [country, city, zip_code, address].compact.join(',')
  end

  def self.has_offers_toady
    Store
        .joins(:products => :launches)
        .where(:product_launches => {launch_date: Date.today})
  end

end
