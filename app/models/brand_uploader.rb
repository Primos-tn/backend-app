class BrandUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  def store_dir
    "#{model.account.id}/brand/#{model.id}"
  end

  version :thumb do
    process resize_to_fill: [280, 280]
  end

  version :small_thumb, from_version: :thumb do
    process resize_to_fill: [20, 20]
  end

end