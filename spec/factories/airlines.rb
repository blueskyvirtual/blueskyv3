# frozen_string_literal: true

FactoryBot.define do
  factory :airline do
    sequence(:icao, "AAA")
    name Faker::Company.name
  end
end
