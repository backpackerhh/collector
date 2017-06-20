FactoryGirl.define do
  factory :region do
    name { Faker::Number.between(1, 6) }
    format
  end
end
