class Brand < ActiveRecord::Base
  has_one :articles
  belongs_to :account
  has_many :followers, class_name:  "UserBrandFollowingRelationship",
           foreign_key: "brand_id",
           dependent:   :destroy

end
