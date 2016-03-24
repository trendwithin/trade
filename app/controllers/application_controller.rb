class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_parameter_sanitizer, if: :devise_controller?

  protected
    def after_sign_in_path_for(resource)
      static_pages_dummy_page_path
    end

    def configure_parameter_sanitizer
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:signin, :username, :email, :remember_me) }
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password)}
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :bio, :first_name, :last_name, :location, :website, :current_password) }
    end
end
