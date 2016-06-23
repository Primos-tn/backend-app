class UserBrandFollowingRelationship < ActiveRecord::Base
  belongs_to :account
  belongs_to :brand
  validates_uniqueness_of :account_id, :scope => :brand_id
end
