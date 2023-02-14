FactoryBot.define do
  factory :user do
    username              {"山田太郎"}
    email                 {"example@mail.com"}
    password              {"password"}
    password_confirmation {"password"}
  end
end