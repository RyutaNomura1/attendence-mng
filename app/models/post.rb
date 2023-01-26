class Post < ApplicationRecord
    belongs_to :user
    attachment :post_image
    validates :title, presence: true, length: {maximum: 30 }
    validates :post_image, presence: true
end
