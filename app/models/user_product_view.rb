class UserProductView < ActiveRecord::Base
  belongs_to :account, optional: true
  belongs_to :product, :counter_cache => :user_product_views_count
  validates_presence_of :product_id
  validates_presence_of :ip_address
  validates_uniqueness_of :account_id, scope: [:ip_address, :product_id]


  def increment_user_view(by=1)
    self[:count] ||= 0
    self[:count] += by
    self
  end


  private


end
