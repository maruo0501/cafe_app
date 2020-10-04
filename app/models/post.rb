class Post < ApplicationRecord
  attr_accessor :authenticity_token, :commit
  validates :store_name, presence: true
  validates :content, presence: true, length:{maximum: 140}
  validates :user_id, presence: true
  mount_uploader :image, ImageUploader

  # 追記
  enum wifi: { yes: 0, no: 1 }, _prefix: true
  enum power: { yes: 0, no: 1 }, _prefix: true
  enum creditcard: { yes: 0, no: 1 }, _prefix: true

  belongs_to :user
end
