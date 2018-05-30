# frozen_string_literal: true

require "rails_helper"

RSpec.describe Aircraft, type: :model do
  it "has a valid factory" do
    expect(build(:aircraft)).to be_valid
  end

  let(:aircraft) { build(:aircraft) }

  describe "ActiveRecord associations" do
    it { expect(aircraft).to belong_to(:fleet) }
    it { expect(aircraft).to belong_to(:airport) }
  end
  # describe 'ActiveRecord associations'

  describe "ActiveModel validations" do
    # Basic validations
    it { expect(aircraft).to validate_presence_of(:registration) }

    # Format validations
    it { expect(aircraft).to_not allow_value("").for(:registration) }

    # Inclusion/acceptance of values
    it { expect(aircraft).to validate_uniqueness_of(:registration).case_insensitive }
  end
  # describe 'ActiveModel validations'

  describe "#airline" do
    before :each do
      @aircraft = create(:aircraft)
    end

    it "returns the airline object for the aircraft" do
      expect(@aircraft.airline).to eq @aircraft.fleet.airline
    end
  end

  describe "#icao" do
    before :each do
      @aircraft = create(:aircraft)
    end

    it "returns the icao from the fleet for the aircraft" do
      expect(@aircraft.icao).to eq @aircraft.fleet.icao
    end
  end

  describe "#format_attributes" do
    before :each do
      @aircraft = build(:aircraft, registration: "n6062l")
      @aircraft.valid?
    end

    it "should upcase the ICAO" do
      expect(@aircraft.registration).to eq "N6062L"
    end
  end

  describe "#to_s" do
    before :each do
      @fleet    = build(:fleet, icao: "B738", name: "Boeing 737-800")
      @aircraft = build(:aircraft, fleet: @fleet, registration: "N1236U")
    end

    it "should return: Registration (Fleet ICAO)" do
      expect(@aircraft.to_s).to eq "#{@aircraft.registration} (#{@fleet.icao})"
    end
  end
end
