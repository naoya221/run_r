FactoryBot.define do
  factory :message do
    text     {"naoya"}
    
    association :user
    association :tweet
  end
end
