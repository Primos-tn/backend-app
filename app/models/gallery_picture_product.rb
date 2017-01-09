class GalleryPictureProduct < ActiveRecord::Base
  belongs_to :brand_gallery, :foreign_key => :picture_id
  belongs_to :product
  self.table_name = :gallery_pictures_products
end
