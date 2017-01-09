class ProductUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "#{model.media_store_dir}/pictures/"
  end

  def filename
    @name ||= "#{timestamp}-#{super}" if original_filename.present? and super.present?
  end


  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  protected

  def timestamp
    var = :"@#{mounted_as}_timestamp"
    model.instance_variable_get(var) or model.instance_variable_set(var, Time.now.to_i)
  end

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end

  version :thumb do
    process resize_to_fill: [280, 280]
  end

  version :small_thumb, from_version: :thumb do
    process resize_to_fill: [20, 20]
  end

end