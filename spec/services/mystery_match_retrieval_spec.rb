require 'rails_helper'

RSpec.describe MysteryMatchRetrieval do

  let(:service) { described_class.new }
  let!(:user_1) { Employee.create(name: 'John Doe', department_id: 1) }
  let!(:user_2) { Employee.create(name: 'John Doe2', department_id: 1) }
  let!(:user_3) { Employee.create(name: 'John Doe3', department_id: 2) }
  let!(:user_4) { Employee.create(name: 'John Doe4', department_id: 2) }
  let!(:user_5) { Employee.create(name: 'John Doe5', department_id: 1) }
  let!(:user_6) { Employee.create(name: 'John Doe6', department_id: 2) }


  describe '#call' do
    it 'create mystery match partners and save result in DB' do
      service.call
      expect(MysteryPartner.count).to eq 3
    end
  end
end
