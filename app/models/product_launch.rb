class ProductLaunch < ApplicationRecord
  belongs_to :product
  # only allow one launch by product
  validates_uniqueness_of :product, scope: [:launch_date]

  has_many :categories, :through => :products

  # future usage
  def self.launches_in_collections(args)
    stores_ids = args[:stores_ids]
    categories_ids = args[:categories_ids]
    categories_ids = categories_ids.nil? ? nil : Category.children_recursive_ids(categories_ids)
    page = args[:page] || 0
    limit = args [:limit] || 10
    if stores_ids && stores_ids.length == 0
      stores_ids = [-1]
    end
    now = Time.now.utc.strftime('%H:%M:%S')

    puts "************** #{now} *****************"
    puts "************** #{categories_ids} *****************"
    results = ProductLaunch
                  .joins(product: [:brand, :stores, :categories])
                  .where({launch_date: Date.today})
                  .where('((end_at >= ? AND start_at <= ?) or (end_at is NULL))', now, now)
                  .where(stores_ids.nil? ? '' : "product_stores.store_id in (#{stores_ids.join(',')})")
                  .where(categories_ids.nil? ? '' : "categories_products.category_id in (#{categories_ids.join(',')})")
                  .select('distinct on (products.brand_id) product_launches.products_collection_id, product_launches.product_id')
                  .order('"products"."brand_id",  products.user_product_views_count DESC')
    if stores_ids.nil?
      results = results.page([page.to_i, 1].max).per(limit)
    end
    results
  end

  #
  def self.look_now(args)
    categories_ids = args [:categories_ids]
    categories_ids = categories_ids.nil? ? nil : Category.children_recursive_ids(categories_ids)
    stores_ids = args [:stores_ids]
    now = Time.now.utc.strftime('%H:%M:%S')
    launches = ProductLaunch
                   .joins(product: [:brand, :stores, :categories])
                   .where({launch_date: Date.today})
                   .eager_load!(product: [:brand, :pictures])
                   .where('((end_at >= ? AND start_at <= ?) or (end_at is NULL))', now, now)
                   .where(stores_ids.nil? ? '' : "product_stores.store_id in (#{stores_ids.join(',')})")
                   .where(categories_ids.nil? ? '' : "categories_products.category_id in (#{categories_ids.join(',')})")

    unless args[:collections_ids].nil?
      launches = launches
                     .where ({:products_collection_id => args[:collections_ids]})
    end

    unless args[:exclude].nil?
      launches = launches
                     .where
                     .not({product_id: args[:exclude]})
    end
    launches.order('products.user_product_views_count DESC')
    if args[:limit]
      launches = launches.limit(args[:limit])
    end
    launches
  end


  def self.of_brand(args)
    stores_ids = args [:stores_ids]
    now = Time.now.utc.strftime('%H:%M:%S')
    launches = ProductLaunch
                   .joins(product: [:brand, :stores, :categories])
                   .where({launch_date: Date.today})
                   .eager_load!(product: [:brand, :pictures])
                   .where('((end_at >= ? AND start_at <= ?) or (end_at is NULL))', now, now)
                   .where(stores_ids.nil? ? '' : "product_stores.store_id in (#{stores_ids.join(',')})")

    launches.order('products.user_product_views_count DESC')
    if args[:limit]
      launches.limit(args[:limit])
    end
  end
end
