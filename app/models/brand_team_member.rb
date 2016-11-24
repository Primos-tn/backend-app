class BrandTeamMember < ActiveRecord::Base
  belongs_to  :brand
  belongs_to  :account
end
