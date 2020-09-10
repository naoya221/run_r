FactoryBot.define do
  factory :ten_km_record do
    minute_id     {0}
    second_id     {1}

    association :user
  end
end
