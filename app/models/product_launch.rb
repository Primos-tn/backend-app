class ProductLaunch < ApplicationRecord
  belongs_to :product
  # only allow one launch by product
  validates_uniqueness_of :product, scope: [:launch_date]

  def self.launches_of_day(args)
    stores_ids = args[:stores_ids]
    if stores_ids && stores_ids.length == 0
      stores_ids = [-1]
    end
    ProductLaunch
        .joins(product: [:brand, :stores])
        .where({launch_date: Date.today})
        .where(stores_ids.nil? ? '' : "product_stores.store_id in (#{stores_ids.join(',')})")
        .select('distinct on (products.brand_id) product_launches.products_collection_id, product_launches.product_id')
        .order('"products"."brand_id",  products.user_product_views_count DESC')
  end
end
