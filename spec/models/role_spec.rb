# frozen_string_literal: true

require "rails_helper"

RSpec.describe Role, type: :model do
  it "has a valid factory" do
    expect(build(:role)).to be_valid
  end

  let(:role) { build(:role) }

  describe "ActiveModel validations" do
    # Basic validations
    it { expect(role).to validate_presence_of(:name) }

    # Format validations
    it { expect(role).to_not allow_value("").for(:name) }

    # Inclusion/acceptance of values
    it { expect(role).to validate_uniqueness_of(:name) }
  end
  # describe 'ActiveModel validations'

  describe "#format_attributes" do
    before :each do
      @role = build(:role, name: "test")
      @role.valid?
    end

    it "should titleize the name" do
      expect(@role.name).to eq "Test"
    end
  end

  describe "#to_s" do
    before :each do
      @role = build(:rank, name: "Test")
    end

    it "should return: name" do
      expect(@role.to_s).to eq @role.name
    end
  end
end
