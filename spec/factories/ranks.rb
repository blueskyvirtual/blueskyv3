# frozen_string_literal: true

FactoryBot.define do
  factory :rank do
    sequence(:name) { |n| "Rank #{n}" }

    hours    { rand * (99999.9 - 0.1) + 0.1 }
    pay_rate { hours { rand * (999999.99 - 0.00) + 0.00 } }
  end
end
