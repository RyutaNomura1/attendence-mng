class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :helpfuls
  validates :answer_body, presence: true
end
