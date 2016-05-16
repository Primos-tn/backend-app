class Brand < ActiveRecord::Base
  has_one :articles
  belongs_to :account
end
