# frozen_string_literal: true

require "rails_helper"

RSpec.describe Airport, type: :model do
  it "has a valid factory" do
    expect(build(:airport)).to be_valid
  end

  let(:airport) { build(:airport) }

  describe "ActiveRecord associations" do
    it { expect(airport).to belong_to(:region) }
    it { expect(airport).to have_many(:aircraft) }
  end
  # describe 'ActiveRecord associations'

  describe "ActiveModel validations" do
    # Basic validations
    it { expect(airport).to validate_presence_of(:name) }
    it { expect(airport).to validate_presence_of(:city) }

    # Format validations
    it { expect(airport).to_not allow_value("").for(:name) }
    it { expect(airport).to_not allow_value("").for(:city) }

    # Inclusion/acceptance of values
    it { expect(airport).to validate_uniqueness_of(:icao).case_insensitive }
    it { expect(airport).to validate_length_of(:icao).is_equal_to(4) }
    it { expect(airport).to validate_length_of(:iata).is_equal_to(3) }


    it { expect(airport).to validate_numericality_of(:latitude).is_greater_than_or_equal_to(-90).is_less_than_or_equal_to(90) }
    it { expect(airport).to validate_numericality_of(:longitude).is_greater_than_or_equal_to(-180).is_less_than_or_equal_to(180) }
  end
  # describe 'ActiveModel validations'

  describe "#format_attributes" do
    before :each do
      @airport = build(:airport, icao: "test", iata: "tst", name: "test country")
      @airport.valid?
    end

    it "should upcase the ICAO" do
      expect(@airport.icao).to eq "TEST"
    end

    it "should upcase the IATA" do
      expect(@airport.iata).to eq "TST"
    end

    it "should titleize the name" do
      expect(@airport.name).to eq "Test Country"
    end
  end

  describe "#to_s" do
    before :each do
      @airport = airport
    end

    it "should return: airport name (code)" do
      expect(@airport.to_s).to eq "#{@airport.name} (#{@airport.icao})"
    end
  end
end
