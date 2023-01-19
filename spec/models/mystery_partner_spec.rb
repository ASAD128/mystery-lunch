require 'rails_helper'

RSpec.describe MysteryPartner, type: :model do

  let!(:department_1) { Department.create(name: 'Operations') }
  let!(:department_2) { Department.create(name: 'Marketing') }
  let!(:department_3) { Department.create(name: 'Finance') }
  let!(:department_4) { Department.create(name: 'Risk') }
  let!(:employee_1) { Employee.create(name: 'Mikey', department_id: department_1.id) }
  let!(:employee_2) { Employee.create(name: 'Billy', department_id: department_2.id) }
  let!(:employee_3) { Employee.create(name: 'Cindy', department_id: department_3.id) }
  let!(:employee_4) { Employee.create(name: 'Bella', department_id: department_4.id) }

  subject {
    described_class.new(employee1_id: employee_1.id, employee2_id: employee_2.id, employee1_department_id: department_1.id, employee2_department_id: department_2.id)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  describe ".with_year_and_month" do
    it "returns partners created in the specified year and month" do
      mystery_partner1 = MysteryPartner.create(employee1_id: employee_1.id, employee2_id: employee_2.id,  employee1_department_id: department_1.id, employee2_department_id: department_2.id, created_at: Time.new(2023, 1, 1))
      mystery_partner2 = MysteryPartner.create(employee1_id: employee_1.id, employee2_id: employee_2.id,  employee1_department_id: department_1.id, employee2_department_id: department_2.id, created_at: Time.new(2023, 2, 1))
      mystery_partner3 = MysteryPartner.create(employee1_id: employee_1.id, employee2_id: employee_2.id,  employee1_department_id: department_1.id, employee2_department_id: department_2.id, created_at: Time.new(2022, 12, 12))

      # Call the scope
      result = MysteryPartner.with_year_and_month(2023, 1)

      # Expect the result to include the partner created in January 2023
      expect(result).to include(mystery_partner1)
      # Expect the result to not include the partner created in February 2023 or December 2022
      expect(result).to_not include(mystery_partner2, mystery_partner3)
    end
  end

  describe ".filter_by_department" do
    it "returns partners with matching department id" do
      mystery_partner1 = MysteryPartner.create(employee1_id: employee_1.id, employee2_id: employee_2.id,  employee1_department_id: department_1.id, employee2_department_id: department_2.id)
      mystery_partner2 = MysteryPartner.create(employee1_id: employee_2.id, employee2_id: employee_3.id,  employee1_department_id: department_2.id, employee2_department_id: department_3.id)
      mystery_partner3 = MysteryPartner.create(employee1_id: employee_1.id, employee2_id: employee_3.id,  employee1_department_id: department_1.id, employee2_department_id: department_3.id)
      mystery_partner4 = MysteryPartner.create(employee1_id: employee_3.id, employee2_id: employee_4.id,  employee1_department_id: department_3.id, employee2_department_id: department_4.id)

      # Call the scope
      result = MysteryPartner.filter_by_department(department_1.id)

      # Expect the result to include the mystery_partners with either employee1 or employee2 or employee3 from department_1
      expect(result).to include(mystery_partner1, mystery_partner3)
      # Expect the result to exclude the mystery_partners with employee1 or employee2 or employee3 if any of them not belong to department_1
      expect(result).to_not include(mystery_partner2, mystery_partner4)
    end
  end
end
