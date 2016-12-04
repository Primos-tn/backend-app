class Profile < ActiveRecord::Base
  validates_presence_of :phone, :first_name, :last_name, on: :update #-> means this will not fire on create

  belongs_to :account, dependent: :destroy
  belongs_to :country
	
end
