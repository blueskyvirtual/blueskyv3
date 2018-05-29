# frozen_string_literal: true

require "rails_helper"

RSpec.describe Rank, type: :model do
  it "has a valid factory" do
    expect(build(:rank)).to be_valid
  end

  let(:rank) { build(:rank) }

  describe "ActiveModel validations" do
    # Basic validations
    it { expect(rank).to validate_presence_of(:name) }

    # Format validations
    it { expect(rank).to_not allow_value("").for(:name) }

    # Inclusion/acceptance of values
    it { expect(rank).to validate_uniqueness_of(:name) }

    it { expect(rank).to validate_numericality_of(:hours).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(99999.9) }
    it { expect(rank).to validate_numericality_of(:pay_rate).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(999999.99) }
  end
  # describe 'ActiveModel validations'

  describe "#format_attributes" do
    before :each do
      @rank = build(:rank, name: "test")
      @rank.valid?
    end

    it "should titleize the name" do
      expect(@rank.name).to eq "Test"
    end
  end

  describe "#to_s" do
    before :each do
      @rank = rank
    end

    it "should return: name" do
      expect(@rank.to_s).to eq @rank.name
    end
  end
end
