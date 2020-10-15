class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :posts
  has_many :favorites
  has_many :favorite_posts, through: :favorites, source: :post 
  has_many :comments, dependent: :destroy
  has_many :comment_posts, through: :comments, source: :post 

  # バリデーション
  before_save { self.email = email.downcase }
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :encrypted_password, presence: true, length: { minimum: 6 }
  
  # ユーザー画像追加
  mount_uploader :picture, PictureUploader

  def self.guest
    find_or_create_by(email: "test@example.com") do |user|
      user.password = 123456
      user.name = "ゲストユーザー"
    end
  end
end
