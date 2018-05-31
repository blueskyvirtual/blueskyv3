# frozen_string_literal: true

FactoryBot.define do
  factory :flight do
    association :airline
    association :origin,      factory: :airport
    association :destination, factory: :airport

    sequence :number

    fleet       { build(:fleet, airline: airline) }
    depart_time { Time.now.utc }
    arrive_time { depart_time + rand(1..23).hours }
  end
end
