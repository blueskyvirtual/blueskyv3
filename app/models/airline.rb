# frozen_string_literal: true

class Airline < ApplicationRecord
  # Active Record associations
  has_many :fleets, dependent: :destroy

  # Active Record validations
  validates :icao,
            presence:    true,
            length:      { maximum: 3 },
            uniqueness:  { case_sensitive: false },
            allow_blank: false

  validates :iata,
            length:      { maximum: 2 },
            uniqueness:  { case_sensitive: false },
            allow_blank: true

  validates :name,
            presence:    true,
            uniqueness:  { case_sensitive: false },
            allow_blank: false

  # Active Record callbacks
  after_validation :format_attributes

  # Return a display string Airline (ICAO)
  #
  def to_s
    "#{name} (#{icao})"
  end

  private

    # Format attributes for display
    #
    def format_attributes
      self.icao = icao.upcase    unless icao.blank?
      self.iata = iata.upcase    unless iata.blank?
      self.name = name.titlecase unless name.blank?
    end
end
