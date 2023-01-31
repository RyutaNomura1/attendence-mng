class Question < ApplicationRecord
  belongs_to :user
  has_many :helpfuls, dependent: :destroy
  validates :question_title, presence: true, length: {maximum: 30 }
  validates :question_body, presence: true, length: {maximum: 255 }
  
  def already_helpful?(question)
    self.helpfuls.exists?(question_id: question.id)
  end
end
