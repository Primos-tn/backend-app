class UserBrandFollowingRelationship < ActiveRecord::Base
  belongs_to :account
  belongs_to :brand,  :counter_cache => :brand_users_followers_count
  validates_uniqueness_of :account_id, :scope => :brand_id

  #
  # scope that return list of products with with the first 3 followers
  scope :top_followers, -> (top, brands_ids) do
    items = Product
                .select('brands.*, t.*')
                .from(Arel.sql("(#{top_n_followers(top, brands_ids)}) as t join brands on t.brand_id = brands.id"))
  end

  private

  def self.top_n_followers(top, brands_ids)
    <<-SELECT
         select *, accounts.username as username, accounts.id as user_id from brands FULL OUTER JOIN  (
                                       select brand_id, account_id, row_number()  over(
                                         PARTITION BY   brand_id) AS rn  from user_brand_following_relationships
                                        where  brand_id in (#{brands_ids.join(',')})
                                     )  as main on brands.id = main.brand_id
          left outer join accounts on main.account_id = accounts.id
          where (rn <= #{top} or rn is NULL)
    SELECT
  end
end