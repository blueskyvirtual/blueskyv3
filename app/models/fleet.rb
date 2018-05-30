# frozen_string_literal: true

class Fleet < ApplicationRecord
  # Active Record associations
  belongs_to :airline

  # Active Record callbacks
  after_validation :format_attributes

  # Active Record validations
  validates :icao, length: { maximum: 4 }, presence: true, allow_blank: false

  validates :name,
            uniqueness:  { case_sensitive: false, scope: :airline },
            presence:    true,
            allow_blank: false

  validates :cat,
            presence:    true,
            inclusion:   { in: ["L", "M", "H", "S"] },
            allow_blank: false

  validates :equip, presence: true, allow_blank: false

  validates :pax,  numericality: { greater_than_or_equal_to:  0 }, presence: true
  validates :oew,  numericality: { greater_than:  0 }, presence: true
  validates :mzfw, numericality: { greater_than:  0 }, presence: true
  validates :mtow, numericality: { greater_than:  0 }, presence: true
  validates :mlw,  numericality: { greater_than:  0 }, presence: true
  validates :mfc,  numericality: { greater_than:  0 }, presence: true

  validates :ff,
            numericality: {
                greater_than_or_equal_to: -80,
                less_than_or_equal_to:    80
            },
            presence: true

  validates :ci,
            numericality: {
                greater_than_or_equal_to: 0,
                less_than_or_equal_to:    999
            },
            allow_blank: true

  # Returns the name of the object for display
  #
  def to_s
    "#{airline.name} - #{name} (#{icao})"
  end

  private

    # Standardize the format of attributes
    #
    def format_attributes
      self.icao = icao.upcase unless icao.blank?
    end
end
