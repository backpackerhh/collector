FactoryBot.define do
  factory :format do
    name { Faker::Lorem.word.capitalize }
  end
end
