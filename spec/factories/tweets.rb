FactoryBot.define do
  factory :tweet do
    content     {Faker::Name.initials(number: 10)}
    address       {"東京都千代田区千代田1-1"}
    latitude      {35.6837}
    longitude     {139.629}
    place_name    {Faker::Name.initials(number: 10)}
    association :user
  end
end
