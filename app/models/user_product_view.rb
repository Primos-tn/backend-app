class UserProductView < ActiveRecord::Base
  belongs_to :product, :counter_cache => :user_product_views_count
  validates_presence_of :product_id
  validates_presence_of :ip_address
  validates_uniqueness_of :account_id, :ip_address, :scope => :product_id


  def increment_user_view
    if count.nil?
      count = 1
    else
      count += 1
    end
  end


  private


end
