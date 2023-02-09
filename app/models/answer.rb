class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :helpfuls, dependent: :destroy
  validates :answer_body, presence: true
end
