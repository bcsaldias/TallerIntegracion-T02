FactoryGirl.define do
  factory :user do
    usuario { Faker::Lorem.word }
    nombre { Faker::Lorem.word }
    apellido { Faker::Lorem.word }
    twitter { Faker::Lorem.word }
  end
end