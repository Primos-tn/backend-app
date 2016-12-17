class Contact < ActiveRecord::Base
  validates_presence_of(:body, :email)
  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create}

  def self.search(search)
    if search
      where('lower(email) Like ?', "%#{search.downcase}%")
    else
      where(nil)
    end
  end
end
