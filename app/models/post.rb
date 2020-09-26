class Post < ApplicationRecord
  validates :store_name, presence: true
  validates :content, presence: true, length:{maximum: 140}
end
