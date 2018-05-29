# frozen_string_literal: true

class Rank < ApplicationRecord
  # Active Record validations
  validates :name,
            presence:     true,
            allow_blank:  false,
            uniqueness:   { case_sensitive: false }

  validates :hours,
            numericality: {
                greater_than_or_equal_to: 0,
                less_than_or_equal_to: 99999.9
            }

  validates :pay_rate,
            numericality: {
                greater_than_or_equal_to: 0,
                less_than_or_equal_to: 999999.99
            }

  # Active Record callbacks
  before_validation :format_attributes

  # Returns the rank name
  #
  def to_s
    name
  end

  private

    # Format the attributes
    #
    def format_attributes
      self.name = name.titleize unless name.blank?
    end
end
