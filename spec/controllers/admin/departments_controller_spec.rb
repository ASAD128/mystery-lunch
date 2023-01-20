require 'rails_helper'

RSpec.describe Admin::DepartmentsController do

  let!(:department) { Department.create(name: 'Risk') }
  let!(:user) { FactoryBot.create(:user) }

  let(:valid_attributes) {
    { name: 'Finance' }
  }

  let(:invalid_attributes) {
    { name: nil }
  }

  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end


  describe "GET #index" do
    context "when not authenticated" do
      it "redirects to the login page" do
        user = create(:user)
        logout user # log out the current user (if any)
        get 'index'
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when authenticated" do
      it "returns a success response" do
        user = create(:user)
        sign_in user # sign in a user
        get 'index'
        expect(response).to be_successful
      end
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      user = create(:user)
      sign_in user # log out the current user (if any)

      employee = Department.create! valid_attributes
      get 'show', params: {id: employee.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Employee" do
        user = create(:user)
        sign_in user # log out the current user (if any)

        expect {
          post :create, params: {department: valid_attributes}
        }.to change(Department, :count).by(1)
      end
    end
  end
end

