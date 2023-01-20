require 'rails_helper'

RSpec.describe MysteryMatchModifier do

  let!(:department_1) { FactoryBot.create(:department) }
  let!(:department_2) { FactoryBot.create(:department) }
  let!(:department_3) { FactoryBot.create(:department) }
  let!(:department_4) { FactoryBot.create(:department) }

  let!(:employee_1) { FactoryBot.create(:employee, department_id: department_1.id) }
  let!(:employee_2) { FactoryBot.create(:employee, department_id: department_2.id) }
  let!(:employee_3) { FactoryBot.create(:employee, department_id: department_3.id) }
  let!(:employee_4) { FactoryBot.create(:employee, department_id: department_4.id) }

  describe "#call" do

    describe "when new employee is added" do
      it "Add the new to employee to existing mystery match partners" do
        mystery_partner1 = MysteryPartner.create(employee1_id: employee_1.id, employee2_id: employee_2.id,  employee1_department_id: department_1.id, employee2_department_id: department_2.id)
        mystery_partner2 = MysteryPartner.create(employee1_id: employee_1.id, employee2_id: employee_3.id,  employee1_department_id: department_1.id, employee2_department_id: department_3.id)

        new_employee = Employee.create(department_id: department_3.id)

        MysteryMatchModifier.new(employee_id: new_employee.id, department_id: department_3.id, action: 'add').call

        expect(mystery_partner1.employee3_id).to eq(new_employee.id)
      end
    end

    describe "when am employee is deleted" do
      it "Remove the employee from existing mystery match partners" do
        mystery_partner1 = MysteryPartner.create(employee1_id: employee_1.id, employee2_id: employee_2.id, employee3_id: employee_4.id, employee1_department_id: department_1.id, employee2_department_id: department_2.id, employee3_department_id: department_4.id )
        mystery_partner2 = MysteryPartner.create(employee1_id: employee_1.id, employee2_id: employee_3.id,  employee1_department_id: department_1.id, employee2_department_id: department_3.id)

        MysteryMatchModifier.new(employee_id: employee_4.id, department_id: department_4.id, action: 'delete').call

        expect(mystery_partner1.reload.employee3_id).to eq nil
      end
    end
  end
end
