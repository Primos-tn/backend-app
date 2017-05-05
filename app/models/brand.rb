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

  # followers
  has_many :followers, class_name: :BrandUserFollower
  has_many :followersDetails, :through => :user_brands_relations,  class_name: Account, source: :account

  #
  belongs_to :category

  validates :account, presence: true
  validates_presence_of :name



  def self.search(search)
    if search
      where('lower(name) LIKE ?', "%#{search.downcase}%")
    else
      where(nil)
    end
  end

  def self.top(limit)
    order('followers_count').limit(5)
  end

  # Returns the model id
  def media_store_dir
    "#{account.id}/brands/#{id}"
  end

end
