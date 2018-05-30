# frozen_string_literal: true

FactoryBot.define do
  factory :aircraft do
    association :fleet

    sequence :registration, "N00000"
  end
end
