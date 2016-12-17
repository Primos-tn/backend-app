class AccountRegistrationInvitation < ActiveRecord::Base
  enum invitation_sources: {admin:0, user:1, request:2}
  validates_presence_of :last_name, :email, :first_name
  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates :email, uniqueness: true
  validates :first_name, length: {maximum: 30, minimum: 5}
  validates :last_name, length: {maximum: 30, minimum: 5}
  belongs_to :sender, foreign_key: 'admin_sent_by', class_name: "Account"

  def self.search(search)
    if search
      serach_donwncase = "%#{search.downcase}%"
      where('lower(first_name) LIKE ? or lower(last_name) LIKE ? or lower(email) LIKE ?', serach_donwncase, serach_donwncase, serach_donwncase)
    else
      where(nil)
    end
  end



end
