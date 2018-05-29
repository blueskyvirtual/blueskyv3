FactoryBot.define do
  factory :airport do
    association :region

    sequence(:icao, "AAAA")
    sequence(:elevation)

    name      "#{Faker::Name.name} Airport"
    city      Faker::Address.city
    latitude  Faker::Address.latitude
    longitude Faker::Address.longitude
  end
end
