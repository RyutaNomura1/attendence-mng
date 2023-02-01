class Question < ApplicationRecord
  belongs_to :user
  has_many :asnwers, dependent: :destroy
  validates :question_title, presence: true, length: {maximum: 30 }
  validates :question_body, presence: true, length: {maximum: 255 }
  
end
