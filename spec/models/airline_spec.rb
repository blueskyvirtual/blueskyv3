# frozen_string_literal: true

require "rails_helper"

RSpec.describe Airline, type: :model do
  it "has a valid factory" do
    expect(build(:airline)).to be_valid
  end

  let(:airline) { build(:airline) }

  describe "ActiveRecord associations" do
    it { expect(airline).to have_many(:fleets) }
  end
  # describe 'ActiveRecord associations'

  describe "ActiveModel validations" do
    # Basic validations
    it { expect(airline).to validate_presence_of(:icao) }
    it { expect(airline).to validate_presence_of(:name) }

    # Format validations
    it { expect(airline).to_not allow_value("").for(:icao) }
    it { expect(airline).to_not allow_value("").for(:name) }

    # Inclusion/acceptance of values
    it { expect(airline).to validate_uniqueness_of(:icao).case_insensitive }
    it { expect(airline).to validate_uniqueness_of(:name).case_insensitive }
    it { expect(airline).to validate_length_of(:icao).is_at_most(3) }
    it { expect(airline).to validate_length_of(:iata).is_at_most(2) }
  end
  # describe 'ActiveModel validations'

  describe "#format_attributes" do
    before :each do
      @airline = build(:airline, icao: "tst", iata: "ts", name: "test")
      @airline.valid?
    end

    it "should upcase the ICAO" do
      expect(@airline.icao).to eq "TST"
    end

    it "should upcase the IATA" do
      expect(@airline.iata).to eq "TS"
    end

    it "should titleize the name" do
      expect(@airline.name).to eq "Test"
    end
  end

  describe "#to_s" do
    before :each do
      @airline = build(:airline, icao: "TST", name: "Test")
    end

    it "should return: name (icao)" do
      expect(@airline.to_s).to eq "#{@airline.name} (#{@airline.icao})"
    end
  end
end
