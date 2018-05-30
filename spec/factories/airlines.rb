FactoryBot.define do
  factory :airline do
    sequence(:icao, "AAA")
    name Faker::Company.name
  end
end
