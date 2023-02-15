FactoryBot.define do
  factory :answer do
    user_id               {1}
    question_id               {1}
    answer_body           {"山田太郎"}
  end
end