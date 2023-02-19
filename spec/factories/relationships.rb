FactoryBot.define do
  # :userが:other_userをフォロー
  factory :relationship1 , class: Relationship do
    follower_id     {1}
    followed_id     {2}
  end
  # :other_userが:userをフォロー
  factory :relationship2 , class: Relationship do
    follower_id     {2}
    followed_id     {1}
  end

end