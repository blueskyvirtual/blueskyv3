# frozen_string_literal: true

class Airport < ApplicationRecord
  # Geocoded
  reverse_geocoded_by :latitude, :longitude

  # Active Record associations
  belongs_to :region
  has_many   :aircraft,   dependent: :nullify

  has_many   :scheduled_arrivals,
             dependent:   :destroy,
             class_name:  "Flight",
             foreign_key: :destination_id

  has_many   :scheduled_departures,
             dependent:   :destroy,
             class_name:  "Flight",
             foreign_key: :origin_id

  # Active Record validations
  validates :icao,
            length:      { is: 4 },
            uniqueness:  { case_sensitive: false },
            allow_blank: false

  validates :iata,      length: { is: 3 }, allow_blank: true
  validates :name,      presence: true, allow_blank: false
  validates :city,      presence: true, allow_blank: false
  validates :elevation, presence: true, allow_blank: false

  validates :latitude, numericality: {
      greater_than_or_equal_to: -90,
      less_than_or_equal_to: 90
  }

  validates :longitude, numericality: {
      greater_than_or_equal_to: -180,
      less_than_or_equal_to: 180
  }

  # Active Record callbacks
  before_validation :format_attributes

  # Returns airport name (ICAO)
  #
  def to_s
    "#{city}, #{region.code} (#{icao})"
  end

  private

    # Formats the attributes for display
    def format_attributes
      self.icao = icao.upcase   unless icao.blank? # ensure ICAO is capitalized
      self.iata = iata.upcase   unless iata.blank? # ensure ICAO is capitalized
      self.name = name.titleize unless name.blank? # ensure name is cased
      self.city = city.titleize unless city.blank? # ensure name is cased
    end
end
