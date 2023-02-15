class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :comment_body, presence: true, length: {maximum: 300}
end
