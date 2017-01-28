class BrandGallery < ApplicationRecord
  belongs_to :brand
  mount_uploader :file, BrandGalleryUploader
  after_commit :set_dominant_colors, on: [:update, :create]

  #validates_presence_of :name
  validates_presence_of :file

  has_many :gallerys_pictures_products_relations, class_name:  :GalleryPictureProduct, foreign_key: :picture_id
  has_many :products, :through => :gallerys_pictures_products_relations


  def set_dominant_colors
    # use  self.path to get the path
    # histo = MiniMagick::Tool::Convert.new do |cmd|
    #   cmd << self.path
    #   cmd << '-colors 6'
    #   cmd <<  '-format %c'
    #   cmd << 'histogram:info:-'
    # end
    ImageProcessing.perform_later self

  end
end
