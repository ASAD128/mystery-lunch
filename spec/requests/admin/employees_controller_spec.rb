require 'rails_helper'

RSpec.describe "Admin::EmployeesControllers", type: :request do
  describe "GET /index" do

    it "returns a successful response" do
      get '/admin/employees'
      expect(response).to be_successful
    end
  end
end
