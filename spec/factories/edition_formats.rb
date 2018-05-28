FactoryBot.define do
  factory :edition_format do
    number_of_discs { (1..10).to_a.sample }
    edition
    format
  end
end
