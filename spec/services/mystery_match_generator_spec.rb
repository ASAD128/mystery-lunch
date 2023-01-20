require 'rails_helper'

RSpec.describe MysteryMatchGenerator do

  let(:service) { described_class.new }
  let!(:department_1) { FactoryBot.create(:department) }
  let!(:department_2) { FactoryBot.create(:department) }
  let!(:department_3) { FactoryBot.create(:department) }
  let!(:department_4) { FactoryBot.create(:department) }
  let!(:department_5) { FactoryBot.create(:department) }
  let!(:department_6) { FactoryBot.create(:department) }

  let!(:employee_1) { FactoryBot.create(:employee, department_id: department_1.id) }
  let!(:employee_2) { FactoryBot.create(:employee, department_id: department_2.id) }
  let!(:employee_3) { FactoryBot.create(:employee, department_id: department_3.id) }
  let!(:employee_4) { FactoryBot.create(:employee, department_id: department_4.id) }
  let!(:employee_5) { FactoryBot.create(:employee, department_id: department_5.id) }
  let!(:employee_6) { FactoryBot.create(:employee, department_id: department_6.id) }

  describe '#call' do
    it 'create mystery match partners and save result in DB' do
      service.call
      expect(MysteryPartner.count).to eq 3
    end

    describe "when employee is even" do
      it "creates mystery partners while making sure each employee belongs to different department" do
        service.call
        expect(MysteryPartner.count).to eq 3
        mystery_partners1 = MysteryPartner.first # 1st mystery lunch partners
        mystery_partners2 = MysteryPartner.last(2).first # 2nd mystery lunch partners
        mystery_partners3 = MysteryPartner.last # 3rd mystery lunch partners
        expect(mystery_partners1.employee1_department_id).not_to eq mystery_partners1.employee2_department_id
        expect(mystery_partners2.employee1_department_id).not_to eq mystery_partners2.employee2_department_id
        expect(mystery_partners3.employee1_department_id).not_to eq mystery_partners3.employee2_department_id
      end

      it "creates mystery partners while making sure each employee in lunch partnership haven't had lunch together in past 3 months" do
        partners_had_lunch_together_last_month = MysteryPartner.create(employee1_id: employee_1.id, employee2_id: employee_2.id,  employee1_department_id: department_1.id, employee2_department_id: department_2.id, created_at: Time.new(2022, 12, 12))

        service.call
        mystery_partners = MysteryPartner.where("created_at >= ?", Time.zone.now.beginning_of_month)
        expect(mystery_partners.count).to eq 3
        mystery_partner1 = mystery_partners[0] # 1st mystery lunch partners
        mystery_partner2 = mystery_partners[1] # 2nd mystery lunch partners
        mystery_partner3 = mystery_partners[2] # 3rd mystery lunch partners

        expect([mystery_partner1.employee1_id, mystery_partner1.employee2_id]).not_to eq [partners_had_lunch_together_last_month.employee1_id, partners_had_lunch_together_last_month.employee2_id]
        expect([mystery_partner1.employee2_id, mystery_partner1.employee2_id]).not_to eq [partners_had_lunch_together_last_month.employee1_id, partners_had_lunch_together_last_month.employee2_id]

        expect([mystery_partner2.employee1_id, mystery_partner2.employee2_id]).not_to eq [partners_had_lunch_together_last_month.employee1_id, partners_had_lunch_together_last_month.employee2_id]
        expect([mystery_partner2.employee2_id, mystery_partner2.employee2_id]).not_to eq [partners_had_lunch_together_last_month.employee1_id, partners_had_lunch_together_last_month.employee2_id]

        expect([mystery_partner3.employee1_id, mystery_partner3.employee2_id]).not_to eq [partners_had_lunch_together_last_month.employee1_id, partners_had_lunch_together_last_month.employee2_id]
        expect([mystery_partner3.employee1_id, mystery_partner3.employee2_id]).not_to eq [partners_had_lunch_together_last_month.employee1_id, partners_had_lunch_together_last_month.employee2_id]
      end
    end

    describe "when employee is odd" do
      let!(:employee_7) { FactoryBot.create(:employee, department_id: department_4.id) }

      it "remaining employee is added to existing partner (3 people mystery lunch) who haven't had lunch together in last 3 months" do
        service.call
        mystery_partners = MysteryPartner.where("created_at >= ?", Time.zone.now.beginning_of_month)
        expect(mystery_partners.count).to eq 3
        expect(MysteryPartner.where("employee3_id IS NOT NULL").count).to eq 1
      end
    end
  end
end
