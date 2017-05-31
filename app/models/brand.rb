class Brand < ActiveRecord::Base
  mount_uploader :picture, BrandUploader
  mount_uploader :cover, BrandUploader
  belongs_to :account
  # brands stores associations
  has_many :stores, dependent: :destroy

  # memebres of configuration associations
  has_many :brand_team_members
  has_many :members, :through => :brand_team_members, class_name: :Account

  # products  associations
  has_many :products

  # reviews associations
  has_many :reviews, class_name: :BrandReview


  # photo and gallery
  has_many :gallery, class_name: :BrandGallery, dependent: :destroy

  # photo and gallery
  has_many :brand_features
  has_many :features, :through => :brand_features, class_name: :Feature


  # followers
  has_many :followers, class_name: :BrandUserFollower
  has_many :followersDetails, :through => :user_brands_relations, class_name: Account, source: :account

  #
  belongs_to :category


  validates :account, presence: true
  validates_presence_of :name

  has_one :business_profile, through: :account


  def self.search(search)
    if search
      where('lower(name) LIKE ?', "%#{search.downcase}%")
    else
      where(nil)
    end
  end

  def self.top(limit=5, categories_ids=nil, stories_ids=nil)
    looking = Brand
    categories_ids = categories_ids.nil? ? nil : Category.children_recursive_ids(categories_ids)
    looking = looking.where({:category => categories_ids}) unless categories_ids.nil?
    looking = looking.includes(:stores).where({:stores => { :id => stories_ids}}) unless stories_ids.nil?
    looking.order('followers_count').limit(limit)
  end

  def reviews_average
    if self.reviews_count > 0
      BrandReview.where({brand: self}).sum('eval') / self.reviews_count
    else
      0
    end
  end

  # Returns the model id
  def media_store_dir
    "#{account.id}/brands/#{id}"
  end

end
