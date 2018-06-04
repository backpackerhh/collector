FactoryBot.define do
  factory :packaging do
    name { Faker::Lorem.unique.word.capitalize }
  end
end
