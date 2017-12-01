class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave if Rails.env.production?

  storage :file unless Rails.env.production?

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}" unless Rails.env.production?
  end
end
