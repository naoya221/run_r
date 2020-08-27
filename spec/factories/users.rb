FactoryBot.define do
  factory :user do
    nickname              {"naoya"}
    email                 {"naoya@oosaki.com"}
    password              {"123abc"}
    password_confirmation {password}
  end
end