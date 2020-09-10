FactoryBot.define do
  factory :half_record do
    hour_id       {0}
    minute_id     {1}
    second_id     {2}

    association :user
  end
end
