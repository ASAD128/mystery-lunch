require 'rails_helper'

RSpec.describe "Admin::DepartmentsControllers", type: :request do
  it "returns a successful response" do
    get '/admin/departments'
    expect(response).to be_successful
  end
end
