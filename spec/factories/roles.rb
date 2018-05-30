# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    sequence(:name) { |r| "Role #{r}" }
  end
end
