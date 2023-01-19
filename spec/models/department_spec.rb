require 'rails_helper'

RSpec.describe Department, type: :model do
  subject {
    described_class.new(name: "Finance")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end
end
