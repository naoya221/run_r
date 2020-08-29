FactoryBot.define do
  factory :message do
    text     {Faker::Lorem.sentence}
    
    association :user
    association :tweet
  end
end
