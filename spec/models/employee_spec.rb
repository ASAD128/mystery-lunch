require 'rails_helper'

RSpec.describe Employee, type: :model do

  subject {
    described_class.new(name: "Asad")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
