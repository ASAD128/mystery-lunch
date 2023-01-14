module Admin
  class BaseController < ApplicationController
    # check_authorization unless: :devise_controller?

    before_action :authenticate_user!

    before_action :configure_permitted_parameters, if: :devise_controller?

    before_action :check_if_admin

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) do |user_params|
        user_params.permit(:email, :password, :password_confirmation, :admin)
      end
    end

    private

    def check_if_admin
      redirect_to root_path unless current_user.admin?
    end
  end
end