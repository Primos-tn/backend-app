class AccountRegistrationInvitation < ActiveRecord::Base
  validates_presence_of :last_name, :email, :first_name
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates :email, uniqueness: true
  validates :first_name, length: { maximum: 30, minimum: 6 }
  validates :last_name, length: { maximum: 30, minimum: 6 }
  belongs_to :sender, foreign_key: 'admin_sent_by', class_name: "Account"

  def self.search(search)
    if search
      where('lower(username) LIKE ?', "%#{search.downcase}%")
    else
      where(nil)
    end
  end

end
