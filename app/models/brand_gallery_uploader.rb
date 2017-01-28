class BrandGalleryUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def extension_white_list
    %w(jpg jpeg png gif)
  end

  def store_dir
    "#{model.brand.media_store_dir}/gallery/"
  end

  version :thumb do
    process resize_to_fill: [280, 280]
    # DON'T USE IT HERE , THE job is faster so it will
    # Raise an error with model not serializable
    #after :store, :set_dominant_colors
  end

  version :small_thumb, from_version: :thumb do
    process resize_to_fill: [20, 20]
  end


end