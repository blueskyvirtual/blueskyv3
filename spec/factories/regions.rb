# frozen_string_literal: true

FactoryBot.define do
  factory :region do
    association :country

    code Faker::Address.state_abbr
    name Faker::Address.state

    initialize_with { Region.find_or_create_by(code: code) }
  end
end
