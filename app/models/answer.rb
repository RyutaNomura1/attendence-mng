class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  validates :comment_body, presence: true
end
