FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    avatar { Faker::Avatar.image }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
