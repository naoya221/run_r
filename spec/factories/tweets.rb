FactoryBot.define do
  factory :tweet do
    content       {Faker::Name.initials(number: 90)}
    place_image   {Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/dog2.png'))}
    address       {Faker::Name.initials(number: 20)}
    latitude      {35.6837}
    longitude     {139.629}
    place_name    {Faker::Name.initials(number: 5)}
    level         {1}
    association :user
  end
end
