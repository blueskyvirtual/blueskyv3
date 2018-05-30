# frozen_string_literal: true

FactoryBot.define do
  factory :fleet do
    association :airline
    sequence :icao, "AAAA"

    name Faker::Vehicle.manufacture

    cat    { [ "L", "M", "H", "S" ][rand(0..3)] }
    equip  { [ "G", "L"][rand(0..1)] }

    pax { rand(0..999) }

    oew  { rand(100..400000) }
    mzfw { rand(100..400000) }
    mtow { rand(100..400000) }
    mlw  { rand(100..400000) }
    mfc  { rand(100..400000) }
    ff   { rand(-80..80) }
    ci   { rand(0..999) }
  end
end
