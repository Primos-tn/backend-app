class Product < ActiveRecord::Base

  mount_uploaders :pictures, ProductUploader

  belongs_to :brand, :counter_cache => :products_count
  has_one :account, :through => :brand

  has_many :wishes_relation, class_name: :UserProductWish
  has_many :wishers, through: :wishes_relation, source: :account, class_name: Account

  has_many :views_relation, class_name: :UserProductView
  has_many :viewers, through: :views_relation, source: :account


  has_many :shares_relation, class_name: :UserProductShare
  has_many :shares, through: :shares_relation, source: :account


  has_many :categories_relations, class_name: :CategoryProduct
  has_many :categories, through: :categories_relations, source: :category


  has_many :stores, class_name: :ProductStore


  has_many :comments, class_name: :ProductComment


  validates :brand, presence: true

  #
  # scope that return list of products with with the first 3 followers
  def self.top_wishers (limit, offset=3, search)
    if search.nil?
      search = ''
    end
    select('products.*, t.*, brands.name as brand_name')
        .from(Arel.sql("(#{with_n_wishers(limit, offset)}) as t join products on t.id = products.id"))
        .joins(:brand)
        .where('rn <= 3 or rn is null')
        .where('lower(products.name) LIKE ?', "%#{search.downcase}%")
  end

  #
  #
  #
  def self.search(options={})
    search_object = {}
    if options.has_key?(:brand) && !options[:brand].nil?
      search_object[:brand] = options[:brand]
    end
    _where = where(search_object)
    if options.has_key?(:categories) && !options[:categories].nil?
      _where = _where.joins(:categories)
                   .where(:categories => {:id => options[:categories].split(',')})
    end
    _where
  end


  #
  # Check if the product can be launched
  #
  def can_be_launched?
    # the product is nil or empty
    # or last launch < 3
    !self.last_launch? or (self.last_launch - Time.now).to_i > 3
  end


  private
  # FIXME,
  # TODO
  # This is on of most query for browsing items, please use all effort to reduce it's time
  # Please check how to reduce the cross all table
  # it takes 1.2 ms , is't normal ?
  def self.with_n_wishers(limit=2, offset=0)
    <<-SELECT
       select
        p.pid as id,
        p.username,
        p.user_id,
        ROW_NUMBER()  OVER (PARTITION BY p.pid) AS rn
        FROM (SELECT
              ps.id as pid,
              a.id as user_id,
              a.username as username
            FROM products AS ps
              JOIN (select id from products LIMIT #{limit} offset #{offset} ) as ps_2
              on ps.id = ps_2.id
            LEFT JOIN user_product_wishes AS apv
              on apv.product_id = ps.id
              LEFT  JOIN accounts as a
              on apv.account_id = a.id
            GROUP BY ps.id, a.id
            ORDER BY ps.id
           ) as p
    SELECT
  end

end
