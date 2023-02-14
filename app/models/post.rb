class Post < ApplicationRecord
    belongs_to :user
    has_many :favorites, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :post_categories
    has_many :categories, through: :post_categories
    attachment :post_image
    validates :title, presence: true, length: {maximum: 30 }
    validates :post_image, presence: true
    validates :body, length: {maximum: 300}
    validates :location, length: {maximum: 30 }
end
  