FactoryBot.define do
  factory :five_km_record do
    minute_id     {0}
    second_id     {1}
    
    association :user
  end
end
