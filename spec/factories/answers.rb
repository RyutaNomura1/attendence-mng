FactoryBot.define do
  factory :answer do
    user_id                     {1}
    question_id                 {1}
    sequence(:answer_body)      {|n| "answer_body#{n}"}
  end

end