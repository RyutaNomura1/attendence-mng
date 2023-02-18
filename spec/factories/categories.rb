FactoryBot.define do
  factory :japan, class: Category do
    big_category          {"国内旅行"}
    name                  {"japan"}
  end
  factory :asia, class: Category do
    big_category          {"アジア"}
    name                  {"asia"}
  end
  factory :oceania, class: Category do
    big_category          {"オセアニア"}
    name                  {"oceania"}
  end
  factory :north_america, class: Category do
    big_category          {"北アメリカ"}
    name                  {"north_america"}
  end
  factory :europe, class: Category do
    big_category          {"ヨーロッパ"}
    name                  {"europe"}
  end
  factory :other, class: Category do
    big_category          {"その他"}
    name                  {"other"}
  end
end