FactoryBot.define do
  factory :question do
    user_id                       {1}
    sequence(:question_title)     {|n|"question_title#{n}"}
    sequence(:question_body)      {|n|"question_body#{n}"}
  end
end