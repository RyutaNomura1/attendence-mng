FactoryBot.define do
  factory :post do
    user_id               {1}
    title                 {"Title of Post"}
    profile_image_id      {"password"}
  end
end