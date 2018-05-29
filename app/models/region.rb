# frozen_string_literal: true

class Region < ApplicationRecord
  # Active Record associations
  belongs_to :country
  has_many   :airports, dependent: :destroy

  # Active Record validations
  validates :code, uniqueness: { case_sensitive: false }, presence: true
  validates :name, presence: true, allow_blank: false

  before_validation :format_attributes

  # Returns country attributes as Country Name (Code)
  #
  def to_s
    "#{name} (#{code})"
  end

  private

    # Format the attributes for display
    #
    def format_attributes
      self.code = code.upcase   unless code.blank? # ensure code is capitalized
      self.name = name.titleize unless name.blank? # ensure name is cased
    end
end
