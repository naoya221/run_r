FactoryBot.define do
  factory :tweet do
    content              {"naoya"}
    
    association :user
  end
end
