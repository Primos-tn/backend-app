class Product < ActiveRecord::Base


  belongs_to :brand, :counter_cache => :products_count
  has_one :account, :through => :brand

  has_many :wishes_relation, class_name: :UserProductWish
  has_many :wishers, through: :wishes_relation, source: :account, class_name: Account

  has_many :views, class_name: :UserProductView
  has_many :viewers, through: :views, source: :account, class_name: Account


  has_many :shares_relation, class_name: :UserProductShare
  has_many :shares, through: :shares_relation, source: :account


  has_many :votes_relation, class_name: :UserProductVote
  has_many :votes, through: :votes_relation, source: :account


  has_many :categories_relations, class_name: :CategoryProduct
  has_many :categories, through: :categories_relations, source: :category

  has_many :gallerys_pictures_products_relations, class_name: :GalleryPictureProduct
  has_many :pictures, through: :gallerys_pictures_products_relations, source: :brand_gallery


  has_many :product_stores
  has_many :stores, through: :product_stores


  accepts_nested_attributes_for :stores,
                                :allow_destroy => true

  has_many :comments, class_name: :ProductComment

  has_many :product_coupons


  has_many :product_taggings
  has_many :tags, through: :product_taggings


  validates :brand, presence: true
  validates :name, presence: true

  def self.get_search_query ()

  end

  #
  # scope that return list of products with with the first 3 followers
  def self.get_sql_query (limit, offset, options={})
    join_top_wishers(get_base_products_query(limit, offset, options))
  end

  def self.search(search)
    if search
      where('lower(name) LIKE ?', "%#{search.downcase}%")
    else
      where(nil)
    end
  end

  #
  # FIXME sql injections

  def self.get_base_products_query(limit, offset, options)
    limit ||= 4
    offset ||= 0
    today_query = 'date (last_launch) = current_date'
    name_query = options[:query] ? " and lower(name) like '%#{options[:query].downcase}%'" : ''
    categories_query = options[:categories] ? include_categories(options[:categories]) : ''
    store_query = options[:stores] ? include_stores(options[:stores]) : ''
    brands_query = options[:brands] ? "and brand_id in (#{options[:brands].split(',').join(',')})" : ''
    query = [today_query, name_query, categories_query, store_query, brands_query].join(' ')
    "select id,  brand_id  FROM products  WHERE  #{query} LIMIT #{limit} OFFSET #{offset}"
  end


  # Method to include categories join

  def self.include_categories(categories)
    "and id in
          (select DISTINCT  products.id from products
              join categories_products on categories_products.product_id = products.id
            where categories_products.category_id in (#{categories.split(',').join(',')})
      )"
  end

  # Method to include categories join

  def self.include_stores(stores)
    "and id in
          (select DISTINCT  products.id from products
              join  product_stores on product_stores.product_id = products.id
            where product_stores.store_id in (#{stores.split(',').join(',')})
      )"
  end

  # FIXME,
  # TODO
  # This is on of most query for browsing items, please use all effort to reduce it's time
  # Please check how to reduce the cross all table
  # it takes 1.2 ms , is't normal ?
  def self.join_top_wishers(product_query)
    <<-SELECT
      select  products.*,
          t.*,
          brands.name AS brand_name
        FROM (
                 select
        p.pid                     AS id,
                                     p.username,
                                     p.user_id,
                                     ROW_NUMBER()
        OVER (PARTITION BY p.pid) AS rn
        FROM (select
        ps.id      AS pid,
                      a.id       AS user_id,
                                    a.username AS username
        FROM (#{product_query}) AS ps
        LEFT JOIN user_product_wishes AS apv
        ON apv.product_id = ps.id
        LEFT JOIN accounts AS a
        ON apv.account_id = a.id


        GROUP BY ps.id, a.id
        ORDER BY ps.id
        ) AS p
        ) AS t
        JOIN products ON t.id = products.id
        INNER JOIN "brands" ON "brands"."id" = "products"."brand_id"
    SELECT
  end

  # Returns the model id
  def media_store_dir
    "#{brand.media_store_dir}/products/#{id}"
  end

  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end

  #
  #
  #
  def in_launch_mode?
    !last_launch.nil? and (last_launch.to_date == Date.today)
  end


  #
  # Check if the product can be launched
  # Add Last Launch
  #
  def can_be_launched?
    !in_launch_mode? and !scheduled_for_launch?
  end


  #
  # Check if the product can be launched
  #
  def scheduled_for_launch?
    !last_launch.nil? and Date.today < last_launch.to_date
  end


  private


end
