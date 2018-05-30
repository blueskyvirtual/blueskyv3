# frozen_string_literal: true

require "rails_helper"

RSpec.describe Fleet, type: :model do
  it "has a valid factory" do
    expect(build(:fleet)).to be_valid
  end

  let(:fleet) { build(:fleet) }

  describe "ActiveRecord associations" do
    it { expect(fleet).to belong_to(:airline) }
    it { expect(fleet).to have_many(:aircraft) }
  end
  # describe 'ActiveRecord associations'

  describe "ActiveModel validations" do
    # Basic validations
    it { expect(fleet).to validate_presence_of(:icao) }
    it { expect(fleet).to validate_presence_of(:name) }
    it { expect(fleet).to validate_presence_of(:cat) }
    it { expect(fleet).to validate_presence_of(:pax) }
    it { expect(fleet).to validate_presence_of(:oew) }   # Operational Empty Weight
    it { expect(fleet).to validate_presence_of(:mzfw) }  # Maximum Zero Fuel Weight
    it { expect(fleet).to validate_presence_of(:mtow) }  # Maximum Takeoff Weight
    it { expect(fleet).to validate_presence_of(:mlw) }   # Maximum Landing Weight
    it { expect(fleet).to validate_presence_of(:mfc) }   # Maximum Fuel Capacity
    it { expect(fleet).to validate_presence_of(:ff) }    # Fuel factor

    # Format validations
    it { expect(fleet).to_not allow_value("").for(:icao) }
    it { expect(fleet).to_not allow_value("").for(:name) }
    it { expect(fleet).to_not allow_value("").for(:cat) }
    it { expect(fleet).to allow_value(nil).for(:ci) }


    # Inclusion/acceptance of values
    # it { expect(fleet).to validate_uniqueness_of(:name).case_insensitive.scoped_to(:airline) }
    it { expect(fleet).to validate_length_of(:icao).is_at_most(4) }
    it { expect(fleet).to validate_inclusion_of(:cat).in_array(["L", "M", "H", "S"]) }
    it { expect(fleet).to validate_numericality_of(:pax).is_greater_than_or_equal_to(0) }
    it { expect(fleet).to validate_numericality_of(:oew).is_greater_than(0) }
    it { expect(fleet).to validate_numericality_of(:mzfw).is_greater_than(0) }
    it { expect(fleet).to validate_numericality_of(:mtow).is_greater_than(0) }
    it { expect(fleet).to validate_numericality_of(:mlw).is_greater_than(0) }
    it { expect(fleet).to validate_numericality_of(:mfc).is_greater_than(0) }
    it { expect(fleet).to validate_numericality_of(:ff).is_greater_than_or_equal_to(-80).is_less_than_or_equal_to(80) }
    it { expect(fleet).to validate_numericality_of(:ci).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(999).allow_nil }
  end
  # describe 'ActiveModel validations'

  describe "#format_attributes" do
    before :each do
      @fleet = build(:fleet, icao: "b744", name: "boeing 747-400")
      @fleet.valid?
    end

    it "should upcase the ICAO" do
      expect(@fleet.icao).to eq "B744"
    end

    # it "should titleize the name" do
    #   expect(@fleet.name).to eq "Boeing 747-400"
    # end
  end

  describe "#to_s" do
    before :each do
      @fleet = build(:fleet, icao: "B738", name: "Boeing 737-800")
    end

    it "should return: airline - name (icao)" do
      expect(@fleet.to_s).to eq "#{@fleet.airline.name} - #{@fleet.name} (#{@fleet.icao})"
    end
  end
end
