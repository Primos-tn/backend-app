class Category < ActiveRecord::Base
  has_many :categories, foreign_key: 'parent_id'
  belongs_to :category,  foreign_key: 'parent_id'

  has_many :category_products, class_name: "CategoryProduct"
  has_many :products, :through => :category_products

  validates_uniqueness_of :name
end
