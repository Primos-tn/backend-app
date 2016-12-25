class ProductCouponImage < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "#{model.product.media_store_dir}/coupons/"
  end

  def filename
    "#{model.value}.#{file.extension}"
  end
end