class Brand < ActiveRecord::Base
  mount_uploader :cover, BrandUploader

  belongs_to :account
  # brands stores associations
  has_many :stores, dependent: :destroy

  # memebres of configuration associations
  has_many :brand_team_members
  has_many :members, :through => :brand_team_members, class_name: :Account

  # products comments associations

  has_many :products

  # brands comments associations

  has_many :comments, class_name: :BrandComment



  # brands
  has_many :users_relations, class_name: UserBrandFollowingRelationship
  has_many :followers, :through => :users_relations, class_name: Account, source: :account


  validates :account, presence: true


  def self.search(search)
    if search
      where('lower(name) LIKE ?', "%#{search.downcase}%")
    else
      where(nil)
    end
  end


end
