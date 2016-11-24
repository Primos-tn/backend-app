class Brand < ActiveRecord::Base
  mount_uploader :cover, BrandUploader

  has_many :brand_team_members
  has_many :members, :through => :brand_team_members, class_name: :Account

  has_many :products

  has_many :comments, class_name: :BrandComment

  has_many :stores, foreign_key: :brand_id, class_name: :BrandStore

  belongs_to :account



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
