class Feature < ApplicationRecord

  validates_presence_of :name
  validates_presence_of :name_fr
  validates_presence_of :name_ar

  validates_uniqueness_of :name
  validates_uniqueness_of :name_fr
  validates_uniqueness_of :name_ar
end
