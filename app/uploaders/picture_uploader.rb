class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  #　production環境ならクラウドサービス、その他はローカルに保存
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process :resize_to_fit => [50, 50]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
