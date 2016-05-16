class UserBrandFollowingRelationship < ActiveRecord::Base
  validates_uniqueness_of :account_id, :scope => :brand_id
  belongs_to :account
  belongs_to :brand
end
