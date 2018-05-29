FactoryBot.define do
  factory :format do
    name { Faker::Lorem.unique.word.capitalize }
  end
end
