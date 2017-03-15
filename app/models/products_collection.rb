class ProductsCollection < ApplicationRecord
  belongs_to :brand
  has_one :brand_gallery, foreign_key: 'cover_id'


  has_many :product_launches
  has_many :launches, :through => :product_launches

  has_many :products_collections_products, dependent:  :destroy
  has_many :products, :through => :products_collections_products

  validates_uniqueness_of :name, scope: [:brand_id]
  validates_presence_of :name
  validates_presence_of :brand

  def in_launch_mode?
    # check if launch mode
    last_launch && last_launch.to_date == Date.today
    #!last_launch.nil? and ()
  end


  #
  # Check if the product can be launched
  #
  def scheduled_for_launch?
    last_launch and last_launch.to_date > Date.today
  end

  #
  # Check if the product can be launched
  # Add Last Launch
  #
  def can_be_launched?
    # check for products size
    products.size > 0 && !in_launch_mode? and !scheduled_for_launch?
  end

end
