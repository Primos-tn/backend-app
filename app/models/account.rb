class Account < ActiveRecord::Base
  after_create :add_profile
  has_one :profile
  has_many :brand

  accepts_nested_attributes_for :profile

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => {email: true, login: false}


  # @see https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        # when allowing distinct User records with, e.g., "username" and "UserName"...
	where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
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

  def validate_username
   if Account.where(email: username).exists?
	    errors.add(:username, :invalid)
    end
  end

  private
    def add_profile
      Profile.create(:account => self)
    end
end
