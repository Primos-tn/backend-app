class Notification < ApplicationRecord
  belongs_to :account, :foreign_key => 'to_user'
end
