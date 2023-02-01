class Post < ApplicationRecord
    belongs_to :user
    has_many :favorites, dependent: :destroy
    attachment :post_image
    validates :title, presence: true, length: {maximum: 30 }
    validates :post_image, presence: true
    validates :body, length: {maximum: 200}
    
end
  