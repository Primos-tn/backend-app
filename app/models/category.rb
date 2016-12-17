class Category < ActiveRecord::Base
  has_many :categories, foreign_key: 'parent_id', dependent: :destroy
  belongs_to :category,  foreign_key: 'parent_id'

  has_many :category_products, class_name: "CategoryProduct"
  has_many :products, :through => :category_products

  validates_presence_of :name
  validates_presence_of :name_fr
  validates_presence_of :name_ar

  validates_uniqueness_of :name
  validates_uniqueness_of :name_fr
  validates_uniqueness_of :name_ar

end
