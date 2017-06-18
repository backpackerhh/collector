FactoryGirl.define do
  factory :edition do
    name         { Faker::Name.unique.name_with_middle }
    release_date { Faker::Date.between(15.years.ago, Date.current) }
    country_code { 'ES' }
    distributor
  end
end
