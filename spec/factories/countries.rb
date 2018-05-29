# frozen_string_literal: true

FactoryBot.define do
  factory :country do
    code Faker::Address.country_code
    name Faker::Address.country

    initialize_with { Country.find_or_create_by(code: code) }
  end
end
