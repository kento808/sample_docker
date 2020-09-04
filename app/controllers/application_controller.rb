class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :profile, :sex])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :password, :password_confirmation, :profile, :sex])
    end
end
