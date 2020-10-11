class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts

  validates :password, {presence: true}
  # ユーザー画像追加
  # mount_uploader :image, ImageUploader
  mount_uploader :picture, PictureUploader

  def self.guest
    find_or_create_by(email: "test@example.com") do |user|
      user.password = 123456
    end
  end
end
