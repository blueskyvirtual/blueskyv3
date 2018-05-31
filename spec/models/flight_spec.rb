# frozen_string_literal: true

require "rails_helper"

RSpec.describe Flight, type: :model do
  it "has a valid factory" do
    expect(build(:flight)).to be_valid
  end

  let(:flight) { build(:flight) }

  describe "ActiveRecord associations" do
    it { expect(flight).to belong_to(:airline) }
    it { expect(flight).to belong_to(:fleet) }
    it { expect(flight).to belong_to(:origin) }
    it { expect(flight).to belong_to(:destination) }
  end
  # describe 'ActiveRecord associations'

  describe "ActiveModel validations" do
    # Basic validations
    it { expect(flight).to validate_presence_of(:airline) }
    it { expect(flight).to validate_presence_of(:origin) }
    it { expect(flight).to validate_presence_of(:destination) }
    it { expect(flight).to validate_presence_of(:depart_time) }
    it { expect(flight).to validate_presence_of(:arrive_time) }
    it { expect(flight).to validate_presence_of(:days) }
    it { expect(flight).to validate_presence_of(:fleet) }

    # Format validations
    it { expect(flight).to_not allow_value(nil).for(:airline) }
    it { expect(flight).to_not allow_value(nil).for(:number) }
    it { expect(flight).to_not allow_value(nil).for(:origin) }
    it { expect(flight).to_not allow_value(nil).for(:destination) }
    it { expect(flight).to_not allow_value(nil).for(:depart_time) }
    it { expect(flight).to_not allow_value(nil).for(:arrive_time) }
    it { expect(flight).to_not allow_value(nil).for(:days) }
    it { expect(flight).to_not allow_value(nil).for(:fleet) }

    # Inclusion/acceptance of values
    it { expect(flight).to validate_numericality_of(:number).is_greater_than(0) }
    it { expect(flight).to allow_value("1234567").for(:days) }
    it { expect(flight).to allow_value("1357").for(:days) }
    it { expect(flight).to allow_value("67").for(:days) }
  end
  # describe 'ActiveModel validations'

  describe "#duration" do
    it "calculates duration between depart_time and arrive_time" do
      dep_time = Time.now.utc
      arv_time = Time.now.utc + 2.57.hours
      flight = build(:flight, depart_time: dep_time, arrive_time: arv_time)
      expect(flight.duration).to eq 2.6
    end

    it "calculates duration between depart_time and arrive_time overnight" do
      dep_time = Time.parse("20:30")
      arv_time = Time.parse("04:00")
      flight = build(:flight, depart_time: dep_time, arrive_time: arv_time)
      expect(flight.duration).to eq 7.5
    end
  end

  describe "#fleet_belongs_to_airline" do
    before :each do
      @airline = build(:airline, name: "TEST")
      @fleet   = build(:fleet)
    end

    it "adds an error if the fleet does not belong to the airline" do
      expect(build(:flight, airline: @airline, fleet: @fleet)).to_not be_valid
    end

    it "does not add an error if the fleet belongs to the airline" do
      expect(build(:flight, airline: @fleet.airline, fleet: @fleet)).to be_valid
    end
  end
end
