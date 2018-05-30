# frozen_string_literal: true

class Role < ApplicationRecord
  # Active Record validations
  validates :name, presence: true, uniqueness: true

  # Active Record callbacks
  before_validation :format_attributes

  # Returns the display string
  #
  def to_s
    name
  end

  private

    # Formats the attributes for display
    #
    def format_attributes
      self.name = name.titleize unless name.blank?
    end
end
