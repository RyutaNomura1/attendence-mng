FactoryBot.define do
  factory :user do
    username              {"山田太郎"}
    sequence(:email)      {|n| "user_#{n}@example.com"} 
    password              {"password"}
    password_confirmation {"password"}
  end
en