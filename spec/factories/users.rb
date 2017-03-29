FactoryGirl.define do
  factory :user do
    username { Faker::Lorem.word }
    name { Faker::Lorem.word }
    last_name { Faker::Lorem.word }
    twitter { Faker::Lorem.word }
  end
end