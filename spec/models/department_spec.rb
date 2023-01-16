require 'rails_helper'

RSpec.describe Department, type: :model do
  subject {
    described_class.new(name: "Engineering")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
