# frozen_string_literal: true

class Airport < ApplicationRecord
  # Active Record associations
  belongs_to :region
  has_many   :aircraft, dependent: :nullify

  # Active Record validations
  validates :icao,
            length:      { is: 4 },
            allow_blank: false,
            uniqueness:  { case_sensitive: false }

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
    "#{name} (#{icao})"
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
