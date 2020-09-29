class Post < ApplicationRecord
  attr_accessor :authenticity_token, :commit
  validates :store_name, presence: true
  validates :content, presence: true, length:{maximum: 140}
  mount_uploader :image, ImageUploader

end
