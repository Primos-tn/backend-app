class AccountPushToken < ApplicationRecord
  belongs_to :account
  validates_uniqueness_of :value, scope: :uuid
  validates_uniqueness_of :value, scope: :account
  validates_presence_of :value
  validates_presence_of :account
  validates_presence_of :uuid
  validates_presence_of :platform
end
