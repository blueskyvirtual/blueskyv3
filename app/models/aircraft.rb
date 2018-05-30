# frozen_string_literal: true

class Aircraft < ApplicationRecord
  # Active Record associations
  belongs_to :airport, optional: true
  belongs_to :fleet

  # Active Record callbacks
  after_validation :format_attributes

  # Active Record validations
  validates :fleet, presence: true, allow_blank: false

  validates :registration,
            presence: true,
            uniqueness: { case_sensitive: false },
            allow_blank: false

  # Active Record delegations
  delegate :airline, to: :fleet
  delegate :icao,    to: :fleet

  # Display string for aircraft
  #
  def to_s
    "#{registration} (#{fleet.icao})"
  end

  private

    # Format attributes for display
    def format_attributes
      self.registration = registration.upcase unless registration.blank?
    end
end
