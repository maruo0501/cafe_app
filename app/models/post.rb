class Post < ApplicationRecord
  attr_accessor :authenticity_token, :commit

  validates :store_name, presence: true, length: { maximum: 20 }
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  mount_uploader :image, ImageUploader

  # 追記
  enum wifi: { yes: 0, no: 1 }, _prefix: true
  enum power: { yes: 0, no: 1 }, _prefix: true
  enum creditcard: { yes: 0, no: 1 }, _prefix: true

  belongs_to :user
  has_many :favorites
  has_many :comments, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
