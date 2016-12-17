class BusinessProfile < ActiveRecord::Base

  enum plans_types: {free: 0, basic: 1, pro: 2, custom: 10}

  belongs_to :account, dependent: :destroy
  validates :account, uniqueness: true
  validates_presence_of :company_name, :business_email, :city, :business_phone, :post_code, :country
  validates :business_email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  #validates_format_of :business_phone, length: {in: 10},  :with => /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/,:message => I18n.t("invalid format")


  def self.search(search)
    if search
      joins(:accounts)
          .where('lower(accounts.username) LIKE ? OR email LIKE ?', "%#{search.downcase}%", "%#{search.downcase}%")
    else
      where(nil)
    end
  end


  def is_blocked?
    is_blocked
  end
end
