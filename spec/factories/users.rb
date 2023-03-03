FactoryBot.define do
  factory :user do
    sequence(:username)              {|n| "username#{n}"}
    sequence(:email)                {|n| "user_#{n}@example.com"} 
    password                        {"password"}
    password_confirmation           {"password"}
    sequence(:profile)              {|n| "profile#{n}"}
    sequence(:travel_period)        {|n| "travel_period#{n}"}
    sequence(:current_location)     {|n| "current_location#{n}"}
  end
end