FactoryBot.define do
  factory :user do
    nickname              {"naoya"}
    email                 {"naoya@oosaki.com"}
    password              {"123abc"}
    password_confirmation {password}
    image                 {"public/images/1.png"}
  end
end