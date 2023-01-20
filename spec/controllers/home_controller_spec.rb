require 'rails_helper'

RSpec.describe HomeController do

  let!(:department_1) { FactoryBot.create(:department) }
  let!(:department_2) { FactoryBot.create(:department) }
  let!(:department_3) { FactoryBot.create(:department) }
  let!(:department_4) { FactoryBot.create(:department) }
  let!(:employee_1) { FactoryBot.create(:employee, department_id: department_1.id) }
  let!(:employee_2) { FactoryBot.create(:employee, department_id: department_2.id) }
  let!(:employee_3) { FactoryBot.create(:employee, department_id: department_3.id) }
  let!(:employee_4) { FactoryBot.create(:employee, department_id: department_4.id) }
  let!(:mystery_partner1) { MysteryPartner.create(employee1_id: employee_1.id, employee2_id: employee_2.id,  employee1_department_id: department_1.id, employee2_department_id: department_2.id, created_at: Time.new(2023, 1, 1)) }
  let!(:mystery_partner2) { MysteryPartner.create(employee1_id: employee_1.id, employee2_id: employee_3.id,  employee1_department_id: department_1.id, employee2_department_id: department_3.id) }



  describe "GET #index" do
    it "display mystery partners" do
      get 'index'
      expect(response).to be_successful
      expect(response.code).to eq '200'
    end
  end

  describe "with year_and_month params" do
    it "returns partners created in the specified year and month" do

      get 'index', params: {year: 2023, month: 1}
      expect(response).to be_successful
      expect(response.code).to eq '200'
    end
  end

  describe "filter_by_department params" do
    it "returns partners with matching department id" do

      get 'index', params: {department_1: department_1.id}
      expect(response).to be_successful
      expect(response.code).to eq '200'
    end
  end
end
