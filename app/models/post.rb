class Post < ApplicationRecord
  validates :store_name, presence: true
  validates :content, presence: true, length:{maximum: 140}
  mount_uploaders :images, ImagesUploader
  # has_many_attached :images
end
