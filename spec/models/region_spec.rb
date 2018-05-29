# frozen_string_literal: true

require "rails_helper"

RSpec.describe Region, type: :model do
  it "has a valid factory" do
    expect(build(:region)).to be_valid
  end

  let(:region) { build(:region) }

  describe "ActiveRecord associations" do
    it { expect(region).to belong_to(:country) }
  end
  # describe 'ActiveRecord associations'

  describe "ActiveModel validations" do
    # Basic validations
    it { expect(region).to validate_presence_of(:code) }
    it { expect(region).to validate_presence_of(:name) }

    # Format validations
    it { expect(region).to_not allow_value("").for(:code) }
    it { expect(region).to_not allow_value("").for(:name) }

    # Inclusion/acceptance of values
    it { expect(region).to validate_uniqueness_of(:code).case_insensitive }
  end
  # describe 'ActiveModel validations'

  describe "#format_attributes" do
    before :each do
      @region = build(:region, code: "ts", name: "test region")
      @region.valid?
    end

    it "should upcase the code" do
      expect(@region.code).to eq "TS"
    end

    it "should titleize the name" do
      expect(@region.name).to eq "Test Region"
    end
  end

  describe "#to_s" do
    before :each do
      @region = region
    end

    it "should return: region name (code)" do
      expect(@region.to_s).to eq "#{@region.name} (#{@region.code})"
    end
  end
end
