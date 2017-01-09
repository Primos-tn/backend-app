class BrandGallery < ApplicationRecord
  belongs_to :brand
  mount_uploader :file, BrandGalleryUploader

  #validates_presence_of :name
  validates_presence_of :file

  has_many :gallerys_pictures_products_relations, class_name:  :GalleryPictureProduct, foreign_key: :picture_id
  has_many :products, :through => :gallerys_pictures_products_relations
end
