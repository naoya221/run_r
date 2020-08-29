FactoryBot.define do
  factory :tweet do
    content              {Faker::Lorem.sentence}
    
    association :user
  end
end
