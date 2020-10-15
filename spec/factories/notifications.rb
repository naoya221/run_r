FactoryBot.define do
  factory :notification do
    visitor { nil }
    visited { nil }
    tweet { nil }
    action { "MyString" }
    checked { false }
  end
end
