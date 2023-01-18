require 'rails_helper'

RSpec.describe MysteryPartner, type: :model do

  let!(:department_1) { Department.create(name: 'Engineering') }
  let!(:department_2) { Department.create(name: 'Marketing') }
  let!(:employee_1) { Employee.create(name: 'John Doe', department_id: department_1.id) }
  let!(:employee_2) { Employee.create(name: 'John Doe', department_id: department_2.id) }

  subject {
    described_class.new(employee1_id: employee_1.id, employee2_id: employee_2.id, employee1_department_id: department_1.id, employee2_department_id: department_2.id)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
