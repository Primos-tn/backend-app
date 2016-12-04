class BusinessProfile < ActiveRecord::Base

  enum plans_types: {free: 0, basic: 1, custom: 10}

  belongs_to :account, dependent: :destroy


  def self.search(search)
    if search
      joins(:accounts)
          .where('lower(accounts.username) LIKE ? OR email LIKE ?', "%#{search.downcase}%", "%#{search.downcase}%")
    else
      where(nil)
    end
  end
end
