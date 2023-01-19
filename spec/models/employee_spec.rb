require 'rails_helper'

RSpec.describe Employee, type: :model do

  let!(:department) { Department.create(name: 'Marketing') }

  subject {
    described_class.new(name: "Asad", department_id: department.id)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "associations" do
    it { should belong_to(:department) }
    it { should have_one_attached(:image) }
  end
end
