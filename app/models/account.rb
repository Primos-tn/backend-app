class Account < ActiveRecord::Base
  attr_accessor :auth_mode
  enum accounts_type: {user: 0, business: 2, system: -2, admin: -1, business_request: 1}


  # @see https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login
  attr_accessor :is_admin


  validates :username,
            :presence => true,
            :uniqueness => {
                :case_sensitive => false
            } # etc.

  # Only allow letter, number, underscore and punctuation.
  validates_format_of :username, with: /\A[a-zA-Z0-9_\.]*\z/


  after_validation :beta_invited?
  after_create :add_profile


  has_one :profile
  has_one :business_profile

  # mobile access and others
  has_many :account_access_tokens
  # notifications
  has_many :notifications

  # business
  has_many :brands
  has_many :apiKeys
  has_many :products, :through => :brands

  # products
  has_many :whishes_relations, class_name: UserProductWish
  has_many :favorite_products, :through => :whishes_relations, class_name: Product, source: :product

  # brands
  has_many :brands_relations, class_name: BrandUserFollower
  has_many :favorite_brands, :through => :brands_relations, class_name: Brand, source: :brand

  #
  has_many :categories_relations, class_name: :UserCategoryInterest
  has_many :categories, through: :categories_relations, source: :category


  accepts_nested_attributes_for :profile

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable,
         :omniauth_providers => [:facebook]
  #:authentication_keys => {email: true, login: false}


  def is_brand_admin=(is_brand_admin)
    @is_brand_admin = is_brand_admin
  end

  def is_brand_admin
    @is_brand_admin
  end


  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.from_omniauth(auth)
    account = where(provider: auth.provider, uid: auth.uid, email: auth.info.email).first_or_create do |account|
      account.auth_mode = 'omniauth'
      account.email = auth.info.email
      account.password = Devise.friendly_token[0, 20]
      account.provider_access_token = auth.credentials.token
      account.username = auth.info.name.gsub(/\s+/, '_') # assuming the user model has a name
      # account.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
    if account.provider_access_token.nil?
      account.provider_access_token = auth.credentials.token
      account.save
    end
    account
  end

  # def self.new_with_session(params, session)
  #   super.tap do |user|
  #     if data = session["devise.facebook_data"] && session['devise.facebook_data']['extra']['raw_info']
  #       user.email = data['email'] if user.email.blank?
  #       user.username = data['username'] if user.username.blank?
  #     end
  #   end
  # end

  # Given a list of brands ids, will check all brands that follow in this list
  scope :brands_followed_from_brands_list, -> (account, brands_ids) do
    BrandUserFollower.where({account: account, brand: brands_ids}).all
  end

  # Given a list of products ids, will check all products that follow in this list
  scope :products_followed_from_products_list, -> (account, products_ids) do
    UserProductWish.where({account: account, product: products_ids}).all
  end


  # Given a list of products ids, will check all products that follow in this list
  scope :products_i_voted_from_list, -> (account, products_ids) do
    UserProductVote.where({account: account, product: products_ids}).all
  end


  def self.search(search)
    if search
      where('lower(username) LIKE ?', "%#{search.downcase}%")
    else
      where(nil)
    end
  end

  def self.find_for_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      # when allowing distinct User records with, e.g., "username" and "UserName"...
      where(conditions).where([' lower (username) = :value OR lower (email) = :value', {:value => login.downcase}]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end


  def beta_invited?
    unless auth_mode == 'omniauth'
      # only with new record
      if self.new_record? && SystemConfiguration.first.with_invitation?
        unless AccountRegistrationInvitation.exists?(:email => email)
          errors.add :email, I18n.t("Require invitation")
        end
      end
    end
  end

  def is_business?
    (not self.business_profile.nil? or (self.account_type == Account.accounts_types[:business])) && self.business_profile.is_confirmed
  end


  def is_business_basic?
    self.business_profile.nil? or
        (self.business_profile.plan_type == BusinessProfile.plans_types[:basic])
  end


  def is_business_free?
    self.business_profile.nil? or
        (self.business_profile.plan_type != BusinessProfile.plans_types[:free] && self.business_profile.expires < Date.today)
    (self.business_profile.plan_type == BusinessProfile.plans_types[:free])
  end


  def in_trial_mode?
    self.business_profile.has_free_account && (Date.today < self.business_profile.free_account_started_at + 30.day)
  end

  def can_have_trial_business?
    # check if no business profile or it has a business profile  but has expires
    # has already a free_account
    !in_trial_mode? && (self.business_profile.plan_type == BusinessProfile.plans_types[:free])
  end


  def has_expired?
    # check if no business profile or it has a business profile  but has expires
    self.business_profile.nil? or
        ((self.business_profile.plan_type != BusinessProfile.plans_types[:free]) and self.business_profile.expires < Date.today)
  end

  def is_business_blocked?
    self.business_profile.nil? or
        (self.business_profile.is_blocked)
  end


  def is_admin?
    self.is_super_admin or self.account_type == Account.accounts_types[:admin]
  end


  def get_brands_i_follow_given_list(brands_ids)
    Account.brands_followed_from_brands_list(self, brands_ids)
  end

  def get_products_i_wish_given_list(products_list)
    Account.products_followed_from_products_list(self, products_list)
  end


  def get_products_i_voted_from_list(products_list)
    Account.products_i_voted_from_list(self, products_list)
  end


  private

  def add_profile
    Profile.create(:account => self)
  end
end
