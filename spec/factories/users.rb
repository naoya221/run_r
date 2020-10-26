FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 6)}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    image                 {'public/images/1.png'}
    introduction          {Faker::Lorem.sentence}
  end
end
