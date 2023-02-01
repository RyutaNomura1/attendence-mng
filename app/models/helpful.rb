class Helpful < ApplicationRecord
  belongs_to :user
  belongs_to :answer
  # validates_uniqueness_of :answer_id, scope: :user_id
end
