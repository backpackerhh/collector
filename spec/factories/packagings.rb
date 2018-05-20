FactoryBot.define do
  factory :packaging do
    name { Faker::Lorem.word.capitalize }
  end
end
