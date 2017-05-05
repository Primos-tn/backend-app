class MessengerDiscussion < ApplicationRecord
  belongs_to :messenger_account, class_name: 'MessengerAccount', foreign_key: 'user_id', primary_key: 'user_id'
end
