module ProductsUtils

  PRODUCTS_IMPORT_TEMP_SUFFIX_ID = 'import_products_'


  def get_cached_products_for_import(temp_uuid)
    $redis.get(PRODUCTS_IMPORT_TEMP_SUFFIX_ID + temp_uuid)
  end

  #
  # Cache a new products
  def set_cached_products_for_import(products)
    require 'securerandom'
    temp_uuid = SecureRandom.uuid
    temp_id = PRODUCTS_IMPORT_TEMP_SUFFIX_ID + temp_uuid
    # store hash as string
    $redis.set(temp_id, products)
    # Expire the cache, every 30 minutes
    $redis.expire(temp_id, 30.minutes.to_i)

    temp_uuid
  end


end