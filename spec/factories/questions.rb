FactoryBot.define do
  factory :question do
    user_id               {1}
    question_title        {"title of question"}
    question_body         {"body of question"}
  end
end