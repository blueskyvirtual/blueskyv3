# frozen_string_literal: true

require "rails_helper"

RSpec.describe Country, type: :model do
  it "has a valid factory" do
    expect(build(:country)).to be_valid
  end

  let(:country) { build(:country) }

  describe "ActiveRecord associations" do
    it { expect(country).to have_many(:regions) }
  end
  # describe 'ActiveRecord associations'

  describe "ActiveModel validations" do
    # Basic validations
    it { expect(country).to validate_presence_of(:code) }
    it { expect(country).to validate_presence_of(:name) }

    # Format validations
    it { expect(country).to_not allow_value("").for(:code) }
    it { expect(country).to_not allow_value("").for(:name) }

    # Inclusion/acceptance of values
    it { expect(country).to validate_uniqueness_of(:code).case_insensitive }
  end
  # describe 'ActiveModel validations'

  describe "#format_attributes" do
    before :each do
      @country = build(:country, code: "ts", name: "test country")
      @country.valid?
    end

    it "should upcase the code" do
      expect(@country.code).to eq "TS"
    end

    it "should titleize the name" do
      expect(@country.name).to eq "Test Country"
    end
  end

  describe "#to_s" do
    before :each do
      @country = country
    end

    it "should return: country name (code)" do
      expect(@country.to_s).to eq "#{@country.name} (#{@country.code})"
    end
  end
end
