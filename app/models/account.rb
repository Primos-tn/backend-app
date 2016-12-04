class Account < ActiveRecord::Base

  enum accounts_type: {user: 0, business: 2, system: -2, admin: -1, business_request: 1}

  before_validation :beta_invited?
  after_create :add_profile


  has_one :profile
  has_one :business_profile

  # business
  has_many :brands
  has_many :apiKeys
  has_many :products, :through => :brands

  # products
  has_many :whishes_relations, class_name: UserProductWish
  has_many :favorite_products, :through => :whishes_relations, class_name: Product, source: :product

  # brands
  has_many :brands_relations, class_name: UserBrandFollowingRelationship
  has_many :favorite_brands, :through => :brands_relations, class_name: Brand, source: :brand


  accepts_nested_attributes_for :profile

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => {email: true, login: false}


  # @see https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login
  attr_accessor :is_admin

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


  # Given a list of brands ids, will check all brands that follow in this list
  scope :brands_followed_from_brands_list, -> (account, brands_ids) do
    UserBrandFollowingRelationship.where({account: account, brand: brands_ids}).all
  end

  # Given a list of products ids, will check all products that follow in this list
  scope :products_followed_from_products_list, -> (account, products_ids) do
    UserProductWish.where({account: account, product: products_ids}).all
  end


  def self.search(search)
    if search
      where('lower(username) LIKE ?', "%#{search.downcase}%")
    else
      where(nil)
    end
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      # when allowing distinct User records with, e.g., "username" and "UserName"...
      where(conditions).where(["username = :value OR lower(email) = lower(:value)", {:value => login}]).first
    else
      where(conditions.to_hash).first
    end
  end


  validates :username,
            :presence => true,
            :uniqueness => {
                :case_sensitive => false
            } # etc.

  # Only allow letter, number, underscore and punctuation.
  validates_format_of :username, with: /\A[a-zA-Z0-9_\.]*\z/
  validate :validate_username


  def beta_invited?
    if not self.is_admin? and SystemConfiguration.first.with_invitation?
      unless AccountRegistrationInvitation.exists?(:email => email)
        errors.add :email, t("Sorry, you are not allowed to registrer, please contact us !")
      end
    end
  end

  def is_business?
    not self.business_profile.nil? or (self.account_type == Account.accounts_types[:business])
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


  def is_plan_expired?
    # check if no business profile or it has a business profile  but has expires
    self.business_profile.nil? or
        ((self.business_profile.plan_type == BusinessProfile.plans_types[:basic]) and self.business_profile.expires < Date.today)
  end

  def is_admin?
    self.is_super_admin or self.account_type == Account.accounts_types[:admin]
  end

  def validate_username
    if Account.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end


  def get_brands_i_follow_given_list(brands_ids)
    Account.brands_followed_from_brands_list(self, brands_ids)
  end

  def get_products_i_wish_given_list(products_list)
    Account.products_followed_from_products_list(self, products_list)
  end

  private

  def add_profile
    Profile.create(:account => self)
  end
end
