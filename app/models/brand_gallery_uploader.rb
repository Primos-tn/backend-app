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
    after :store, :set_dominant_colors
  end

  version :small_thumb, from_version: :thumb do
    process resize_to_fill: [20, 20]
  end

  def set_dominant_colors(file)
    # use  self.path to get the path
    # histo = MiniMagick::Tool::Convert.new do |cmd|
    #   cmd << self.path
    #   cmd << '-colors 6'
    #   cmd <<  '-format %c'
    #   cmd << 'histogram:info:-'
    # end
    ImageProcessing.perform_later model

  end

end