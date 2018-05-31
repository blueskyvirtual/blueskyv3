# frozen_string_literal: true

class Flight < ApplicationRecord
  # Active Record associations
  belongs_to :airline
  belongs_to :fleet
  belongs_to :origin,      class_name: "Airport"
  belongs_to :destination, class_name: "Airport"

  # Active Record callbacks
  before_validation :calculate_distance

  # Active Record validations
  validates :airline,     presence: true, allow_blank: false
  validates :number,      numericality: { greater_than: 0 }
  validates :origin,      presence: true, allow_blank: false
  validates :destination, presence: true, allow_blank: false
  validates :depart_time, presence: true, allow_blank: false
  validates :arrive_time, presence: true, allow_blank: false
  validates :fleet,       presence: true, allow_blank: false
  validates :distance,    numericality: { greater_than_or_equal_to: 0 }

  validates :days,
            format: {
                with: /\A1?2?3?4?5?6?7?/,
                message: "invalid days of the week"
            },
            presence: true

  validate :fleet_belongs_to_airline

  # def distance

  # Calculate the duration in hours between departure time
  # and arrival time
  #
  #   Returns: float (scale 1)
  #   Example: 1.6
  #
  def duration
    if arrive_time < depart_time
      (((arrive_time + 1.day) - depart_time) / 1.hour).round 1
    else
      ((arrive_time - depart_time) / 1.hour).round 1
    end
  end

  private

    # Calculates the distance in Nautical Miles between origin and destination
    #
    def calculate_distance
      return if origin.blank? || destination.blank?
      self.distance = origin.distance_to(destination, :nm)
    end

    # Validates the fleet belongs to the airline
    #
    def fleet_belongs_to_airline
      return if airline.blank? || fleet.blank?

      unless airline == fleet.airline
        errors.add(:fleet, "does not belong to airline")
      end
    end
end
